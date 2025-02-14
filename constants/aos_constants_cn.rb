
GAME = "aos"
REGION = :cn
LONG_GAME_NAME = "晓月圆舞曲"

AREA_LIST_RAM_START_OFFSET = 0x0800198C # Technically not a list, this points to code that has the the area hard coded, since AoS only has one area.

AREA_INDEX_TO_OVERLAY_INDEX = {
  0 => {
     0 => nil,
     1 => nil,
     2 => nil,
     3 => nil,
     4 => nil,
     5 => nil,
     6 => nil,
     7 => nil,
     8 => nil,
     9 => nil,
    10 => nil,
    11 => nil,
    12 => nil,
  }
}

AREAS_OVERLAY = nil

AREA_INDEX_TO_AREA_NAME = {
   0 => "德库拉的城堡"
}

SECTOR_INDEX_TO_SECTOR_NAME = {
   0 => {
     0 => "荒城回廊",
     1 => "礼拜堂",
     2 => "恶魔城藏书库",
     3 => "舞踏馆",
     4 => "幻梦宫",
     5 => "忘却庭院",
     6 => "时计塔",
     7 => "地下水域",
     8 => "竞技场",
     9 => "恶魔城最上阶",
    10 => "不可侵洞穴",
    11 => "混沌区域",
    12 => "Hardcoded rooms",
  }
}

#HARDCODED_UNUSED_ROOM_IDS = [
#  0x084FA920,
#  0x084FA9B8,
#  0x084FAA48,
#  0x084FAAE0,
#  0x084FAB78,
#  0x084FAC10,
#  0x084FACA8,
#  0x084FAD40,
#  0x084FADD8,
#  0x084FAE70,
#  0x084FAF08,
#  0x084FAF90
#]


HARDCODED_ROOM_IDS = [
  0x084F9FA4, # bad end

  0x084FB0B4, #boss rush
  0x084FB14C,
  0x084FB1E4,
  0x084FB27C,
  0x084FB324,
  0x084FB3BC,
  0x084FB454,
  0x084FB4EC,
  0x084FB5A4,
  0x084FB63C,
  0x084FB6D4,
  0x084FB75C
]

NOTHING_ENTITY_TYPE = 0
ENEMY_ENTITY_TYPE = 1
SPECIAL_OBJECT_ENTITY_TYPE = 2
CANDLE_ENTITY_TYPE = 3
PICKUP_ENTITY_TYPE = 4
#PICKUP_ENTITY_GOOD_END_TYPE = 5
#PICKUP_ENTITY_ALL_SOUL_TYPE = 6

ENTITY_TYPE_DESCRIPTIONS = {
  0 => "无",
  1 => "怪物",
  2 => "场景 物体",
  3 => "蜡烛",
  4 => "可拾取道具",
  5 => "二周目道具",
  6 => "全魂收集道具",
}

ENEMY_IDS = (0x00..0x70).to_a
COMMON_ENEMY_IDS = (0x00..0x69).to_a
BOSS_IDS = (0x6A..0x70).to_a

BOSS_DOOR_SUBTYPE = 0x02
BOSS_ID_TO_BOSS_INDEX = {
  0x21 => 0x0B, # 大骷髅
  0x36 => 0x0A, # 曼提利亚
  0x3C => 0x0F, # 大装甲
  0x45 => 0x0C, # 巨人
  0x6A => 0x04, # 收集者
  0x6B => 0x01, # 死神
  0x6C => 0x05, # 死人军团
  0x6D => 0x06, # 巴洛尔
  0x6E => 0x02, # 尤里乌斯
  0x6F => 0x00, # 格拉罕
  0x70 => 0x07, # 混沌
}

WOODEN_DOOR_SUBTYPE = 0x00

AREA_NAME_SUBTYPE = nil

SAVE_POINT_SUBTYPE = 0x1C
WARP_POINT_SUBTYPE = 0x1F

COLOR_OFFSETS_PER_256_PALETTE_INDEX = 16

ENEMY_DNA_RAM_START_OFFSET = 0x080E6E50
ENEMY_DNA_FORMAT = [
  # length: 36
  [4, "Create Code"],
  [4, "Update Code"],
  [2, "Item 1"],
  [2, "Item 2"],
  [2, "HP"],
  [2, "MP"],
  [2, "EXP"],
  [1, "出魂几率*"],
  [1, "攻击"],
  [1, "防御"],
  [1, "道具1几率*"],
  [1, "道具2几率*"],
  [1, "魂类型"],
  [1, "魂ID"],
  [1, "Unknown 11"],
  [2, "弱点", :bitfield],
  [2, "抗性", :bitfield],
  [2, "Unknown 12"],
  [2, "Unknown 13"],
  [2, "Unknown 14"],
]
ENEMY_DNA_BITFIELD_ATTRIBUTES = {
  "弱点" => [
    "切割",
    "火",
    "水",
    "雷",
    "暗",
    "光",
    "毒",
    "诅咒",
    "石化",
    "Unknown 10",
    "Unknown 11",
    "杀人披风",
    "Unknown 13",
    "Unknown 14",
    "Unknown 15",
    "Unknown 16",
  ],
  "抗性" => [
    "切割",
    "火",
    "水",
    "雷",
    "暗",
    "光",
    "毒",
    "诅咒",
    "石化",
    "Unknown 10",
    "时间静止",
    "Unknown 12",
    "Unknown 13",
    "Unknown 14",
    "Unknown 15",
    "Unknown 16",
  ],
}

