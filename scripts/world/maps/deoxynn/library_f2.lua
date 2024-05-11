return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 24,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 25,
  properties = {
    ["light"] = true,
    ["music"] = "frivatown"
  },
  tilesets = {
    {
      name = "library_f2",
      firstgid = 1,
      filename = "../../tilesets/frivatown/library_f2.tsx",
      exportfilename = "../../tilesets/frivatown/library_f2.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 24,
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
        0, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 0, 0,
        0, 0, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 0, 0,
        0, 0, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 0, 0,
        0, 0, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 0, 0,
        0, 0, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 0, 0,
        0, 0, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 0, 0,
        0, 0, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 0, 0,
        0, 0, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 0, 0,
        0, 0, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 0, 0,
        0, 0, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 0, 0,
        0, 0, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 0, 0,
        0, 0, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 0, 0,
        0, 0, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 0, 0,
        0, 0, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168, 0, 0,
        0, 0, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 0, 0,
        0, 0, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 0, 0,
        0, 0, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 0, 0,
        0, 0, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 0, 0,
        0, 0, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 0, 0,
        0, 0, 229, 230, 231, 232, 233, 234, 235, 236, 237, 238, 239, 240, 0, 0,
        0, 0, 241, 242, 243, 244, 245, 246, 247, 248, 249, 250, 251, 252, 0, 0,
        0, 0, 253, 254, 255, 256, 257, 258, 259, 260, 261, 262, 263, 264, 0, 0,
        0, 0, 265, 266, 267, 268, 269, 270, 271, 272, 273, 274, 275, 276, 0, 0,
        0, 0, 277, 278, 279, 280, 281, 282, 283, 284, 285, 286, 287, 288, 0, 0
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 238,
          height = 148,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 436,
          y = 0,
          width = 120,
          height = 148,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 480,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 40,
          height = 960,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 920,
          width = 480,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 0,
          width = 40,
          height = 960,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 196,
          width = 320,
          height = 470,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 174,
          y = 700,
          width = 152,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 174,
          y = 826,
          width = 152,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 402,
          y = 700,
          width = 79,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 402,
          y = 826,
          width = 79,
          height = 86,
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
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 358,
          y = 105,
          width = 82,
          height = 15,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "deoxynn/library",
            ["marker"] = "lib2"
          }
        },
        {
          id = 15,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 124,
          y = 36,
          width = 78,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.upper_shelf_1",
            ["once"] = false
          }
        },
        {
          id = 16,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 202,
          y = 36,
          width = 78,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.upper_shelf_2",
            ["once"] = false
          }
        },
        {
          id = 17,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 36,
          width = 78,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.upper_shelf_3",
            ["once"] = false
          }
        },
        {
          id = 18,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 436,
          y = 36,
          width = 78,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.upper_shelf_4",
            ["once"] = false
          }
        },
        {
          id = 19,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 174,
          y = 700,
          width = 76,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.computer_1",
            ["once"] = false
          }
        },
        {
          id = 20,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 250,
          y = 700,
          width = 76,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.computer_2",
            ["once"] = false
          }
        },
        {
          id = 21,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 402,
          y = 700,
          width = 76,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.computer_3",
            ["once"] = false
          }
        },
        {
          id = 22,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 174,
          y = 826,
          width = 76,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.computer_4",
            ["once"] = false
          }
        },
        {
          id = 23,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 250,
          y = 826,
          width = 76,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.computer_5",
            ["once"] = false
          }
        },
        {
          id = 24,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 402,
          y = 826,
          width = 76,
          height = 86,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.computer_6",
            ["once"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 13,
          name = "lib1",
          type = "",
          shape = "point",
          x = 400,
          y = 160,
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
