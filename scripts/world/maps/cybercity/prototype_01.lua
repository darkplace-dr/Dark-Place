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
  nextlayerid = 10,
  nextobjectid = 41,
  properties = {
    ["border"] = "city",
    ["music"] = "deltarune/cybercity"
  },
  tilesets = {
    {
      name = "street_edges",
      firstgid = 1,
      filename = "../../tilesets/street_edges.tsx",
      exportfilename = "../../tilesets/street_edges.lua"
    },
    {
      name = "bg_dw_city",
      firstgid = 209,
      filename = "../../tilesets/bg_dw_city.tsx",
      exportfilename = "../../tilesets/bg_dw_city.lua"
    },
    {
      name = "dw_city_street",
      firstgid = 821,
      filename = "../../tilesets/dw_city_street.tsx",
      exportfilename = "../../tilesets/dw_city_street.lua"
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
        128, 129, 130, 105, 106, 107, 41, 42, 591, 1005, 991, 105, 106, 107, 50, 51,
        48, 105, 106, 107, 119, 120, 591, 591, 591, 1005, 988, 118, 105, 106, 107, 48,
        48, 118, 119, 120, 48, 48, 591, 591, 591, 1005, 991, 48, 118, 119, 120, 720,
        48, 48, 48, 48, 48, 48, 591, 591, 591, 1005, 988, 48, 48, 48, 48, 720,
        48, 48, 48, 48, 48, 871, 869, 866, 882, 895, 881, 48, 48, 48, 48, 720,
        869, 866, 869, 866, 869, 882, 880, 880, 883, 895, 886, 866, 869, 866, 869, 866,
        880, 877, 880, 880, 877, 883, 895, 895, 895, 895, 880, 877, 880, 880, 877, 880,
        891, 888, 891, 888, 921, 891, 904, 895, 895, 908, 891, 891, 921, 888, 891, 888,
        720, 720, 720, 720, 720, 720, 879, 895, 895, 881, 720, 720, 720, 720, 720, 720,
        509, 510, 512, 513, 514, 720, 879, 895, 895, 881, 720, 720, 487, 488, 489, 563,
        526, 527, 529, 530, 531, 720, 879, 895, 895, 881, 720, 720, 504, 505, 506, 580,
        543, 544, 546, 547, 548, 720, 879, 895, 895, 881, 720, 720, 521, 522, 523, 597
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
        0, 0, 0, 0, 0, 0, 840, 841, 842, 0, 0, 0, 0, 0, 0, 0,
        840, 841, 842, 838, 839, 0, 851, 852, 853, 0, 0, 835, 836, 837, 838, 839,
        851, 852, 853, 849, 850, 0, 862, 863, 864, 0, 0, 846, 847, 848, 849, 850,
        862, 863, 864, 860, 861, 0, 0, 0, 0, 0, 0, 857, 858, 859, 860, 861,
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
          width = 240,
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
          x = 400,
          y = 320,
          width = 240,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 0,
          width = 200,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 0,
          width = 160,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 200,
          height = 200,
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
          id = 10,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 11,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 17,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 3,
          y = 230,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 18,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 3,
          y = 190,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 19,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 3,
          y = 270,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 21,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 22,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 23,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 24,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 25,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 500,
          y = 90,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "ad"
          }
        },
        {
          id = 26,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 20,
          y = 40,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "buy"
          }
        },
        {
          id = 27,
          name = "city_screen",
          class = "",
          shape = "rectangle",
          x = 190,
          y = 20,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "deals"
          }
        },
        {
          id = 30,
          name = "lightset",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 40,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 640,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cybercity/prototype_02",
            ["marker"] = "entry_1"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 31,
          name = "entry_1",
          class = "",
          shape = "point",
          x = 600,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_fg",
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
          id = 20,
          name = "traffic_light",
          class = "",
          shape = "rectangle",
          x = 385,
          y = 0,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "carbridge",
          class = "",
          shape = "rectangle",
          x = 220,
          y = 300,
          width = 200,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "traffic_light",
          class = "",
          shape = "rectangle",
          x = 270,
          y = 368,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "traffic_light",
          class = "",
          shape = "rectangle",
          x = 342,
          y = 368,
          width = 40,
          height = 80,
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
      id = 8,
      name = "overlay",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        206, 207, 200, 201, 202, 203, 0, 0, 0, 0, 205, 206, 207, 196, 197, 198,
        0, 0, 0, 591, 591, 591, 0, 0, 0, 0, 591, 591, 591, 0, 0, 0,
        0, 0, 0, 0, 514, 591, 0, 0, 0, 0, 591, 591, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
      name = "objects_lightsets",
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
          id = 39,
          name = "lightset",
          class = "",
          shape = "rectangle",
          x = 485,
          y = 320,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "lightset",
          class = "",
          shape = "rectangle",
          x = 90,
          y = 320,
          width = 75,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