TEXT_LIST_START_OFFSET = 0x084D2D44  #not used for cn
TEXT_RANGE = (0..0xB4E)
TEXT_REGIONS = {
  "Character Names" => (0..0xA),
  "Events" => (0xB..0x5A),
  "Item Names" => (0x5B..0xE2),
  "Red Soul Names" => (0xE3..0x119),
  "Unused Blue Soul Name" => (0x11A..0x11A),
  "Blue Soul Names" => (0x11B..0x132),
  "Yellow Soul Names" => (0x133..0x155),
  "Ability Soul Names" => (0x156..0x15B),
  "Item Descriptions" => (0x15C..0x1E3),
  "Red Soul Descriptions" => (0x1E4..0x21A),
  "Unused Blue Soul Description" => (0x21B..0x21B),
  "Blue Soul Descriptions" => (0x21C..0x233),
  "Yellow Soul Descriptions" => (0x234..0x256),
  "Ability Soul Descriptions" => (0x257..0x25C),
  "Enemy Names" => (0x25D..0x2CD),
  "Enemy Descriptions" => (0x2CE..0x33E),
  "Menus" => (0x33F..0x392),
  "Music Names" => (0x393..0x3AF),
  "Menus 2" => (0x3B0..0x3B6),
  "Uncategorized" => (0x3B7..0x3C3),
  "French" => (0x3C4..0xB87),
  "German" => (0x788..0xB4B),
  "Language Names" => (0xB4C..0xB4E),
}
TEXT_REGIONS_OVERLAYS = {
  "Character Names" => nil,
  "Events" => nil,
  "Item Names" => nil,
  "Red Soul Names" => nil,
  "Unused Blue Soul Name" => nil,
  "Blue Soul Names" => nil,
  "Yellow Soul Names" => nil,
  "Ability Soul Names" => nil,
  "Item Descriptions" => nil,
  "Red Soul Descriptions" => nil,
  "Unused Blue Soul Description" => nil,
  "Blue Soul Descriptions" => nil,
  "Yellow Soul Descriptions" => nil,
  "Ability Soul Descriptions" => nil,
  "Enemy Names" => nil,
  "Enemy Descriptions" => nil,
  "Menus" => nil,
  "Music Names" => nil,
  "Menus 2" => nil,
  "Uncategorized" => nil,
  "French" => nil,
  "German" => nil,
  "Language Names" => nil,
}
STRING_DATABASE_START_OFFSET = 0x080E7F38
STRING_DATABASE_ORIGINAL_END_OFFSET = 0x080F58D6
STRING_DATABASE_ALLOWABLE_END_OFFSET = STRING_DATABASE_ORIGINAL_END_OFFSET
TEXT_COLOR_NAMES = {
  0x00 => "TRANSPARENT",
  0x01 => "WHITE",
  0x02 => "GREY",
  0x03 => "PINK",
  0x04 => "BROWN",
  0x05 => "AZURE",
  0x06 => "DARKBLUE",
  0x07 => "YELLOW",
  0x08 => "ORANGE",
  0x09 => "LIGHTGREEN",
  0x0A => "GREEN",
  0x0B => "BRIGHTPINK",
  0x0C => "PURPLE",
  0x0D => "BROWN2",
  0x0E => "BLACK",
  0x0F => "BLACK2",
}

SPECIAL_OBJECT_IDS = (0..0x37)
SPECIAL_OBJECT_CREATE_CODE_LIST = 0x084BCD5C	# -E0
SPECIAL_OBJECT_UPDATE_CODE_LIST = 0x084BCE3C    #may not right

ITEM_LOCAL_ID_RANGES = {
  0x02 => (0x00..0x1F), # consumable
  0x03 => (0x00..0x3A), # weapon
  0x04 => (0x00..0x2C), # armor
}
ITEM_GLOBAL_ID_RANGE = (0..0x87)
SKILL_GLOBAL_ID_RANGE = (0x88..0xFA)
SKILL_LOCAL_ID_RANGE = nil # souls in AoS are split into multiple different types.
PICKUP_GLOBAL_ID_RANGE = (0..0xFA)

PICKUP_SUBTYPES_FOR_ITEMS = (0x02..0x04)
PICKUP_SUBTYPES_FOR_SKILLS = (0x05..0x08)
PICKUP_SUBTYPES_FOR_UNKNOWN = (0x09..0xFF)

NEW_GAME_STARTING_AREA_INDEX_OFFSET = nil
NEW_GAME_STARTING_SECTOR_INDEX_OFFSET = 0x084BCCF0
NEW_GAME_STARTING_ROOM_INDEX_OFFSET = 0x084BCCF1
NEW_GAME_STARTING_X_POS_OFFSET = 0x084BCCF6
NEW_GAME_STARTING_Y_POS_OFFSET = 0x084BCCF8

GAME_TRANSMIT_ROOM_OFFSET = 0x080B54FC

#TRANSITION_ROOM_LIST_POINTER = 0x084E5268
TRANSITION_ROOM_LIST_POINTER_HARDCODED_LOCATIONS = [0x080017D8, 0x080017F8]
#us is [0x080017DC, 0x080017FC](0x0850E968), cn is [0x080017D8, 0x080017F8](0x084E5268)
FAKE_TRANSITION_ROOMS = []

ITEM_ICONS_PALETTE_POINTER = 0x081CFAC8
GLYPH_ICONS_PALETTE_POINTER = nil
ITEM_ICONS_GFX_POINTERS = [0x081A0CD4, 0x081A2CD8, 0x081A4CDC]

