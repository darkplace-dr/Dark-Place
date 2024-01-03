return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 31,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 94,
  properties = {
    ["border"] = "monotonecastle",
    ["music"] = "deltarune/castletown",
    ["name"] = "New Town"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../../../tilesets/castle.tsx",
      exportfilename = "../../../tilesets/castle.lua"
    },
    {
      name = "bg_dw_castle_1f_mono",
      firstgid = 61,
      filename = "../../../tilesets/bg_dw_castle_1f_mono.tsx",
      exportfilename = "../../../tilesets/bg_dw_castle_1f_mono.lua"
    },
    {
      name = "dw_bf2",
      firstgid = 253,
      filename = "../../../tilesets/dw_bf2.tsx",
      exportfilename = "../../../tilesets/dw_bf2.lua"
    },
    {
      name = "other-objects",
      firstgid = 393,
      filename = "../../../tilesets/other-objects.tsx",
      exportfilename = "../../../tilesets/other-objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 31,
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
        115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 148, 149, 149, 149, 149, 149, 150, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115,
        115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 62, 135, 136, 137, 138, 139, 65, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115,
        115, 115, 115, 115, 149, 149, 149, 149, 149, 149, 149, 150, 63, 151, 152, 153, 154, 155, 66, 148, 149, 149, 149, 149, 149, 149, 149, 115, 115, 115, 115,
        115, 115, 115, 115, 114, 72, 73, 74, 75, 76, 114, 78, 63, 167, 168, 169, 170, 171, 65, 62, 67, 68, 69, 70, 71, 114, 82, 115, 115, 115, 115,
        115, 115, 115, 115, 114, 88, 212, 213, 214, 92, 64, 65, 95, 183, 184, 185, 186, 187, 97, 63, 83, 212, 213, 214, 87, 66, 114, 115, 115, 115, 115,
        115, 115, 115, 115, 82, 114, 228, 229, 230, 98, 99, 78, 130, 133, 146, 144, 147, 133, 131, 62, 114, 228, 229, 230, 98, 99, 64, 115, 115, 115, 115,
        115, 115, 115, 115, 96, 80, 244, 245, 246, 80, 96, 81, 142, 142, 142, 142, 142, 142, 142, 79, 80, 244, 245, 246, 96, 80, 80, 115, 115, 115, 115,
        115, 115, 115, 115, 130, 133, 146, 144, 147, 133, 133, 134, 112, 144, 144, 144, 144, 144, 144, 132, 133, 146, 144, 147, 133, 133, 131, 115, 115, 115, 115,
        115, 115, 115, 115, 144, 144, 144, 144, 112, 142, 142, 142, 142, 144, 144, 144, 144, 144, 128, 144, 144, 144, 144, 144, 144, 144, 126, 115, 115, 115, 115,
        115, 115, 115, 115, 144, 112, 144, 144, 144, 144, 144, 128, 142, 144, 144, 144, 144, 112, 144, 144, 144, 144, 128, 144, 144, 144, 144, 115, 115, 115, 115,
        115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 144, 144, 144, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115,
        115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 144, 144, 144, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115, 115
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_bg",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 44,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 400,
          width = 400,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 45,
          name = "",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 400,
          width = 400,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 280,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 280,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 240,
          width = 100,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 342,
          y = 200,
          width = 138,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 53,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 120,
          width = 100,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 56,
          name = "",
          type = "",
          shape = "rectangle",
          x = 662,
          y = 120,
          width = 100,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 200,
          width = 100,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
          type = "",
          shape = "rectangle",
          x = 942,
          y = 200,
          width = 138,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 91,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 240,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 92,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 240,
          width = 120,
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
          id = 43,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 460,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor3/connection_4",
            ["marker"] = "entrydown"
          }
        },
        {
          id = 61,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 380,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* (2F : LIVING QUARTERS)"
          }
        },
        {
          id = 62,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 980,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* (BF : LIVING QUARTERS FOR BAD\nGUYS)"
          }
        },
        {
          id = 93,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 581,
          y = 140,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor3/connection_6",
            ["marker"] = "entryup"
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
          id = 40,
          name = "entrydown",
          type = "",
          shape = "point",
          x = 620,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 42,
          name = "entryup",
          type = "",
          shape = "point",
          x = 620,
          y = 440,
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
      id = 6,
      name = "controllers",
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
