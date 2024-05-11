return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 10,
  nextobjectid = 32,
  properties = {
    ["music"] = "forest"
  },
  tilesets = {
    {
      name = "woods",
      firstgid = 1,
      filename = "../../tilesets/woods.tsx"
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
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 39, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 41, 56, 56, 56, 56, 56, 56, 40, 56, 56, 56, 56, 56, 38, 56,
        40, 56, 56, 56, 56, 40, 56, 56, 56, 56, 34, 56, 56, 56, 56, 41,
        56, 56, 56, 56, 56, 56, 56, 56, 41, 56, 56, 56, 56, 39, 56, 56,
        56, 56, 56, 23, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 39, 56, 56, 41, 56, 56, 56, 41, 56, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 39, 56,
        56, 56, 56, 56, 40, 45, 56, 56, 56, 41, 38, 56, 56, 56, 56, 56,
        56, 56, 39, 56, 56, 56, 45, 39, 56, 56, 56, 56, 56, 56, 40, 56,
        56, 40, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 3,
      name = "Tile Layer 3",
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
        0, 0, 156, 0, 156, 0, 156, 0, 156, 0, 156, 0, 156, 0, 156, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 287, 288, 289, 0, 287, 288, 289, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 298, 299, 305, 321, 307, 299, 300, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 309, 310, 311, 306, 309, 310, 311, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "blockcollision",
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
          id = 19,
          name = "",
          type = "",
          shape = "polygon",
          x = 200,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 120, y = 0 },
            { x = 120, y = 40 },
            { x = 160, y = 40 },
            { x = 160, y = 0 },
            { x = 280, y = 0 },
            { x = 280, y = 120 },
            { x = 160, y = 120 },
            { x = 160, y = 80 },
            { x = 120, y = 80 },
            { x = 120, y = 120 },
            { x = 0, y = 120 },
            { x = 0, y = -40 },
            { x = 0, y = 120 },
            { x = 120, y = 120 },
            { x = 280, y = 120 },
            { x = 280, y = 0 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
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
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 640,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
          width = 640,
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
      id = 5,
      name = "objects_spikes",
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
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 11,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 12,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 13,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 14,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 280,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 15,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 16,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 17,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 18,
          name = "spikes",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default"] = true,
            ["flag"] = "shopspike"
          }
        },
        {
          id = 26,
          name = "tilebutton",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["blocks"] = true,
            ["cutscene"] = "bonus.shop_1",
            ["group"] = "buton",
            ["once"] = true
          }
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
          id = 27,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 285,
          width = 40,
          height = 35,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "forest.sign2",
            ["once"] = false,
            ["solid"] = true
          }
        },
        {
          id = 28,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 625,
          y = 120,
          width = 15,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "forest_3",
            ["marker"] = "fp2"
          }
        },
        {
          id = 30,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 120,
          width = 15,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "forest_shop",
            ["marker"] = "fp2"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "objects_tile",
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
          id = 25,
          name = "pushblock",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["input_lock"] = false,
            ["inputlock"] = false,
            ["lock"] = false
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 9,
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
          id = 29,
          name = "for3",
          type = "",
          shape = "point",
          x = 600,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "shop",
          type = "",
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
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "Tile Layer 2",
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
        134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135,
        145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146,
        156, 157, 114, 157, 114, 157, 114, 157, 114, 157, 114, 157, 114, 157, 114, 157,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135
      }
    }
  }
}