CONSUMABLE_FORMAT = [
  # length: 16
  [2, "道具ID"],
  [2, "图标"],
  [4, "价格"],
  [1, "类型"],
  [1, "Unknown 1"],
  [2, "参数A"],
  [4, "Unused"],
]
WEAPON_FORMAT = [
  # length: 28
  [2, "道具ID"],
  [2, "图标"],
  [4, "价格"],
  [1, "攻击方式"],
  [1, "Unknown 1"],
  [1, "攻击力"],
  [1, "防御力"],
  [1, "Str属性增加"],
  [1, "Con属性增加"],
  [1, "Int属性增加"],
  [1, "Luck属性增加"],
  [2, "属性", :bitfield],
  [1, "GFX Index"],
  [1, "Sprite Index"],
  [1, "Unknown 2"],
  [1, "色盘"],
  [1, "攻击频率"],
  [1, "连击"],
  [2, "攻击音效"],
  [2, "Unknown 3"],
]
ARMOR_FORMAT = [
  # length: 20
  [2, "道具ID"],
  [2, "图标"],
  [4, "价格"],
  [1, "类型"],
  [1, "Unknown 1"],
  [1, "攻击力"],
  [1, "防御力"],
  [1, "Str属性增加"],
  [1, "Con属性增加"],
  [1, "Int属性增加"],
  [1, "Luck属性增加"],
  [2, "抗性", :bitfield],
  [1, "Unknown 2"],
  [1, "Unknown 3"],
]
RED_SOUL_FORMAT = [
  # length: 16
  [4, "Code"],
  [2, "使用动画"],
  [2, "消耗MP"],
  [1, "同屏限制"],
  [1, "Unknown 1"],
  [2, "攻击力"],
  [2, "属性", :bitfield],
  [2, "参数A"],
]
BLUE_SOUL_FORMAT = [
  # length: 12
  [4, "Code"],
  [1, "消耗MP"],
  [1, "1为按住 2为按一次R键"],
  [2, "Unknown 1"],
  [4, "Player effect/Varies"],
]
YELLOW_SOUL_FORMAT = [
  # length: 12
  [4, "Code"],
  [2, "Unknown 1"],
  [2, "Stat to raise"],
  [4, "Player effect/Stat pts"],
]
JULIUS_SKILL_FORMAT = RED_SOUL_FORMAT
ITEM_TYPES = [
  {
    name: "道具",
    list_pointer: 0x084D1D48,
    count: 0x20,
    format: CONSUMABLE_FORMAT # length 16
  },
  {
    name: "武器",
    list_pointer: 0x084D1F48,
    count: 0x3B,
    format: WEAPON_FORMAT # length 28
  },
  {
    name: "防具",
    list_pointer: 0x084D25BC,
    count: 0x2D,
    format: ARMOR_FORMAT # length 20
  },
  {
    name: "红魂",
    list_pointer: 0x080DFAE0,
    count: 0x38,
    kind: :skill,
    format: RED_SOUL_FORMAT # length: 16
  },
  {
    name: "蓝魂",
    list_pointer: 0x080DFE74,
    count: 0x19,
    kind: :skill,
    format: BLUE_SOUL_FORMAT # length: 12
  },
  {
    name: "黄魂",
    list_pointer: 0x080E0050,
    count: 0x24,
    kind: :skill,
    format: YELLOW_SOUL_FORMAT # length: 12
  },
  {
    name: "尤里乌斯技能",
    list_pointer: 0x080E0420,
    count: 0x4,
    kind: :skill,
    format: JULIUS_SKILL_FORMAT # length: 16
  },
]
ITEM_BITFIELD_ATTRIBUTES = {
  "属性" => [
    "切割",
    "火",
    "水",
    "雷",
    "暗",
    "光",
    "毒",
    "诅咒",
    "石化",
    "Unknown 10",
    "Unknown 11",
    "杀人披风",
    "伤害减半",
    "是否有硬直",
    "Unknown 15",
    "Unknown 16",
  ],
  "抗性" => [
    "切割",
    "火",
    "水",
    "雷",
    "暗",
    "光",
    "毒",
    "诅咒",
    "石化",
    "Unknown 10",
    "Unknown 11",
    "Unknown 12",
    "Unknown 13",
    "Unknown 14",
    "Unknown 15",
    "Unknown 16",
  ],
}

OVERLAY_FILE_FOR_ENEMY_AI = {}
REUSED_ENEMY_INFO = {
  0x07 => {init_code: 0x0806F090}, # killer fish
  0x08 => {init_code: 0x080F8664}, # bone pillar
  0x0B => {init_code: 0x0807620C}, # white dragon
  0x0F => {init_code: 0x08073C2C, palette_offset: 1}, # siren -> harpy
  0x10 => {palette_offset: 1}, # tiny devil
  0x11 => {init_code: 0x08091744}, # durga -> curly
  0x12 => {palette_offset: 1}, # rock armor
  0x13 => {init_code: 0x0807C898}, # giant ghost
  0x15 => {init_code: 0x080AF0A0}, # minotaur
  0x17 => {init_code: 0x08078F3C}, # arachne
  0x19 => {palette_offset: 1}, # evil butcher
  0x1C => {init_code: 0x0808801C, palette_offset: 1}, # catoblepas
  0x21 => {init_code: 0x080973CC}, # creaking skull
  0x22 => {init_code: 0x0807F6F4, palette_offset: 2, gfx_sheet_ptr_index: 1, ignore_part_gfx_page: true}, # wooden golem
  0x25 => {palette_offset: 1}, # lilith -> succubus
  0x2B => {palette_offset: 1}, # curly
  0x2D => {palette_offset: 1}, # red crow -> blue crow
  0x2E => {init_code: 0x080BA5BC}, # cockatrice
  0x30 => {init_code: 0x0808F9FC, palette_offset: 2}, # devil
  0x35 => {init_code: 0x0807F6F4, gfx_sheet_ptr_index: 1, ignore_part_gfx_page: true}, # golem
  0x36 => {init_code: 0x08072638}, # manticore
  0x37 => {init_code: 0x08084A6C, palette_offset: 1}, # gremlin => gargoyle
  0x3C => {init_code: 0x0808C5F0}, # great armor
  0x3E => {init_code: 0x080ABDBC}, # giant worm
  0x41 => {init_code: 0x080F8674}, # fish head
  0x43 => {init_code: 0x080862F0}, # triton
  0x45 => {init_code: 0x080AB79C}, # big golem
  0x47 => {init_code: 0x080ABDBC, palette_offset: 1}, # poison worm
  0x48 => {init_code: 0x0808F9FC}, # arc demon
  0x49 => {init_code: 0x080B644C, sprite: 0x081E6774}, # cagnazzo
  0x4A => {palette_offset: 1}, # ripper
  0x4B => {init_code: 0x08077C58}, # werejaguar
  0x50 => {init_code: 0x0807F6F4, palette_offset: 3, ignore_part_gfx_page: true}, # flesh golem
  0x54 => {init_code: 0x08077C58, palette_offset: 1}, # weretiger
  0x58 => {init_code: 0x080AF0A0, palette_offset: 1}, # red minotaur
  0x5B => {init_code: 0x080B644C, palette_offset: 2, sprite: 0x081F2E9C}, # skull millione
  0x5C => {init_code: 0x080973CC, palette_offset: 1}, # giant skeleton
  0x5D => {init_code: 0x080A01B8}, # gladiator
  0x60 => {init_code: 0x080979FC}, # mimic
  0x61 => {init_code: 0x0809AAB0}, # stolas
  0x62 => {init_code: 0x0806CCE0, palette_offset: 1}, # erinys -> valkyrie
  0x63 => {init_code: 0x080B644C, palette_offset: 1, sprite: 0x081E6774}, # lubicant
  0x64 => {init_code: 0x080BA5BC, palette_offset: 1}, # basilisk
  0x65 => {init_code: 0x0807F6F4, palette_offset: 1, gfx_sheet_ptr_index: 1, ignore_part_gfx_page: true}, # iron golem
  0x66 => {init_code: 0x0808F9FC, palette_offset: 1}, # demon lord
  0x67 => {init_code: 0x0808C5F0, palette_offset: 1}, # final guard
  0x68 => {init_code: 0x0808F9FC, palette_offset: 3}, # flame demon
  0x69 => {init_code: 0x0808C5F0, palette_offset: 2}, # shadow knight
  0x6A => {gfx_wrapper: 0x080F8188, sprite: 0x081DF26C, palette: 0x081D03F8}, # headhunter
  0x6B => {gfx_wrapper: 0x080F8720}, # death
  0x6C => {gfx_wrapper: 0x080F8348, sprite: 0x081E89D8, palette: 0x081D08C4}, # legion #sprite not right
  0x6D => {gfx_wrapper: 0x080F8684, sprite: 0x082036AC}, # balore #sprite not right
  0x6E => {gfx_wrapper: 0x080F87A8}, # julius
  0x6F => {init_code: 0x080F7994}, # graham
  0x70 => {gfx_wrapper: 0x080F8454, palette: 0x0820AD70}, # chaos
}
ENEMY_FILES_TO_LOAD_LIST = nil
BEST_SPRITE_FRAME_FOR_ENEMY = {
  0x00 => 0x03,
  0x01 => 0x06,
  0x06 => 0x11,
  0x07 => 0x08,
  0x0E => 0x07,
  0x10 => 0x04,
  0x16 => 0x10,
  0x17 => 0x1D,
  0x21 => 0x16,
  0x22 => 0x01,
  0x2A => 0x07,
  0x30 => 0x05,
  0x36 => 0x03,
  0x3C => 0x0E,
  0x3D => 0x08,
  0x3E => 0x07,
  0x48 => 0x07,
  0x4D => 0x0A,
  0x50 => 0x10,
  0x51 => 0x09,
  0x5C => 0x16,
  0x60 => 0x0D,
  0x65 => 0x02,
  0x66 => 0x08,
  0x67 => 0x11,
  0x68 => 0x05,
  0x69 => 0x12,
  0x6A => 0x02,
  0x6B => 0x33,
  0x6C => 0x34,
  0x70 => 0x02,
}
BEST_SPRITE_OFFSET_FOR_ENEMY = {}

