return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 21,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 16,
  nextobjectid = 128,
  properties = {
    ["border"] = "city",
    ["light"] = false,
    ["music"] = "deltarune/cybercity",
    ["name"] = "Test City - Sugarplum Alley"
  },
  tilesets = {
    {
      name = "battleborder",
      firstgid = 1,
      filename = "../../tilesets/battleborder.tsx"
    },
    {
      name = "dw_city_alley",
      firstgid = 99,
      filename = "../../tilesets/dw_city_alley.tsx"
    },
    {
      name = "city_alleyway",
      firstgid = 209,
      filename = "../../tilesets/city_alleyway.tsx",
      exportfilename = "../../tilesets/city_alleyway.lua"
    },
    {
      name = "dw_city_alley_2",
      firstgid = 524,
      filename = "../../tilesets/dw_city_alley_2.tsx",
      exportfilename = "../../tilesets/dw_city_alley_2.lua"
    },
    {
      name = "street_edges",
      firstgid = 634,
      filename = "../../tilesets/street_edges.tsx",
      exportfilename = "../../tilesets/street_edges.lua"
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
        686, 761, 762, 763, 764, 686, 686, 683, 684, 685, 686, 452, 453, 453, 453, 454, 631, 631, 452, 453, 454,
        452, 453, 453, 453, 453, 453, 453, 454, 452, 453, 454, 467, 468, 468, 468, 469, 631, 631, 467, 468, 469,
        467, 468, 468, 468, 468, 468, 468, 469, 482, 483, 484, 467, 468, 468, 468, 469, 631, 631, 467, 468, 469,
        482, 483, 483, 483, 483, 483, 483, 484, 497, 498, 499, 482, 483, 483, 483, 484, 631, 631, 482, 498, 484,
        497, 498, 498, 498, 498, 498, 498, 499, 512, 513, 514, 497, 498, 498, 498, 499, 631, 631, 497, 498, 499,
        512, 513, 513, 513, 513, 513, 513, 514, 631, 631, 631, 512, 513, 513, 513, 514, 631, 631, 512, 513, 513,
        631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631,
        631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631,
        631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631, 631,
        453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 453, 454,
        468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 469,
        468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 468, 469
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
          id = 107,
          name = "",
          type = "",
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
          type = "",
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
          type = "",
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
          type = "",
          shape = "rectangle",
          x = 720,
          y = 0,
          width = 120,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 112,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 360,
          width = 840,
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
          type = "",
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
          type = "",
          shape = "point",
          x = 40,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 115,
          name = "entry_right",
          type = "",
          shape = "point",
          x = 800,
          y = 300,
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
          type = "",
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
          name = "#interactable",
          type = "",
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
          type = "",
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
          type = "",
          shape = "rectangle",
          x = -80,
          y = 80,
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
          id = 114,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (It looks like you can't go over here yet.)",
            ["text2"] = "* (So whoever is reading this, don't put the transition back...)",
            ["text3"] = "* (I mean if it's literally offscreen it's got to have a reason, am I right??)",
            ["text4"] = "* (Signed, undertaled#0.)"
          }
        },
        {
          id = 100,
          name = "transition",
          type = "",
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
        },
        {
          id = 116,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cybercity/alleyzero",
            ["marker"] = "entry_left"
          }
        },
        {
          id = 126,
          name = "forcefield",
          type = "",
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
          id = 127,
          name = "npc",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "notypee",
            ["cutscene"] = "cybercity.notypee"
          }
        }
      }
    }
  }
}
