return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 21,
  height = 16,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 53,
  properties = {
    ["border"] = "castle",
    ["music"] = "deltarune/castletown",
    ["name"] = "Floor 2 - Lounge"
  },
  tilesets = {
    {
      name = "castle_1f",
      firstgid = 1,
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
        55, 55, 55, 55, 55, 55, 55, 88, 99, 100, 101, 102, 103, 90, 55, 55, 55, 55, 55, 55, 55,
        55, 55, 55, 55, 55, 55, 55, 3, 91, 92, 93, 94, 95, 18, 55, 55, 55, 55, 55, 55, 55,
        88, 89, 89, 89, 89, 89, 90, 2, 107, 108, 109, 110, 111, 5, 88, 89, 89, 89, 89, 89, 89,
        54, 54, 54, 54, 54, 34, 5, 35, 123, 124, 125, 126, 127, 37, 3, 54, 22, 54, 54, 54, 54,
        12, 13, 14, 15, 16, 54, 5, 70, 73, 86, 84, 87, 73, 71, 2, 54, 12, 13, 14, 15, 16,
        28, 29, 30, 31, 32, 22, 18, 82, 66, 82, 82, 82, 82, 82, 3, 54, 28, 29, 30, 31, 32,
        54, 45, 46, 47, 38, 39, 5, 82, 82, 82, 82, 82, 82, 82, 3, 38, 39, 45, 46, 47, 4,
        20, 61, 62, 63, 20, 20, 21, 82, 82, 82, 82, 82, 82, 82, 19, 20, 36, 61, 62, 63, 20,
        82, 82, 82, 82, 82, 50, 82, 82, 82, 82, 82, 66, 82, 82, 82, 82, 82, 82, 82, 82, 82,
        82, 82, 68, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 52, 82, 82,
        82, 82, 82, 82, 82, 82, 82, 82, 66, 82, 82, 82, 82, 82, 82, 50, 82, 82, 82, 82, 82,
        3221225545, 3221225545, 3221225545, 3221225545, 3221225545, 3221225545, 3221225545, 3221225559, 82, 82, 82, 82, 52, 3221225558, 3221225545, 3221225545, 3221225545, 3221225545, 3221225545, 3221225545, 3221225545,
        89, 89, 89, 89, 89, 89, 90, 1610612809, 82, 82, 82, 82, 82, 2684354633, 88, 89, 89, 89, 89, 89, 89,
        54, 54, 54, 54, 54, 54, 5, 1610612809, 82, 82, 82, 82, 82, 2684354633, 3, 54, 54, 54, 54, 54, 54,
        54, 54, 22, 54, 54, 54, 18, 1610612809, 82, 82, 82, 82, 82, 2684354633, 3, 54, 54, 22, 54, 54, 54,
        34, 54, 54, 54, 54, 54, 5, 1610612809, 82, 82, 82, 82, 82, 2684354633, 2, 54, 54, 54, 54, 54, 34
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
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 378,
          y = 140,
          width = 84,
          height = 20,
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
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 320,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/east_wing",
            ["marker"] = "entry"
          }
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
            ["map"] = "floor2/doors_left",
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
            ["map"] = "floor2/doors_right",
            ["marker"] = "entry"
          }
        },
        {
          id = 46,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 380,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "sprite",
          type = "",
          shape = "rectangle",
          x = 208,
          y = 160,
          width = 25,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["speed"] = 0.25,
            ["texture"] = "objects/torch/torch"
          }
        },
        {
          id = 50,
          name = "sprite",
          type = "",
          shape = "rectangle",
          x = 328,
          y = 40,
          width = 25,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["speed"] = 0.25,
            ["texture"] = "objects/torch/torch"
          }
        },
        {
          id = 51,
          name = "sprite",
          type = "",
          shape = "rectangle",
          x = 488,
          y = 40,
          width = 25,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["speed"] = 0.25,
            ["texture"] = "objects/torch/torch"
          }
        },
        {
          id = 52,
          name = "sprite",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 160,
          width = 25,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["speed"] = 0.25,
            ["texture"] = "objects/torch/torch"
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
        },
        {
          id = 45,
          name = "entry_doorsright",
          type = "",
          shape = "point",
          x = 740,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "entry_doorsleft",
          type = "",
          shape = "point",
          x = 100,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 48,
          name = "entry_east",
          type = "",
          shape = "point",
          x = 800,
          y = 400,
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