COMMON_SPRITE = {desc: "Common", sprite: 0x081D3BB4, gfx_files: [0x0819E4CC], palette: 0x081CFAC8, palette_offset: 3}

OVERLAY_FILE_FOR_SPECIAL_OBJECT = {}
REUSED_SPECIAL_OBJECT_INFO = {
  0x00 => {init_code: 0x0804BF24}, # wooden door
  0x01 => {init_code: 0x080323B8}, # pushable crate TODO: sprite file can't be found, gfx and palette are fine
  0x02 => COMMON_SPRITE.merge(palette_offset: 2),
  0x03 => COMMON_SPRITE.merge(palette_offset: 2),
  0x04 => COMMON_SPRITE.merge(palette_offset: 2),
  0x05 => COMMON_SPRITE,
  0x06 => {init_code:         -1}, # darkness door
  0x07 => {init_code:         -1},
  0x08 => {init_code: 0x084FC904},
  0x09 => {init_code: 0x084FC904},
  0x0A => {init_code:         -1},
  0x0B => {init_code:         -1},
  0x0C => {init_code:         -1},
  0x0E => {init_code: 0x084FCB14}, # destructible
  0x0F => COMMON_SPRITE,
  0x11 => {init_code:         -1},
  0x12 => {init_code:         -1}, # multiple different background visuals
  0x1C => {palette_offset: 1},
  0x1F => {init_code: 0x080542B4, palette_offset: 2},
  0x20 => {init_code:         -1},
  0x22 => {palette_offset: 2},
  0x29 => {init_code: 0x084FCDD0, palette_offset: 6},
  0x2A => {init_code: 0x084FCDD0, palette_offset: 6},
  0x2D => {palette_offset: 2},
  0x2E => {palette_offset: 5},
  0x32 => {palette_offset: 1},
  0x34 => {palette_offset: 2},
  0x36 => {init_code:         -1},
}
SPECIAL_OBJECT_FILES_TO_LOAD_LIST = nil
BEST_SPRITE_FRAME_FOR_SPECIAL_OBJECT = {
  0x00 => 0x01,
  0x02 => 0x3F,
  0x03 => 0x3F,
  0x04 => 0x3F,
  0x05 => 0x7D,
  0x0F => 0x4A,
  0x1B => 0x02,
  0x1C => 0x0C,
  0x1D => 0x0B,
  0x1F => 0x0A,
  0x22 => 0x03,
  0x24 => 0x05,
  0x26 => 0x02,
  0x27 => 0x02,
  0x28 => 0x05,
  0x2B => 0x01,
  0x34 => 0x03,
}
BEST_SPRITE_OFFSET_FOR_SPECIAL_OBJECT = {
  0x00 => {x: -8},
}

