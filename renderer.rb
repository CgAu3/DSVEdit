
require 'oily_png'

class Renderer
  attr_reader :fs
  
  def initialize(fs)
    @fs = fs
  end
  
  def render_room(folder, room)
    rendered_layers = []
    
    room.z_ordered_layers.each do |layer|
      rendered_layers << render_layer(folder, layer, room)
    end
    
    # TODO: find a proper way of determining what the main collision layer is. just looking at the z-index doesn't seem sufficient.

    # make the image encompass all the layers
    max_width = 0
    max_height = 0
    rendered_layers.each do |layer|
      max_width = layer.width if layer.width > max_width
      max_height = layer.height if layer.height > max_height
    end
    
    rendered_level = ChunkyPNG::Image.new(max_width, max_height, ChunkyPNG::Color::BLACK)
    rendered_layers.each do |layer|
      rendered_level.compose!(layer)
    end
    
    max_width_in_screens = max_width / SCREEN_WIDTH_IN_PIXELS
    max_height_in_screens = max_height / SCREEN_HEIGHT_IN_PIXELS
    
    filename = "#{folder}/#{room.area_name}/Rendered Rooms/#{room.filename}.png"
    FileUtils::mkdir_p(File.dirname(filename))
    rendered_level.save(filename)
    puts "Wrote #{filename}"
  end
  
  def render_layer(folder, layer, room)
    rendered_layer = ChunkyPNG::Image.new(layer.width*16*16, layer.height*16*12, ChunkyPNG::Color::TRANSPARENT)
    
    tileset_filename = "#{folder}/#{room.area_name}/Tilesets/#{layer.tileset_filename}.png"
    #puts "#{room.area_index}-#{room.sector_index}-#{room.room_index}"
    fs.load_overlay(AREA_INDEX_TO_OVERLAY_INDEX[room.area_index][room.sector_index])
    tileset = get_tileset(layer.ram_pointer_to_tileset_for_layer, room.palette_offset, room.graphic_tilesets_for_room, layer.colors_per_palette, layer.collision_tileset_ram_pointer, tileset_filename)
    
    layer.tiles.each_with_index do |tile, index_on_level|
      x_on_tileset = tile.index_on_tileset % 16
      y_on_tileset = tile.index_on_tileset / 16
      x_on_level = index_on_level % (layer.width*16)
      y_on_level = index_on_level / (layer.width*16)
      
      tile_gfx = tileset.crop(x_on_tileset*16, y_on_tileset*16, 16, 16)
      
      if tile.horizontal_flip
        tile_gfx.mirror!
      end
      if tile.vertical_flip
        tile_gfx.flip!
      end
      
      rendered_layer.compose!(tile_gfx, x_on_level*16, y_on_level*16)
    end
    
    # TODO: OPACITY
    return rendered_layer
  end
  
  def generate_palettes(palette_data_start_offset, colors_per_palette)
    if palette_data_start_offset.nil?
      palette = [ChunkyPNG::Color.rgba(0, 0, 0, 0)] * colors_per_palette
      palette_list = [palette] * 128 # 128 is the maximum number of palettes
      return palette_list
    end
    
    number_of_palettes = fs.read(palette_data_start_offset+2,1).unpack("C*").first
    if number_of_palettes == 1
      # When this value is 1, it means this tileset has no palette of its own. Instead it simply leeches off the palette of whatever the previously loaded room was.
      # Since we can't know what room the player was in last, we can instead simply use the palette of whatever room this room's first door leads to.
      # This should work fine in theory. But there's a tiny possibility of one of the first door leading to an unused, inaccessible room, which may not have the right palette.
      
      # TODO: the above can only be done once functions are organized in such a way that we can get the doors for this room and the palette of another room.
      # the below is just a hack. it works for the only room in dawn of sorrow that needs this anyway.
      number_of_palettes = 0x40
      palette_data_start_offset -= 0x804
    end
    
    #puts "graphic_tile_data_start_offset: %08X" % graphic_tile_data_start_offset
    palette_data_start_offset += 4 # Skip the first 4 bytes, as they contain the length of this palette page, not the palette data itself.

    #puts "palette_data_start_offset: %08X" % palette_data_start_offset
    #puts "number_of_palettes: %d" % number_of_palettes
    palette_list = []
    (0..number_of_palettes).each do |palette_index| # todo: cache palettes
      palette_data = fs.read(palette_data_start_offset + 32*palette_index, colors_per_palette*2)
      palette = palette_data.scan(/.{2}/m).map do |color|
        color = color.unpack("v*").first
        # these two bytes hold the rgb data for the color in this format:
        # ?bbbbbgggggrrrrr
        # the ? is unknown.
        #unknown_bit = (color >> 15) & 0b0000_0000_0000_0001
        blue_bits   = (color >> 10) & 0b0000_0000_0001_1111
        green_bits  = (color >> 5)  & 0b0000_0000_0001_1111
        red_bits    =  color        & 0b0000_0000_0001_1111
        
        red = (red_bits / 32.0 * 255).to_i
        green = (green_bits / 32.0 * 255).to_i
        blue = (blue_bits / 32.0 * 255).to_i
        alpha = 255
        ChunkyPNG::Color.rgba(red, green, blue, alpha)
      end
      palette_list << palette
    end
    
    palette_list
  end
  
  def ensure_tilesets_exist(folder, room)
    room.layers.each do |layer|
      tileset_filename = "#{folder}/#{room.area_name}/Tilesets/#{layer.tileset_filename}.png"
      if File.exist?(tileset_filename)
        next
      else
        render_tileset(layer.ram_pointer_to_tileset_for_layer, room.palette_offset, room.graphic_tilesets_for_room, layer.colors_per_palette, tileset_filename)
      end
    end
  end
  
  def get_tileset(pointer_to_tileset_for_layer, palette_offset, graphic_tilesets_for_room, colors_per_palette, collision_tileset_offset, tileset_filename)
    if File.exist?(tileset_filename)
      ChunkyPNG::Image.from_file(tileset_filename)
    else
      render_tileset(pointer_to_tileset_for_layer, palette_offset, graphic_tilesets_for_room, colors_per_palette, collision_tileset_offset, tileset_filename)
    end
  end
  
  def render_tileset(tileset_offset, palette_offset, graphic_tilesets_for_room, colors_per_palette, collision_tileset_offset, output_filename)
    tileset_width_in_blocks = 16
    tileset_height_in_blocks = 64
    rendered_tileset = ChunkyPNG::Image.new(tileset_width_in_blocks*16, tileset_height_in_blocks*16, ChunkyPNG::Color::TRANSPARENT)

    length_of_tileset_in_bytes = tileset_width_in_blocks*tileset_height_in_blocks*4
    tileset = fs.read(tileset_offset, length_of_tileset_in_bytes-4)
    #puts "Tileset data starting at %08X" % tileset_offset
    tileset = "\x00\x00\x00\x00" + tileset
    
    #puts "palette_offset: %08X" % (palette_offset || 0)
    palette_list = generate_palettes(palette_offset, colors_per_palette)
    tileset_data = tileset.unpack("C*")
    
    if graphic_tilesets_for_room.nil?
      return render_collision_tileset(collision_tileset_offset, output_filename)
    end

    tileset_data.each_slice(4).each_with_index do |tile_data, i|
      #puts "tile_data: #{tile_data.each_byte.to_a.map{|x| "%02X" % x}}"
      tile_index_on_page, tile_page, extra_bits, palette_index = tile_data
      #puts "palette_index: #{palette_index}"
      
      if tile_index_on_page == 0 && tile_page == 0 && extra_bits == 0 && palette_index == 0
        next # if it's all 0s then it's a blank tile, don't render it at all.
      end
      
      # The bits below are always 00. The below code was ran on every room in the game with no exceptions raised.
      #unknown1 = tile_index_on_page & 0b11000000
      #unknown2 = tile_page & 0b00001111
      #unknown3 = extra_bits & 0b11111000
      #if unknown1 != 0
      #  raise "unknown1: #{unknown1}"
      #end
      #if unknown2 != 0
      #  raise "unknown2: #{unknown2}"
      #end
      #if unknown3 != 0
      #  raise "unknown3: #{unknown3}"
      #end
      
      tile_index_on_page = tile_index_on_page & 0b00111111 # get rid of top 2 bits. they're sometimes set, but they seem to be for something else besides the tile index. TODO: figure out what those 2 are for.
      horizontal_flip = ((extra_bits >> 1) & 0b00000001) != 0
      vertical_flip = ((extra_bits >> 2) & 0b00000001) != 0
      most_significant_bit = extra_bits & 0b00000001
      tile_page = tile_page >> 4
      tile_page = tile_page | (most_significant_bit << 4)
      
      if graphic_tilesets_for_room.nil?
        graphic_tile_data_file = nil
      else
        graphic_tile_data_file = graphic_tilesets_for_room[tile_page]
        if graphic_tile_data_file.nil?
          next # TODO: figure out why this sometimes happens.
        end
      end
      
      if palette_index == 0xFF # TODO. 255 seems to have some special meaning besides an actual palette index.
        palette_index = 0x00
      end
      palette = palette_list[palette_index]
      if palette.nil?
        puts "Palette index #{palette_index} out of range, tileset #{output_filename}"
        next # TODO: figure out why this sometimes happens.
      end
      
      graphic_tile = render_graphic_tile(graphic_tile_data_file, palette, tile_index_on_page)
      
      if horizontal_flip
        graphic_tile.mirror!
      end
      if vertical_flip
        graphic_tile.flip!
      end
      
      x_on_tileset = i % 16
      y_on_tileset = i / 16
      rendered_tileset.compose!(graphic_tile, x_on_tileset*16, y_on_tileset*16)
    end
    
    FileUtils::mkdir_p(File.dirname(output_filename))
    rendered_tileset.save(output_filename, :fast_rgba)
    puts "Wrote #{output_filename}"
    return rendered_tileset
  end
  
  def render_collision_tileset(collision_tileset_offset, output_filename)
    if File.exist?(output_filename)
      return ChunkyPNG::Image.from_file(output_filename)
    end
    
    tileset_width_in_blocks = 16
    tileset_height_in_blocks = 64
    rendered_tileset = ChunkyPNG::Image.new(tileset_width_in_blocks*16, tileset_height_in_blocks*16, ChunkyPNG::Color::TRANSPARENT)

    length_of_tileset_in_bytes = tileset_width_in_blocks*tileset_height_in_blocks*4
    collision_tileset = fs.read(collision_tileset_offset, length_of_tileset_in_bytes-4)
    collision_tileset = "\x00\x00\x00\x00" + collision_tileset
    collision_tileset_data = collision_tileset.unpack("C*")

    collision_tileset_data.each_slice(4).each_with_index do |tile_collision_data, i|
      collision_data, unk1, unk2, unk3 = tile_collision_data
      
      graphic_tile = ChunkyPNG::Image.new(16, 16, ChunkyPNG::Color::TRANSPARENT)
      
      is_slope = (collision_data & 0b11110000) > 0
      
      if is_slope
        slope_extra_check   = (collision_data & 0b00000001) > 0
        vertical_flip       = (collision_data & 0b00000010) > 0
        horizontal_flip     = (collision_data & 0b00000100) > 0
        is_gradual_slope    = (collision_data & 0b10000000) > 0
        not_a_half_slope    = (collision_data & 0b01000000) > 0
        slope_piece         = (collision_data & 0b00110000) >> 4
        
        if slope_extra_check && slope_piece > 0 && !is_gradual_slope
          graphic_tile.rect(0, 0, 15, 4, stroke_color = ChunkyPNG::Color::BLACK, fill_color = ChunkyPNG::Color::BLACK)
        elsif slope_extra_check
          if is_gradual_slope && not_a_half_slope
            x_offset = slope_piece*16
            width = 16*4
          elsif is_gradual_slope
            x_offset = slope_piece/2*16
            width = 16*2
          else
            if slope_piece > 0
              # ???
              x_offset = 0
              width = 16
            else
              x_offset = 0
              width = 16
            end
          end
          if vertical_flip
            x_end = width-1
            y_end = 0
          else
            x_end = 0
            y_end = 15
          end
          graphic_tile.polygon([0-x_offset, 0, width-1-x_offset, 15, x_end-x_offset, y_end], stroke_color = ChunkyPNG::Color::BLACK, fill_color = ChunkyPNG::Color::BLACK)
        
          if horizontal_flip
            graphic_tile.mirror!
          end
        end
      else
        has_top              = (collision_data & 0b00000001) > 0
        has_sides_and_bottom = (collision_data & 0b00000010) > 0
        is_damage            = (collision_data & 0b00000100) > 0
        is_water             = (collision_data & 0b00001000) > 0
        
        color = ChunkyPNG::Color::BLACK
        if is_damage
          color = ChunkyPNG::Color.rgba(255, 0, 0, 255)
        end
        if is_water
          color = ChunkyPNG::Color.rgba(0, 0, 255, 255)
        end
        
        if has_top && has_sides_and_bottom
          graphic_tile.rect(0, 0, 15, 15, stroke_color = color, fill_color = color)
        elsif has_top
          graphic_tile.rect(0, 0, 4, 4, stroke_color = color, fill_color = color)
        elsif has_sides_and_bottom
          graphic_tile.polygon([0, 0, 7, 7, 15, 0, 15, 15, 0, 15], stroke_color = color, fill_color = color)
        end
      end
      
      x_on_tileset = i % 16
      y_on_tileset = i / 16
      rendered_tileset.compose!(graphic_tile, x_on_tileset*16, y_on_tileset*16)
    end
    
    FileUtils::mkdir_p(File.dirname(output_filename))
    rendered_tileset.save(output_filename, :fast_rgba)
    puts "Wrote #{output_filename}"
    return rendered_tileset
  end
  
  def render_graphic_tile(graphic_tile_data_file, palette, tile_index_on_page)
    graphic_tile = ChunkyPNG::Image.new(16, 16, ChunkyPNG::Color::TRANSPARENT)
    
    if graphic_tile_data_file.nil? || palette.nil?
      # This room has no graphics, so just return a black tile. Could be a save room, warp room, transition room, etc.
      # TODO: instead it would be better to use the debug squares for these rooms so you can see what's what.
      
      graphic_tile = ChunkyPNG::Image.new(16, 16, ChunkyPNG::Color.rgba(255, 0, 0, 255))
      return graphic_tile
    end
    
    x_block_on_tileset = tile_index_on_page % 8
    y_block_on_tileset = tile_index_on_page / 8
    if palette.length == 16
      size_of_block_in_bytes = 16 * 16 / 2 # 16 pixels tall, 16 pixels wide, each byte has 2 pixels in it
    elsif palette.length == 256
      size_of_block_in_bytes = 16 * 16 # 16 pixels tall, 16 pixels wide, each byte has 1 pixel in it
    else
      raise "Unknown palette length: #{palette.length}"
    end
    size_of_row_in_bytes = 8 * size_of_block_in_bytes
    
    if palette.length == 16
      bytes_per_16_pixels = 8
    elsif palette.length == 256
      bytes_per_16_pixels = 16
    else
      raise "Unknown palette length: #{palette.length}"
    end
    
    offset = y_block_on_tileset*size_of_row_in_bytes + x_block_on_tileset*bytes_per_16_pixels
    pixel_on_tile = 0
    (0..15).each do |i|
      pixels_for_chunky = []
      
      fs.rom[graphic_tile_data_file[:start_offset] + offset, bytes_per_16_pixels].each_byte do |byte|
        if palette.length == 16
          pixels = [byte & 0b00001111, byte >> 4] # get the low 4 bits, then the high 4 bits (it's reversed). each is one pixel, two pixels total inside this byte.
        elsif palette.length == 256
          pixels = [byte]
        else
          raise "Unknown palette length: #{palette.length}"
        end
        
        pixels.each do |pixel|
          x_pixel_on_tile = pixel_on_tile % 16
          y_pixel_on_tile = pixel_on_tile / 16
          pixel_on_tile += 1
          
          if pixel == 0 # transparent
            pixels_for_chunky << ChunkyPNG::Color::TRANSPARENT
          else
            pixel_color = palette[pixel]
            pixels_for_chunky << pixel_color
          end
        end
      end
      
      graphic_tile.replace_row!(i, pixels_for_chunky)
      offset += 8 * bytes_per_16_pixels
    end
    
    return graphic_tile
  end
  
  def render_map(map, scale = 1)
    map_width_in_blocks = 64
    map_height_in_blocks = 48
    map_image_width = map_width_in_blocks*4 + 1
    map_image_height = map_height_in_blocks*4 + 1
    fill_img = ChunkyPNG::Image.new(map_image_width, map_image_height, ChunkyPNG::Color::TRANSPARENT)
    lines_img = ChunkyPNG::Image.new(map_image_width, map_image_height, ChunkyPNG::Color::TRANSPARENT)
    
    fill_color          = ChunkyPNG::Color.rgba(*MAP_FILL_COLOR)
    save_fill_color     = ChunkyPNG::Color.rgba(*MAP_SAVE_FILL_COLOR)
    warp_fill_color     = ChunkyPNG::Color.rgba(*MAP_WARP_FILL_COLOR)
    secret_fill_color   = ChunkyPNG::Color.rgba(*MAP_SECRET_FILL_COLOR)
    entrance_fill_color = ChunkyPNG::Color.rgba(*MAP_ENTRANCE_FILL_COLOR)
    line_color          = ChunkyPNG::Color.rgba(*MAP_LINE_COLOR)
    door_color          = ChunkyPNG::Color.rgba(*MAP_DOOR_COLOR)
    door_center_color   = ChunkyPNG::Color.rgba(*MAP_DOOR_CENTER_PIXEL_COLOR)
  
    wall_pixels = [line_color]*5
    door_pixels = [line_color, door_color, door_center_color, door_color, line_color]
  
    # 25 pixels per tile. But they overlap, so the left and top of a tile overlaps the right and bottom of other tiles.
    i = 0
    map.tiles.each do |tile|
      if tile.is_blank && !tile.left_door && !tile.left_wall && !tile.top_door && !tile.top_wall && !tile.right_door && !tile.right_wall && !tile.bottom_door && !tile.bottom_wall
        i += 1
        next
      end
      
      color = if tile.is_blank
        ChunkyPNG::Color::TRANSPARENT
      elsif tile.is_entrance
        entrance_fill_color
      elsif tile.is_warp
        warp_fill_color
      elsif tile.is_secret
        secret_fill_color
      elsif tile.is_save
        save_fill_color
      else
        fill_color
      end
      
      fill_tile = ChunkyPNG::Image.new(5, 5, color)
      lines_tile = ChunkyPNG::Image.new(5, 5, ChunkyPNG::Color::TRANSPARENT)
      
      if tile.left_door
        lines_tile.replace_column!(0, door_pixels)
      elsif tile.left_wall
        lines_tile.replace_column!(0, wall_pixels)
      end
      
      if tile.right_door # Never used in game because it would always get overwritten by the tile to the right.
        lines_tile.replace_column!(4, door_pixels)
      elsif tile.right_wall
        lines_tile.replace_column!(4, wall_pixels)
      end
      
      if tile.top_door
        lines_tile.replace_row!(0, door_pixels)
      elsif tile.top_wall
        lines_tile.replace_row!(0, wall_pixels)
      end
      
      if tile.bottom_door # Never used in game because it would always get overwritten by the tile below.
        lines_tile.replace_row!(4, door_pixels)
      elsif tile.bottom_wall
        lines_tile.replace_row!(4, wall_pixels)
      end
      
      fill_img.compose!(fill_tile, tile.x_pos*4, tile.y_pos*4)
      lines_img.compose!(lines_tile, tile.x_pos*4, tile.y_pos*4)
      
      i += 1
    end
    
    img = ChunkyPNG::Image.new(map_image_width, map_image_height, ChunkyPNG::Color::TRANSPARENT)
    img.compose!(fill_img, 0, 0)
    img.compose!(lines_img, 0, 0)
    unless scale == 1
      img.resample_nearest_neighbor!(map_image_width*scale, map_image_height*scale)
    end
    
    return img
  end
end
