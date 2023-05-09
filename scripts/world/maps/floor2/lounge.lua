return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 21,
  height = 16,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 39,
  properties = {
    ["music"] = "deltarune/castletown"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../../tilesets/castle.tsx",
      exportfilename = "../../tilesets/castle.lua"
    },
    {
      name = "castle_1f",
      firstgid = 61,
      filename = "../../tilesets/castle_1f.tsx",
      exportfilename = "../../tilesets/castle_1f.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 21,
      height = 16,
      id = 2,
      name = "tiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        115, 115, 115, 115, 115, 115, 115, 148, 149, 149, 149, 149, 149, 150, 115, 115, 115, 115, 115, 115, 115,
        115, 115, 115, 115, 115, 115, 115, 63, 82, 114, 114, 114, 114, 78, 115, 115, 115, 115, 115, 115, 115,
        148, 149, 149, 149, 149, 149, 150, 62, 114, 114, 114, 114, 66, 65, 148, 149, 149, 149, 149, 149, 149,
        114, 114, 114, 114, 114, 94, 65, 95, 80, 80, 80, 80, 80, 97, 63, 114, 82, 114, 114, 114, 114,
        72, 73, 74, 75, 76, 114, 65, 130, 133, 146, 144, 147, 133, 131, 62, 114, 72, 73, 74, 75, 76,
        88, 89, 90, 91, 92, 82, 78, 142, 126, 142, 142, 142, 142, 142, 63, 114, 88, 89, 90, 91, 92,
        114, 105, 106, 107, 98, 99, 65, 142, 142, 142, 142, 142, 142, 142, 63, 98, 99, 105, 106, 107, 64,
        80, 121, 122, 123, 80, 80, 81, 142, 142, 142, 142, 142, 142, 142, 79, 80, 96, 121, 122, 123, 80,
        142, 142, 142, 142, 142, 110, 142, 142, 142, 142, 142, 126, 142, 142, 142, 142, 142, 142, 142, 142, 142,
        142, 142, 128, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 112, 142, 142,
        142, 142, 142, 142, 142, 142, 142, 142, 126, 142, 142, 142, 142, 142, 142, 110, 142, 142, 142, 142, 142,
        3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225619, 142, 142, 142, 142, 112, 3221225618, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605,
        149, 149, 149, 149, 149, 149, 150, 1610612869, 142, 142, 142, 142, 142, 2684354693, 148, 149, 149, 149, 149, 149, 149,
        114, 114, 114, 114, 114, 114, 65, 1610612869, 142, 142, 142, 142, 142, 2684354693, 63, 114, 114, 114, 114, 114, 114,
        114, 114, 82, 114, 114, 114, 78, 1610612869, 142, 142, 142, 142, 142, 2684354693, 63, 114, 114, 82, 114, 114, 114,
        94, 114, 114, 114, 114, 114, 65, 1610612869, 142, 142, 142, 142, 142, 2684354693, 62, 114, 114, 114, 114, 114, 94
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
      name = "collision",
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 140,
          y = 160,
          width = 140,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 120,
          width = 100,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 160,
          width = 140,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
          width = 280,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 480,
          width = 280,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 460,
          y = 120,
          width = 100,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 60,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "rectangle",
          x = 780,
          y = 160,
          width = 60,
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
      id = 7,
      name = "objects",
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
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 378,
          y = 160,
          width = 84,
          height = 5,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "elevator",
            ["marker"] = "spawn"
          }
        },
        {
          id = 27,
          name = "",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 320,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 640,
          width = 280,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 29,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 320,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 58,
          y = 315,
          width = 84,
          height = 5,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "entry"
          }
        },
        {
          id = 34,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 698,
          y = 315,
          width = 84,
          height = 5,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "entry"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "markers",
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
          name = "entry_elevator",
          type = "",
          shape = "point",
          x = 418,
          y = 190,
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