OTHER_SPRITES = [
  COMMON_SPRITE,
  # (abbandoned) soma sprite 080E11C4
  # (abbandoned) soma gfx 081717CC or maybe 081674B8 or maybe 081664B4
  # (abbandoned) soma's gfx list is around 080E11D8
  # (abbandoned) palette is either 082097D4 (his palette is also the first in 0820B164 but that's not used?)

  # Soma's sprite pointer isn't normal. Using it here wouldn't show any correct frames or animations, because of the unusual way that Soma is animated by swapping the GFX in VRAM out on the fly while keeping the sprite animation still.
  # So instead we make this a no-sprite sprite so only the GFX and palette show up.
  # Soma's GFX list is at 080E11D4(us), 080DF71C(cn).
  {desc: "Soma player", sprite: 0x080DF70C, palette: 0x081CF8A0, gfx_files: [0x0813F390, 0x08141394, 0x08143398, 0x0814539C, 0x081473A0, 0x081493A4, 0x0814B3A8, 0x0814D3AC, 0x0814F3B0, 0x081513B4, 0x081533B8, 0x081553B4, 0x081573C0, 0x081593C4, 0x0815B3C8, 0x0815D3CC, 0x0815F3D0, 0x081613D4, 0x081633D8, 0x081653DC, 0x081673E0, 0x081693E4, 0x0816B3E8, 0x0816D3EC, 0x0816F3F0, 0x081713F4, 0x081733F8, 0x081753FC, 0x08177400, 0x08179404, 0x0817B408, 0x0817D40C, 0x0817F410, 0x08181414, 0x08183418, 0x0818541C, 0x08187420], no_sprite: true},
  #us is {desc: "Soma player", sprite: 0x080E11C4, palette: 0x082097D4, gfx_files: [0x081604A8, 0x081624AC, 0x081644B0, 0x081664B4, 0x081684B8, 0x0816A4BC, 0x0816C4C0, 0x0816E4C4, 0x081704C8, 0x081724CC, 0x081744D0, 0x081764D4, 0x081784D8, 0x0817A4DC, 0x0817C4E0, 0x0817E4E4, 0x081804E8, 0x081824EC, 0x081844F0, 0x081864F4, 0x081884F8, 0x0818A4FC, 0x0818C500, 0x0818E504, 0x08190508, 0x0819250C, 0x08194510, 0x08196514, 0x08198518, 0x0819A51C, 0x0819C520, 0x0819E524, 0x081A0528, 0x081A252C, 0x081A4530, 0x081A6534, 0x081A8538]},
  #Julius's GFX list is at 080E12C8(us), 080DF810(cn).
  {desc: "Julius player", sprite: 0x08211868, palette: 0x081D1A88, gfx_files: [0x081C9864, 0x081CA868, 0x081CB86C, 0x081CC870]},
  # us is {desc: "Julius player", sprite: 0x08252748, palette: 0x0820C028, gfx_files: [0x081F42A4, 0x081F52A8, 0x081F62AC, 0x081F72B0]},

  {desc: "Breakable wall graphics 0", pointer: 0x084FC904},
  {desc: "Breakable wall graphics 1", pointer: 0x084FC910},
  {desc: "Breakable wall graphics 2", pointer: 0x084FC91C},
  {desc: "Breakable wall graphics 3", pointer: 0x084FC928},
  {desc: "Breakable wall graphics 4", pointer: 0x084FC934},
  {desc: "Breakable wall graphics 5", pointer: 0x084FC940},
  {desc: "Breakable wall graphics 6", pointer: 0x084FC94C},
  {desc: "Breakable wall graphics 7", pointer: 0x084FC958},
  
  COMMON_SPRITE.merge(desc: "Candles", gfx_files: [0x82348F0], no_sprite: true),

  {desc: "Destructible 0", pointer: 0x084FCB14},
  {desc: "Destructible 1", pointer: 0x084FCB20},
  {desc: "Destructible 2", pointer: 0x084FCB2C},
  {desc: "Destructible 3", pointer: 0x084FCB38},
  {desc: "Destructible 4", pointer: 0x084FCB44},
  {desc: "Destructible 5", pointer: 0x084FCB50},
  {desc: "Destructible 6", pointer: 0x084FCB5C},
  {desc: "Destructible 7", pointer: 0x084FCB68},
  {desc: "Destructible 8", pointer: 0x084FCB74},
  {desc: "Destructible 9", pointer: 0x084FCB80},
  {desc: "Destructible A", pointer: 0x084FCB8C},
  {desc: "Destructible B", pointer: 0x084FCB98},
  {desc: "Destructible C", pointer: 0x084FCBA4},
  {desc: "Destructible D", pointer: 0x084FCBB0},
  
  {desc: "Background window", pointer: 0x084FCCA8},
  {desc: "Background rushing water", pointer: 0x084FCCC0},
  {desc: "Background moon", pointer: 0x084FCCD8},
  
  {desc: "unknown", pointer: 0x084FCDD0},
  {desc: "unknown", pointer: 0x084FCDE0},
  {desc: "Wet rock moving platform", pointer: 0x084FCDF0},
  {desc: "Clock moving platform", pointer: 0x084FCE00},
  {desc: "unknown", pointer: 0x084FCE10},
  {desc: "unknown", pointer: 0x084FCE20},
  {desc: "unknown", pointer: 0x084FCE30},
  {desc: "unknown", pointer: 0x084FCE40},
  #{desc: "unknown", pointer: 0x084FCE50}, source is error too
  
  #{desc: "xxxxxx", pointer: 0x080F794C},
  #{desc: "xxxxxx", pointer: 0x080F7958},
  {desc: "Mina event actor", pointer: 0x080F7964},
  {desc: "Arikado event actor", pointer: 0x080F7970},
  {desc: "Yoko event actor", pointer: 0x080F797C},
  {desc: "Hammer event actor", pointer: 0x080F7988},
  {desc: "Graham event actor", pointer: 0x080F79A0},
  #{desc: "J", pointer: 0x080F79AC},
  #{desc: "J 2", sprite: 0x08211868, palette: 0x081D1A88, gfx_files: [0x081C9864, 0x081CA868, 0x081CB86C, 0x081CC870]},
  #{desc: "xxxxxx", pointer: 0x080F79C4},
  #{desc: "xxxxxx", pointer: 0x080F79D0},
  #{desc: "xxxxxx", pointer: 0x080F79DC},
  {desc: "Somacula event actor", pointer: 0x080F79E8},
  

  {desc: "Prologue floating castle", gfx_files: [0x080E3864], palette: 0x08237BBC, sprite: 0x08237C74},
  {desc: "Prologue foreground objects", gfx_files: [0x080E386C], palette: 0x08237BBC, sprite: 0x08238040, palette_offset: 2},
  #us {desc: "Prologue floating castle", gfx_files: [0x08160490], palette: 0x0820972C, sprite: 0x0820CB60},
  #us {desc: "Prologue foreground objects", gfx_files: [0x08160498], palette: 0x0820972C, sprite: 0x0820CD00, palette_offset: 2},
  {desc: "Castle Corridor background bats and clouds", gfx_files: [0x081A6CF8], palette: 0x081CFE38, sprite: 0x081D4370},
  #us {desc: "Castle Corridor background bats and clouds", gfx_files: [0x081CBE5C], palette: 0x08209EE8, sprite: 0x0820FE44},
  {desc: "Giant Bat", pointer: 0x080B5C38, gfx_wrapper: 0x080F8694},
  {desc: "Graham transformation", gfx_wrapper: 0x080F87D4, palette: 0x0821B7D0, sprite: 0x08225730},
  {desc: "Graham 2 body", gfx_files: [0x082177C8, 0x082197CC], palette: 0x0821B7D0, sprite: 0x0821C908},
  {desc: "Graham 2 hands", gfx_files: [0x082177C8, 0x082197CC], palette: 0x0821B7D0, sprite: 0x08224720},
  #us {desc: "Graham transformation", gfx_wrapper: 0x0811954C, palette: 0x0820C158, sprite: 0x082563DC},
  #us {desc: "Graham 2 body", gfx_files: [0x081FD2C0, 0x081FF2C4], palette: 0x0820C158, sprite: 0x08254D84},
  #us {desc: "Graham 2 hands", gfx_files: [0x081FD2C0, 0x081FF2C4], palette: 0x0820C158, sprite: 0x082553CC},
  {desc: "Chaos 2", gfx_wrapper: 0x080F84AC, palette: 0x081D09E7, sprite: 0x08231424},
  {desc: "HUD", gfx_wrapper: 0x081CF890, palette: 0x081D1C58, no_sprite: true},
  #us is {desc: "HUD", gfx_wrapper: 0x0827B208, palette: 0x0820C428, no_sprite: true},
  {desc: "Pause menu foreground objects", gfx_files: [0x081CF880], palette: 0x081D1AF0, sprite: 0x08212310, palette_offset: 1},
  #us is {desc: "Pause menu foreground objects", gfx_files: [0x082052D8], palette: 0x0820C2C0, sprite: 0x08256EF8, palette_offset: 1},
]

