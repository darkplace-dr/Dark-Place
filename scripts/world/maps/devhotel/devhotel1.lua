return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 57,
  properties = {
    ["music"] = "greenroom"
  },
  tilesets = {
    {
      name = "devroom",
      firstgid = 1,
      filename = "../../tilesets/devroom.tsx",
      exportfilename = "../../tilesets/devroom.lua"
    },
    {
      name = "hoteldoors",
      firstgid = 73,
      filename = "../../tilesets/hoteldoors.tsx",
      exportfilename = "../../tilesets/hoteldoors.lua"
    },
    {
      name = "dw_city_alley",
      firstgid = 77,
      filename = "../../tilesets/dw_city_alley.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 50,
      height = 12,
      id = 1,
      name = "Tile Layer 1",
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
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 21,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 240,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "",
          class = "",
          shape = "rectangle",
          x = 640,
          y = 240,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          class = "",
          shape = "rectangle",
          x = 800,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          class = "",
          shape = "rectangle",
          x = 840,
          y = 320,
          width = 400,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1200,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 1240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects_props",
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
          id = 14,
          name = "",
          class = "",
          shape = "rectangle",
          x = 208,
          y = 280,
          width = 64,
          height = 100,
          rotation = 0,
          gid = 74,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          class = "",
          shape = "rectangle",
          x = 448,
          y = 280,
          width = 64,
          height = 100,
          rotation = 0,
          gid = 76,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          class = "",
          shape = "rectangle",
          x = 568,
          y = 280,
          width = 64,
          height = 100,
          rotation = 0,
          gid = 73,
          visible = true,
          properties = {}
        },
        {
          id = 52,
          name = "",
          class = "",
          shape = "rectangle",
          x = 328,
          y = 280,
          width = 64,
          height = 100,
          rotation = 0,
          gid = 75,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 40,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 1120,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "[voice:spamton]* COME TO [[The Artiffilect]]!\n* [Bestest] TOWN IN THE [[CyberCity]]!",
            ["text2"] = "[voice:spamton]* FIND US AT[wait:0.3s]\n* [[Sugarplum Alley]]"
          }
        },
        {
          id = 41,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 240,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel.brandon",
            ["solid"] = true
          }
        },
        {
          id = 42,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 240,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel.velvet",
            ["solid"] = true
          }
        },
        {
          id = 54,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 240,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel.jamm",
            ["solid"] = true
          }
        },
        {
          id = 44,
          name = "",
          class = "",
          shape = "rectangle",
          x = 560,
          y = 240,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel.template",
            ["solid"] = true
          }
        },
        {
          id = 45,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -20,
          y = 280,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devhotel_lobby",
            ["marker"] = "entryleft"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 47,
          name = "entryright",
          class = "",
          shape = "point",
          x = 60,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "spawn",
          class = "",
          shape = "point",
          x = 60,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "door_002",
          class = "",
          shape = "point",
          x = 360,
          y = 306,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 55,
          name = "door_003",
          class = "",
          shape = "point",
          x = 480,
          y = 306,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "door_001",
          class = "",
          shape = "point",
          x = 240,
          y = 306,
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
