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
  nextlayerid = 7,
  nextobjectid = 11,
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
        115, 115, 115, 115, 115, 115, 148, 149, 149, 149, 149, 149, 149, 149, 150, 115, 115, 115, 115, 115, 115,
        115, 115, 115, 115, 115, 115, 63, 114, 114, 114, 114, 114, 114, 114, 78, 115, 115, 115, 115, 115, 115,
        148, 149, 149, 149, 149, 150, 63, 94, 114, 114, 114, 114, 98, 99, 65, 148, 149, 149, 149, 149, 149,
        114, 114, 114, 114, 114, 65, 79, 80, 80, 80, 80, 80, 80, 96, 81, 63, 114, 114, 114, 114, 114,
        114, 114, 114, 114, 64, 65, 130, 133, 133, 146, 144, 147, 133, 133, 131, 62, 114, 114, 114, 82, 114,
        114, 64, 114, 114, 114, 78, 142, 142, 126, 142, 142, 142, 142, 142, 142, 63, 114, 66, 114, 114, 114,
        114, 114, 114, 114, 82, 65, 142, 142, 142, 142, 142, 142, 142, 128, 142, 63, 114, 114, 114, 114, 64,
        80, 80, 96, 80, 80, 81, 142, 142, 142, 142, 142, 142, 142, 142, 142, 79, 96, 80, 80, 80, 80,
        142, 142, 142, 142, 142, 110, 142, 142, 142, 142, 142, 126, 142, 142, 142, 142, 142, 142, 142, 142, 142,
        142, 142, 128, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 142, 112, 142, 142,
        142, 142, 142, 142, 142, 142, 142, 142, 126, 142, 142, 142, 142, 142, 142, 110, 142, 142, 142, 142, 142,
        3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225619, 142, 142, 142, 142, 142, 112, 142, 3221225618, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605, 3221225605,
        149, 149, 149, 149, 149, 150, 1610612869, 142, 142, 142, 142, 142, 142, 142, 2684354693, 148, 149, 149, 149, 149, 149,
        114, 114, 114, 114, 114, 65, 1610612869, 142, 142, 142, 142, 142, 142, 110, 2684354693, 63, 114, 114, 114, 114, 114,
        114, 114, 82, 114, 114, 78, 1610612869, 126, 142, 142, 142, 142, 142, 142, 2684354693, 63, 114, 82, 114, 114, 114,
        94, 114, 114, 114, 114, 65, 1610612869, 142, 142, 142, 142, 142, 142, 142, 2684354693, 62, 114, 114, 114, 114, 94
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 21,
      height = 16,
      id = 3,
      name = "decor",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 49, 50, 51, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 95, 0, 0, 55, 56, 57, 0, 0, 97, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 0,
          y = 160,
          width = 240,
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
          x = 240,
          y = 120,
          width = 140,
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
          x = 600,
          y = 160,
          width = 240,
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
          width = 240,
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
          x = 600,
          y = 480,
          width = 240,
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
          width = 140,
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 8,
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