CANDLE_FRAME_IN_COMMON_SPRITE = 0x1E
MONEY_FRAME_IN_COMMON_SPRITE = 0x21
#CANDLE_SPRITE = COMMON_SPRITE.merge(palette_offset: 3)
CANDLE_SPRITE = OTHER_SPRITES.find{|spr| spr[:desc] == "Candles"}
MONEY_SPRITE = COMMON_SPRITE.merge(palette_offset: 2)

WEAPON_GFX_LIST_START = 0x084BCFC8
WEAPON_GFX_COUNT = 0x2F
WEAPON_SPRITES_LIST_START = 0x084BD084
WEAPON_PALETTE_LIST = 0x081CF984
SKILL_GFX_LIST_START = 0x080DF904
SKILL_GFX_COUNT = 0x22
RED_SOUL_INDEX_TO_SKILL_GFX_INDEX = {
  0x00 => nil,
  0x01 => 0x00,
  0x02 => 0x03,
  0x03 => 0x07,
  0x04 => 0x00,
  0x05 => 0x00,
  0x06 => 0x12,
  0x07 => 0x0B,
  0x08 => 0x1F,
  0x09 => 0x07,
  0x0A => 0x15,
  0x0B => 0x00,
  0x0C => 0x15,
  0x0D => 0x18,
  0x0E => 0x00,
  0x0F => 0x04,
  0x10 => 0x10,
  0x11 => 0x14,
  0x12 => 0x01,
  0x13 => 0x01,
  0x14 => 0x0A,
  0x15 => 0x11,
  0x16 => 0x1B,
  0x17 => 0x0E,
  0x18 => 0x18,
  0x19 => 0x00,
  0x1A => 0x0C,
  0x1B => 0x20,
  0x1C => 0x16,
  0x1D => 0x11,
  0x1E => 0x07,
  0x1F => 0x17,
  0x20 => 0x21,
  0x21 => 0x0D,
  0x22 => 0x01,
  0x23 => 0x08,
  0x24 => 0x08,
  0x25 => 0x0F,
  0x26 => 0x19,
  0x27 => 0x13,
  0x28 => 0x07,
  0x29 => 0x12,
  0x2A => 0x18,
  0x2B => 0x1C,
  0x2C => 0x11,
  0x2D => 0x09,
  0x2E => 0x02,
  0x2F => 0x00,
  0x30 => 0x05,
  0x31 => 0x1D,
  0x32 => 0x1E,
  0x33 => 0x06,
  0x34 => 0x15,
  0x35 => 0x1A,
  0x36 => 0x1B,
  0x37 => 0x01,
}
BLUE_SOUL_REUSED_SPRITE_INFO = {
  0x00 => {init_code: -1}, # ---
  0x02 => {init_code: -1}, # giant bat
  0x03 => {init_code: -1}, # black panther
  0x04 => {init_code: 0x0802EF66}, # buer
  0x06 => {init_code: 0x0802EC24}, # giant ghost
  0x0F => {init_code: -1}, # medusa head
  0x12 => {init_code: 0x0802DE62}, # devil
  0x13 => {init_code: 0x0802DE62}, # manticore
  0x14 => {init_code: 0x08030AAD}, # curly
}

MAP_TILE_METADATA_LIST_START_OFFSET = nil
MAP_TILE_METADATA_START_OFFSET = 0x080F58D8
MAP_TILE_LINE_DATA_LIST_START_OFFSET = nil
MAP_TILE_LINE_DATA_START_OFFSET = 0x080F7058
MAP_LENGTH_DATA_START_OFFSET = nil
MAP_NUMBER_OF_TILES = 3008
MAP_SECRET_DOOR_LIST_START_OFFSET = nil
MAP_SECRET_DOOR_DATA_START_OFFSET = 0x080F7638
MAP_SECRET_ROOM_DATA_START_OFFSET = nil
MAP_DRAW_X_OFFSET_LOCATION = nil
MAP_DRAW_Y_OFFSET_LOCATION = nil
ABYSS_MAP_TILE_METADATA_START_OFFSET = nil
ABYSS_MAP_TILE_LINE_DATA_START_OFFSET = nil
ABYSS_MAP_NUMBER_OF_TILES = nil
ABYSS_MAP_SECRET_DOOR_DATA_START_OFFSET = nil
ABYSS_MAP_DRAW_X_OFFSET_LOCATION = nil
ABYSS_MAP_DRAW_Y_OFFSET_LOCATION = nil

#WARP_ROOM_LIST_START = 0x084FC8BC
#WARP_ROOM_COUNT = 8
WARP_ROOM_LIST_POINTER_HARDCODED_LOCATIONS = [0x0804DE24, 0x0804DE8C, 0x0804DEA0]
#us is [0x0804F7F0, 0x0804F858, 0x0804F86C](0x08525FBC), and cn is [0x0804DE24, 0x0804DE8C, 0x0804DEA0]
WARP_ROOM_LAST_INDEX_HARDCODED_LOCATIONS = [0x0801078C, 0x08010740]
#us is [0x08011598, 0x0801154C], and cn is [0x0801078C, 0x08010740]; the code is (cmp r0, 7h)@11598 and (mov r7, 7h)@1154C

MAP_FILL_COLOR = [28, 6, 218, 255]
MAP_SAVE_FILL_COLOR = [239, 25, 26, 255]
MAP_WARP_FILL_COLOR = [246, 246, 30, 255]
MAP_SECRET_FILL_COLOR = [73, 254, 18, 255]
MAP_ENTRANCE_FILL_COLOR = [0, 0, 0, 0] # Area entrances don't exist in AoS.
MAP_LINE_COLOR = [252, 252, 252, 255]
MAP_DOOR_COLOR = [62, 197, 192, 255]
MAP_DOOR_CENTER_PIXEL_COLOR = MAP_DOOR_COLOR
MAP_SECRET_DOOR_COLOR = [232, 193, 232, 255]


