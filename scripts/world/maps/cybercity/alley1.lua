return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 21,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 16,
  nextobjectid = 113,
  properties = {
    ["border"] = "city",
    ["light"] = false,
    ["music"] = "cybercity",
    ["name"] = "Test City - Sugarplum Alley"
  },
  tilesets = {
    {
      name = "battleborder",
      firstgid = 1,
      filename = "../../../../../ultratestmod/scripts/world/tilesets/battleborder.tsx"
    },
    {
      name = "dw_city_alley",
      firstgid = 54,
      filename = "../../../../../ultratestmod/scripts/world/tilesets/dw_city_alley.tsx"
    },
    {
      name = "city_alleyway",
      firstgid = 95,
      filename = "../../tilesets/city_alleyway.tsx",
      exportfilename = "../../tilesets/city_alleyway.lua"
    },
    {
      name = "dw_city_alley_2",
      firstgid = 410,
      filename = "../../tilesets/dw_city_alley_2.tsx",
      exportfilename = "../../tilesets/dw_city_alley_2.lua"
    },
    {
      name = "street_edges",
      firstgid = 520,
      filename = "../../tilesets/street_edges.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 21,
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
        572, 647, 648, 649, 650, 572, 572, 569, 570, 571, 572, 338, 339, 339, 339, 340, 517, 517, 353, 354, 354,
        338, 339, 339, 339, 339, 339, 339, 340, 338, 339, 340, 353, 354, 354, 354, 355, 517, 517, 353, 354, 354,
        353, 354, 354, 354, 354, 354, 354, 355, 368, 369, 370, 353, 354, 354, 354, 355, 517, 517, 353, 354, 354,
        368, 369, 369, 369, 369, 369, 369, 370, 383, 384, 385, 368, 369, 369, 369, 370, 517, 517, 353, 354, 354,
        383, 384, 384, 384, 384, 384, 384, 385, 398, 399, 400, 383, 384, 384, 384, 385, 517, 517, 353, 354, 354,
        398, 399, 399, 399, 399, 399, 399, 400, 517, 517, 517, 398, 399, 399, 399, 400, 517, 517, 353, 354, 354,
        517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 353, 354, 354,
        517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 353, 354, 354,
        517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 517, 353, 354, 354,
        339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 339, 353, 354, 354,
        354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 353, 354, 354,
        354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 354, 353, 354, 354
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "collision",
      class = "",
      visible = true,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 104,
          name = "",
          class = "",
          shape = "rectangle",
          x = -40,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 107,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 40,
          width = 320,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 108,
          name = "",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 40,
          width = 120,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 110,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 0,
          width = 200,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 111,
          name = "",
          class = "",
          shape = "rectangle",
          x = 720,
          y = 0,
          width = 120,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 112,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 360,
          width = 720,
          height = 120,
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
          id = 90,
          name = "entry_down",
          class = "",
          shape = "point",
          x = 680,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 96,
          name = "castle",
          class = "",
          shape = "point",
          x = 40,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 2,
          name = "savepoint",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 185,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 80,
          y = 200,
          width = 81,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "test"
          }
        },
        {
          id = 86,
          name = "cybertrash",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "cd_bagel"
          }
        },
        {
          id = 98,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -80,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "left",
            ["map"] = "castletocity",
            ["marker"] = "city"
          }
        },
        {
          id = 100,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 640,
          y = 0,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cybercity/alley2",
            ["marker"] = "entry_up"
          }
        }
      }
    }
  }
}
