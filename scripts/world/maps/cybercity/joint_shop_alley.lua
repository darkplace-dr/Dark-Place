return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 22,
  height = 13,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 20,
  properties = {
    ["border"] = "city",
    ["music"] = "deltarune/cybercity"
  },
  tilesets = {
    {
      name = "bg_dw_city",
      firstgid = 1,
      filename = "../../tilesets/bg_dw_city.tsx",
      exportfilename = "../../tilesets/bg_dw_city.lua"
    },
    {
      name = "dw_city_street",
      firstgid = 613,
      filename = "../../tilesets/dw_city_street.tsx"
    },
    {
      name = "street_edges",
      firstgid = 723,
      filename = "../../tilesets/street_edges.tsx",
      exportfilename = "../../tilesets/street_edges.lua"
    },
    {
      name = "city_sidewalk",
      firstgid = 931,
      filename = "../../tilesets/city_sidewalk.tsx",
      exportfilename = "../../tilesets/city_sidewalk.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 22,
      height = 13,
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
        530, 497, 375, 377, 378, 379, 380, 381, 2147484023, 317, 318, 318, 319, 174, 174, 175, 176, 177, 177, 177, 177, 178,
        501, 495, 520, 521, 522, 523, 524, 525, 526, 334, 335, 335, 336, 18, 19, 20, 21, 22, 23, 24, 25, 26,
        518, 495, 537, 538, 539, 540, 541, 542, 543, 351, 352, 352, 353, 35, 36, 37, 38, 39, 40, 41, 42, 43,
        535, 468, 554, 555, 556, 557, 558, 559, 560, 530, 169, 237, 530, 52, 53, 54, 55, 56, 57, 58, 59, 60,
        471, 485, 571, 572, 573, 574, 575, 576, 577, 530, 186, 254, 530, 69, 70, 71, 72, 73, 74, 75, 76, 77,
        488, 502, 588, 589, 590, 591, 592, 593, 594, 530, 203, 271, 530, 86, 87, 88, 89, 90, 91, 92, 93, 94,
        505, 497, 605, 606, 607, 608, 609, 610, 611, 279, 280, 280, 281, 103, 104, 105, 106, 107, 108, 109, 110, 111,
        693, 781, 693, 781, 693, 781, 693, 781, 780, 781, 780, 781, 780, 781, 780, 781, 780, 781, 780, 781, 780, 781,
        661, 658, 661, 658, 661, 658, 661, 658, 793, 794, 793, 794, 793, 794, 793, 794, 793, 794, 793, 794, 793, 658,
        675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 675, 672,
        686, 1055, 686, 687, 1055, 686, 686, 1055, 686, 686, 1055, 686, 687, 1055, 686, 686, 1055, 687, 686, 1055, 687, 687,
        1057, 1057, 1057, 1057, 1057, 1057, 1057, 1058, 1059, 1057, 1057, 1057, 1057, 1057, 1058, 1059, 1057, 1057, 1057, 1058, 1059, 687,
        273, 274, 275, 279, 280, 281, 946, 946, 946, 946, 946, 947, 946, 946, 946, 946, 946, 946, 403, 946, 947, 401
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
          width = 880,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 878.055,
          height = 279.94,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 878.055,
          height = 279.94,
          rotation = 0,
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
      class = "interactable",
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
          name = "city_screen",
          type = "",
          shape = "rectangle",
          x = 375.544,
          y = 17.2163,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "buy"
          }
        },
        {
          id = 2,
          name = "city_screen",
          type = "",
          shape = "rectangle",
          x = 7.72536,
          y = 26.5577,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "deals"
          }
        },
        {
          id = 3,
          name = "lightset",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 0,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "city_screen",
          type = "",
          shape = "rectangle",
          x = 456.114,
          y = 192.368,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "ad"
          }
        },
        {
          id = 6,
          name = "city_screen",
          type = "",
          shape = "rectangle",
          x = 250.483,
          y = 49.7116,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "look"
          }
        },
        {
          id = 7,
          name = "city_screen",
          type = "",
          shape = "rectangle",
          x = 811.15,
          y = 87.138,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["sprite"] = "look"
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 86,
          y = 160,
          width = 74,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* The door is closed but there's a note!",
            ["text2"] = "* (We plan to open soon!)",
            ["text3"] = "* (- Click and Button Addison)"
          }
        },
        {
          id = 17,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 160,
          width = 120,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* The door is closed but there's a note!",
            ["text2"] = "* (We plan to open soon!)",
            ["text3"] = "* (- Click and Button Addison)"
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
          id = 11,
          name = "entry_left",
          type = "",
          shape = "point",
          x = 40,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "entry_right",
          type = "",
          shape = "point",
          x = 840,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "spawn",
          type = "",
          shape = "point",
          x = 440,
          y = 400,
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
      width = 22,
      height = 13,
      id = 3,
      name = "fg",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 553, 553, 553, 553, 553, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 570, 570, 570, 570, 570, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 587, 587, 587, 587, 587, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        129, 130, 131, 146, 147, 148, 95, 96, 97, 163, 164, 146, 147, 148, 112, 113, 114, 95, 96, 97, 163, 164,
        0, 0, 0, 0, 0, 0, 234, 235, 120, 121, 122, 123, 124, 125, 126, 127, 128, 0, 0, 153, 0, 0
      }
    }
  }
}