AREA_MUSIC_LIST_START_OFFSET = nil
SECTOR_MUSIC_LIST_START_OFFSET = 0x084BCF74
AVAILABLE_BGM_POOL_START_OFFSET = nil
SONG_INDEX_TO_TEXT_INDEX = [
  "Silence",
  0x393,
  0x394,
  0x395,
  0x396,
  0x397,
  0x398,
  0x399,
  0x39A,
  0x39B,
  0x39C,
  0x39D,
  0x39E,
  0x39F,
  0x3A0,
  0x3A1,
  0x3A2,
  0x3A3,
  0x3A4,
  0x3A5,
  0x3A7,
  0x3A8,
  0x3A9,
  "Premonition (Duplicate)",
  0x3AD,
  "Premonition (Duplicate 2)",
  0x3AB,
  0x3AC,
  "Forbidden Area (Duplicate)",
  "Prologue(Theme of Mina) (Duplicate)",
  "Hammer's Shop (Duplicate)",
  0x3A6,
  0x3AA,
  0x3AE,
  "Dracula's fate (Duplicate)",
  0x3AF,
  "You're Not Alone (Duplicate)",
  "Ambience",
  "Ambience (Duplicate)",
  "Rushing Water Ambience",
  "Ambience (Legion?)",
  "Ambience (Legion)",
  "Ambience (???)",
  "Ambience (??? 2)",
  "Ambience (??? 3)",
  "Ambience (Before Chaos)",
]

NEW_OVERLAY_ID = nil
NEW_OVERLAY_FREE_SPACE_START = nil
NEW_OVERLAY_FREE_SPACE_MAX_SIZE = nil
ASSET_MEMORY_START_HARDCODED_LOCATION = nil

ROM_FREE_SPACE_START = 0x651170
ROM_FREE_SPACE_SIZE = 0x1AEE90

TEST_ROOM_SAVE_FILE_INDEX_LOCATION = 0x0800298E    #cant find try modify
TEST_ROOM_AREA_INDEX_LOCATION      = nil
TEST_ROOM_SECTOR_INDEX_LOCATION    = 0x08002994
TEST_ROOM_ROOM_INDEX_LOCATION      = 0x08002996

#TEST_ROOM_X_POS_LOCATION           = 0x080029B8
#TEST_ROOM_Y_POS_LOCATION           = 0x080029BC
TEST_ROOM_SCREEN_X_POS_LOCATION    = 0x080029C0
TEST_ROOM_SCREEN_Y_POS_LOCATION    = 0x080029CC
TEST_ROOM_X_POS_LOCATION           = 0x080029C8
TEST_ROOM_Y_POS_LOCATION           = 0x080029CC
TEST_ROOM_OVERLAY = nil

SHOP_ITEM_POOL_LIST = 0x084FD55C
SHOP_ITEM_POOL_COUNT = 3
SHOP_ALLOWABLE_ITEMS_LIST = 0x084FD2EC
SHOP_NUM_ALLOWABLE_ITEMS = 0x82
SHOP_ITEM_POOL_REQUIRED_EVENT_FLAG_HARDCODED_LOCATIONS = [nil, 0x080659B6, 0x080659C8]

FAKE_FREE_SPACES = []

MAGIC_SEAL_COUNT = 0
MAGIC_SEAL_LIST_START = nil
MAGIC_SEAL_FOR_BOSS_LIST_START = nil

