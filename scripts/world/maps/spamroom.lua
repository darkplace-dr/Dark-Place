return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 37,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 55,
  properties = {
    ["border"] = "city",
    ["music"] = "spamton_battle_eb"
  },
  tilesets = {
    {
      name = "city_alleyway",
      firstgid = 1,
      filename = "../tilesets/city_alleyway.tsx",
      exportfilename = "../tilesets/city_alleyway.lua"
    },
    {
      name = "warp_bin",
      firstgid = 316,
      filename = "../tilesets/warp_bin.tsx",
      exportfilename = "../tilesets/warp_bin.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 37,
      height = 12,
      id = 1,
      name = "tiles",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        247, 250, 251, 262, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 260, 260, 260, 260, 260, 261, 66, 128, 128, 55, 259, 260, 260, 260, 260, 260, 261, 244, 248, 251,
        262, 260, 261, 259, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 264, 260, 260, 260, 260, 260, 266, 51, 128, 128, 85, 259, 264, 264, 264, 264, 265, 266, 262, 260, 261,
        277, 280, 276, 277, 275, 290, 290, 290, 290, 290, 290, 275, 290, 290, 280, 290, 290, 275, 279, 275, 275, 275, 275, 81, 128, 128, 55, 290, 290, 290, 290, 290, 280, 281, 259, 260, 261,
        289, 290, 291, 292, 290, 290, 290, 290, 290, 290, 290, 290, 293, 290, 290, 290, 290, 290, 290, 290, 290, 290, 290, 66, 128, 128, 70, 290, 279, 290, 290, 295, 290, 291, 259, 260, 261,
        292, 290, 291, 304, 308, 305, 305, 305, 305, 305, 305, 305, 305, 305, 305, 305, 305, 308, 305, 305, 309, 305, 305, 51, 128, 128, 85, 305, 308, 305, 305, 305, 305, 311, 259, 260, 261,
        289, 278, 291, 38, 37, 95, 94, 95, 95, 94, 95, 37, 94, 95, 95, 94, 95, 37, 102, 37, 38, 37, 38, 96, 128, 128, 100, 37, 38, 37, 38, 39, 93, 40, 259, 260, 261,
        128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 70, 277, 280, 281,
        128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 134, 292, 279, 291,
        245, 245, 246, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 128, 70, 289, 290, 291,
        260, 260, 261, 155, 154, 155, 155, 155, 155, 155, 155, 154, 155, 155, 155, 155, 155, 154, 155, 154, 155, 154, 155, 156, 128, 128, 160, 162, 163, 162, 163, 162, 163, 164, 289, 290, 296,
        260, 260, 261, 245, 245, 245, 250, 245, 245, 245, 245, 248, 245, 245, 245, 245, 245, 245, 249, 245, 250, 245, 245, 246, 128, 128, 247, 249, 248, 245, 245, 245, 250, 251, 294, 290, 291,
        260, 260, 261, 260, 260, 260, 260, 260, 260, 260, 260, 260, 260, 260, 260, 260, 260, 264, 264, 264, 264, 264, 264, 266, 128, 128, 262, 264, 264, 264, 264, 264, 264, 266, 290, 290, 291
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 37,
      height = 12,
      id = 3,
      name = "props",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = -20,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 17, 18, 19, 0, 0, 0, 0, 0, 0, 0, 210, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 32, 33, 34, 0, 0, 0, 0, 0, 0, 0, 225, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 37,
      height = 12,
      id = 4,
      name = "props2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = -20,
      offsety = -20,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 240, 222, 223, 224, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 316, 317, 318, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 37,
      height = 12,
      id = 8,
      name = "props3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 286, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 4,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1040,
          y = 400,
          width = 320,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1360,
          y = 0,
          width = 120,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1080,
          y = 0,
          width = 280,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 800,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 400,
          width = 840,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 120,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 120,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 7,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 960,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "room3",
            ["marker"] = "exit_spamroom"
          }
        },
        {
          id = 10,
          name = "npc",
          class = "",
          shape = "rectangle",
          x = 1320,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "spamongus",
            ["cutscene"] = "spamroom.amogus"
          }
        },
        {
          id = 11,
          name = "npc",
          class = "",
          shape = "rectangle",
          x = 680,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "alternatespam",
            ["cutscene"] = "spamroom.mandela"
          }
        },
        {
          id = 12,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 780,
          y = 94,
          width = 120,
          height = 106,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamroom.poster"
          }
        },
        {
          id = 13,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 1150,
          y = 140,
          width = 110,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "warp_bin",
            ["solid"] = true
          }
        },
        {
          id = 14,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 1110,
          y = 160,
          width = 40,
          height = 46,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* There's an important looking note here.",
            ["text2"] = "* \"If you're stuck, try putting in 00000000!\"",
            ["text3"] = "* \"(Hint: to get back here put in the code 'spamroom'.)\""
          }
        },
        {
          id = 16,
          name = "npc",
          class = "",
          shape = "point",
          x = 1080,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "soapton",
            ["cutscene"] = "spamroom.soapton"
          }
        },
        {
          id = 20,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 920,
          y = -20,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "city_entry",
            ["marker"] = "entry_1"
          }
        },
        {
          id = 22,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "room_prefountain.moss2"
          }
        },
        {
          id = 36,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 180,
          y = 180,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamroom.mosquito",
            ["solid"] = true
          }
        },
        {
          id = 27,
          name = "npc",
          class = "",
          shape = "point",
          x = 520,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "cungaderospamton",
            ["cutscene"] = "spamroom.cungadero"
          }
        },
        {
          id = 30,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -40,
          y = 240,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cybercity/alley2",
            ["marker"] = "entry_right"
          }
        },
        {
          id = 34,
          name = "npc",
          class = "",
          shape = "point",
          x = 1320,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "marispam",
            ["cutscene"] = "spamroom.mari"
          }
        },
        {
          id = 35,
          name = "npc",
          class = "",
          shape = "point",
          x = 200,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "spam_mosquito"
          }
        },
        {
          id = 37,
          name = "npc",
          class = "",
          shape = "point",
          x = 400,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "cardspam",
            ["cutscene"] = "spamroom.cardspam"
          }
        },
        {
          id = 39,
          name = "npc",
          class = "",
          shape = "point",
          x = 160,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "spamtong",
            ["cutscene"] = "spamroom.bikini"
          }
        },
        {
          id = 41,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 240,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 42,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 440,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 43,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 840,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 44,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 680,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 45,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 1000,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 46,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 1200,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 47,
          name = "beanspot",
          class = "",
          shape = "point",
          x = 1024,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "spam_beans",
            ["name"] = "Spam Bean"
          }
        },
        {
          id = 52,
          name = "npc",
          class = "",
          shape = "rectangle",
          x = 900,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "muppet_kris",
            ["cutscene"] = "spamroom.muppet"
          }
        },
        {
          id = 53,
          name = "npc",
          class = "",
          shape = "point",
          x = 800,
          y = 390,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "betaspam"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "markers",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 9,
          name = "entry",
          class = "",
          shape = "point",
          x = 1000,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "spawn",
          class = "",
          shape = "point",
          x = 1200,
          y = 270,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "entry1",
          class = "",
          shape = "point",
          x = 1000,
          y = 105,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "entry_left",
          class = "",
          shape = "point",
          x = 40,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
