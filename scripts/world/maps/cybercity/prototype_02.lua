return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 34,
  properties = {
    ["border"] = "city",
    ["music"] = "deltarune/cybercity"
  },
  tilesets = {
    {
      name = "dw_city_street",
      firstgid = 1,
      filename = "../../tilesets/dw_city_street.tsx",
      exportfilename = "../../tilesets/dw_city_street.lua"
    },
    {
      name = "bg_dw_city",
      firstgid = 111,
      filename = "../../tilesets/bg_dw_city.tsx",
      exportfilename = "../../tilesets/bg_dw_city.lua"
    },
    {
      name = "street_edges",
      firstgid = 723,
      filename = "../../tilesets/street_edges.tsx",
      exportfilename = "../../tilesets/street_edges.lua"
    },
    {
      name = "dw_city_alley_2",
      firstgid = 931,
      filename = "../../tilesets/dw_city_alley_2.tsx",
      exportfilename = "../../tilesets/dw_city_alley_2.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
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
        838, 839, 852, 493, 827, 828, 829, 493, 946, 947, 948, 493, 950, 951, 840, 827,
        851, 852, 828, 829, 840, 841, 842, 493, 957, 958, 959, 493, 961, 962, 963, 840,
        493, 840, 841, 842, 867, 493, 493, 493, 968, 969, 970, 493, 972, 973, 827, 854,
        0, 867, 867, 867, 867, 493, 493, 981, 976, 1034, 976, 1035, 976, 985, 840, 841,
        0, 867, 867, 867, 867, 493, 493, 986, 990, 990, 990, 990, 990, 988, 853, 854,
        49, 46, 49, 46, 49, 46, 49, 62, 75, 75, 75, 75, 75, 54, 55, 0,
        60, 57, 60, 60, 57, 60, 60, 57, 75, 75, 75, 75, 75, 60, 61, 0,
        71, 68, 71, 68, 71, 68, 71, 68, 71, 68, 71, 84, 75, 75, 58, 0,
        493, 493, 493, 493, 493, 493, 493, 493, 493, 493, 493, 89, 75, 98, 99, 0,
        493, 493, 493, 493, 493, 493, 493, 976, 1035, 976, 979, 52, 75, 58, 493, 0,
        493, 493, 493, 493, 493, 493, 493, 990, 990, 990, 990, 60, 75, 61, 493, 0,
        493, 493, 493, 493, 493, 493, 493, 493, 493, 493, 493, 75, 75, 58, 493, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "doors",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        21, 22, 18, 19, 12, 13, 14, 0, 0, 0, 0, 0, 0, 0, 20, 21,
        32, 33, 29, 30, 23, 24, 25, 0, 0, 0, 0, 0, 0, 0, 31, 32,
        43, 44, 40, 41, 34, 35, 36, 0, 0, 0, 0, 0, 0, 0, 42, 43,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 8,
      name = "cones",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 291, 292, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 308, 309, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 309, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 309, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 1,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 280,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 320,
          width = 160,
          height = 60,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 440,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          class = "",
          shape = "rectangle",
          x = 560,
          y = 360,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          class = "",
          shape = "rectangle",
          x = 600,
          y = 200,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "rectangle",
          x = 560,
          y = 0,
          width = 80,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 0,
          width = 280,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 280,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
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
          id = 30,
          name = "",
          class = "",
          shape = "rectangle",
          x = 560,
          y = 280,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          class = "",
          shape = "rectangle",
          x = 158,
          y = 180,
          width = 40,
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
      id = 5,
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
          id = 5,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 6,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 480,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 7,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 14,
          name = "lightset",
          class = "",
          shape = "rectangle",
          x = 180,
          y = 135,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -40,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cybercity/prototype_01",
            ["marker"] = "entry_1"
          }
        },
        {
          id = 17,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 20,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "person"
          }
        },
        {
          id = 18,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "person"
          }
        },
        {
          id = 19,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 165,
          y = 5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "look"
          }
        },
        {
          id = 20,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 460,
          y = 5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "buy"
          }
        },
        {
          id = 21,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 560,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "ad"
          }
        },
        {
          id = 22,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 580,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "dolphin"
          }
        },
        {
          id = 23,
          name = "bg_sign",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 320,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "bg_sign",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 400,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "markers",
      class = "entry_1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 16,
          name = "entry_1",
          class = "",
          shape = "point",
          x = 40,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 3,
      name = "buildings",
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
        0, 0, 0, 0, 0, 0, 0, 263, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 280, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 297, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 314, 0, 0, 0, 0, 0, 0, 312, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 329, 414,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 346, 431,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 448,
        928, 929, 922, 923, 924, 925, 926, 927, 928, 929, 924, 0, 0, 0, 0, 465,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 482,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 499,
        0, 0, 0, 0, 0, 0, 0, 922, 923, 924, 925, 0, 0, 0, 0, 283,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 283
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_fg",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    }
  }
}