MENU_BG_LAYER_INFOS = [
  {
    name: "Pause screen",
    gfx_file_pointers:      [0x0813D2B4, 0x081CF878],
    #us gfx_file_pointers:      [0x0815E02C, 0x0827B200],
    palette_list_pointer:   0x080E38C0, #us 0x080E5C20,
    layer_metadata_pointer: 0x0813D8E0, #us 0x0815E940,
  },
  #TODO: fix the addresses to cn version
  {
    name: "Pause screen (Awakened Soma)",
    gfx_file_pointers:      [0x08264398, 0x0827B200],
    palette_list_pointer:   0x0826664C,
    layer_metadata_pointer: 0x0815E940,
  },
  {
    name: "Soul set",
    gfx_file_pointers:      [0x0815E02C, 0x0827B200],
    palette_list_pointer:   0x0826664C,
    layer_metadata_pointer: 0x0815E790,
  },
  {
    name: "Equip",
    gfx_file_pointers:      [0x0815E02C, 0x0827B200],
    palette_list_pointer:   0x080E5C20,
    layer_metadata_pointer: 0x0815E8B0,
  },
  {
    name: "Item use",
    gfx_file_pointers:      [0x0815E02C, 0x0827B200],
    palette_list_pointer:   0x080E5C20,
    layer_metadata_pointer: 0x0815E820,
  },
  {
    name: "Ability souls",
    gfx_file_pointers:      [0x0815E02C, 0x0827B200],
    palette_list_pointer:   0x080E5C20,
    layer_metadata_pointer: 0x0815E700,
  },
  {
    name: "Config",
    gfx_file_pointers:      [0x0815E02C, 0x0827B200],
    palette_list_pointer:   0x080E5C20,
    layer_metadata_pointer: 0x0815E670,
  },
  {
    name: "Bestiary list",
    gfx_file_pointers:      [0x0815E034, 0x0827B200],
    palette_list_pointer:   0x0815E0A4,
    layer_metadata_pointer: 0x0815EA60,
  },
  {
    name: "Bestiary entry",
    gfx_file_pointers:      [0x0815E034, 0x0827B200],
    palette_list_pointer:   0x0815E0A4,
    layer_metadata_pointer: 0x0815E9D0,
  },
  {
    name: "Shop",
    gfx_file_pointers:      [0x0815E084],
    palette_list_pointer:   0x0815E3EC,
    layer_metadata_pointer: 0x0815F120,
  },
  {
    name: "Shop buy menu",
    gfx_file_pointers:      [0x0815E084],
    palette_list_pointer:   0x0815E3EC,
    layer_metadata_pointer: 0x0815F090,
  },
  {
    name: "Shop sell menu",
    gfx_file_pointers:      [0x0815E084],
    palette_list_pointer:   0x0815E3EC,
    layer_metadata_pointer: 0x0815F000,
  },
  {
    name: "Game over screen",
    gfx_file_pointers:      [0x080E5C08, 0x080E5C10],
    palette_list_pointer:   0x080E6A3C,
    layer_metadata_pointer: 0x080E9584,
  },
  {
    name: "Konami logo",
    gfx_file_pointers:      [0x080E5C18],
    palette_list_pointer:   0x080E6C40,
    layer_metadata_pointer: 0x080E9614,
  },
  {
    name: "Licensed by Nintendo",
    gfx_file_pointers:      [0x080E5C00],
    palette_list_pointer:   0x080E6838,
    layer_metadata_pointer: 0x080E94F4,
  },
  {
    name: "Title screen 1",
    gfx_file_pointers:      [0x080E5BE8],
    palette_list_pointer:   0x080E6430,
    layer_metadata_pointer: 0x080E9024,
  },
  {
    name: "Title screen 2",
    gfx_file_pointers:      [0x080E5BE8],
    palette_list_pointer:   0x080E6430,
    layer_metadata_pointer: 0x080E90B4,
  },
  {
    name: "Title screen 3",
    gfx_file_pointers:      [0x080E5BE0],
    palette_list_pointer:   0x080E6430,
    layer_metadata_pointer: 0x080E8F94,
  },
  {
    name: "Castle background",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E74C4,
  },
  {
    name: "Game start 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E73A4,
  },
  {
    name: "Game start 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E7434,
  },
  {
    name: "Select data 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E7314,
  },
  {
    name: "Select data 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E7044,
  },
  {
    name: "Copy data 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E7284,
  },
  {
    name: "Copy data 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E6FB4,
  },
  {
    name: "Delete data 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E71F4,
  },
  {
    name: "Delete data 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E6E04,
  },
  {
    name: "Name entry 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E70D4,
  },
  {
    name: "Name entry 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E6E94,
  },
  {
    name: "Soul trade 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E7164,
  },
  {
    name: "Soul trade 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E6F24,
  },
  {
    name: "Sound mode 1",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E6D74,
  },
  {
    name: "Sound mode 2",
    gfx_file_pointers:      [0x080E5BB0, 0x080E5BB8, 0x080E5BC0],
    palette_list_pointer:   0x080E5E24,
    layer_metadata_pointer: 0x080E6CE4,
  },
  {
    name: "Prologue 1",
    gfx_file_pointers:      [0x080E5BF0, 0x080E5BF8],
    palette_list_pointer:   0x080E6634,
    layer_metadata_pointer: 0x080E9464,
  },
  {
    name: "Prologue 2",
    gfx_file_pointers:      [0x080E5BF0, 0x080E5BF8],
    palette_list_pointer:   0x080E6634,
    layer_metadata_pointer: 0x080E9244,
  },
  {
    name: "Prologue 3",
    gfx_file_pointers:      [0x080E5BF0, 0x080E5BF8],
    palette_list_pointer:   0x080E6634,
    layer_metadata_pointer: 0x080E9354,
  },
  {
    name: "Credits",
    gfx_file_pointers:      [0x080E5BC8, 0x080E5BD0, 0x080E5BD8],
    palette_list_pointer:   0x080E6028,
    layer_metadata_pointer: 0x080E8F04,
  },
  {
    name: "Credits good ending characters 1",
    gfx_file_pointers:      [0x080E5BC8, 0x080E5BD0, 0x080E5BD8],
    palette_list_pointer:   0x080E6028,
    layer_metadata_pointer: 0x080E7B54,
  },
  {
    name: "Credits good ending characters 2",
    gfx_file_pointers:      [0x080E5BC8, 0x080E5BD0, 0x080E5BD8],
    palette_list_pointer:   0x080E6028,
    layer_metadata_pointer: 0x080E81E4,
  },
  {
    name: "Credits normal ending characters",
    gfx_file_pointers:      [0x080E5BC8, 0x080E5BD0, 0x080E5BD8],
    palette_list_pointer:   0x080E6028,
    layer_metadata_pointer: 0x080E8874,
  },
  {
    name: "Epilogue castle destruction 1",
    gfx_file_pointers:      [0x08119898],
    palette_list_pointer:   0x08119FDC,
    layer_metadata_pointer: 0x0815DE6C,
  },
  {
    name: "Epilogue castle destruction 2",
    gfx_file_pointers:      [0x08119890],
    palette_list_pointer:   0x08119FDC,
    layer_metadata_pointer: 0x0815DDDC,
  },
  {
    name: "Portrait 00 (Soma)",
    gfx_file_pointers:      [0x0815E03C],
    palette_list_pointer:   0x0815E2A8,
    layer_metadata_pointer: 0x0815EAF0,
  },
  {
    name: "Portrait 01 (Mina)",
    gfx_file_pointers:      [0x0815E04C],
    palette_list_pointer:   0x0815E2F0,
    layer_metadata_pointer: 0x0815EC10,
  },
  {
    name: "Portrait 02 (Arikado)",
    gfx_file_pointers:      [0x0815E054],
    palette_list_pointer:   0x0815E314,
    layer_metadata_pointer: 0x0815ECA0,
  },
  {
    name: "Portrait 03 (Graham)",
    gfx_file_pointers:      [0x0815E05C],
    palette_list_pointer:   0x0815E338,
    layer_metadata_pointer: 0x0815ED30,
  },
  {
    name: "Portrait 04 (Yoko)",
    gfx_file_pointers:      [0x0815E074],
    palette_list_pointer:   0x0815E3A4,
    layer_metadata_pointer: 0x0815EEE0,
  },
  {
    name: "Portrait 05 (Julius)",
    gfx_file_pointers:      [0x0815E07C],
    palette_list_pointer:   0x0815E3C8,
    layer_metadata_pointer: 0x0815EF70,
  },
  {
    name: "Portrait 06 (Hammer)",
    gfx_file_pointers:      [0x0815E06C],
    palette_list_pointer:   0x0815E380,
    layer_metadata_pointer: 0x0815EE50,
  },
  {
    name: "Portrait 07 (Awakened Soma)",
    gfx_file_pointers:      [0x0815E044],
    palette_list_pointer:   0x0815E2CC,
    layer_metadata_pointer: 0x0815EB80,
  },
  {
    name: "Portrait 08 (Angry Graham)",
    gfx_file_pointers:      [0x0815E064],
    palette_list_pointer:   0x0815E35C,
    layer_metadata_pointer: 0x0815EDC0,
  },
]

#TODO: convert the address to cn ver
FONTS = [
  {
    font_address: 0x0850A136,
    #I do not actually know what this address is, so I cannot find the cn ver
    font_data_size: 0xC40,
    char_width: 8,
    char_height: 12,
  },
]
