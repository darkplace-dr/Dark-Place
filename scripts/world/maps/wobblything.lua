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
  nextlayerid = 5,
  nextobjectid = 24,
  properties = {
    ["use_footstep_sounds"] = "true"
  },
  tilesets = {
    {
      name = "castle_1f",
      firstgid = 1,
      filename = "../tilesets/castle_1f.tsx",
      exportfilename = "../tilesets/castle_1f.lua"
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
        89, 89, 89, 89, 89, 90, 90, 89, 89, 89, 89, 88, 88, 89, 90, 0,
        54, 54, 54, 54, 54, 5, 18, 54, 54, 4, 54, 2, 3, 54, 5, 0,
        54, 54, 54, 6, 54, 5, 5, 20, 36, 20, 20, 3, 3, 4, 5, 0,
        54, 54, 54, 54, 54, 18, 21, 70, 73, 73, 71, 19, 3, 54, 5, 0,
        20, 36, 20, 20, 20, 37, 70, 82, 82, 52, 82, 71, 3, 54, 5, 0,
        73, 73, 73, 73, 73, 74, 82, 68, 82, 82, 82, 82, 3, 54, 18, 0,
        1073741897, 1073741897, 1073741897, 1073741897, 1073741897, 3221225544, 82, 82, 82, 82, 82, 82, 2, 54, 5, 0,
        89, 89, 89, 89, 89, 90, 1073741894, 82, 82, 82, 66, 1073741895, 3, 54, 5, 0,
        54, 54, 54, 54, 6, 5, 90, 1073741894, 1073741897, 1073741897, 1073741895, 88, 3, 54, 5, 0,
        54, 54, 4, 54, 54, 18, 5, 89, 89, 89, 89, 2, 3, 54, 5, 0,
        54, 54, 54, 54, 22, 5, 5, 6, 54, 54, 54, 3, 3, 54, 18, 0,
        34, 54, 54, 54, 54, 5, 5, 54, 54, 54, 22, 3, 3, 54, 5, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "collision",
      class = "",
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 120,
          width = 40,
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
          x = 280,
          y = 80,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          class = "",
          shape = "rectangle",
          x = 480,
          y = 160,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 360,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 280,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 240,
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
          id = 11,
          name = "wobblything",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 250,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["accurate"] = false,
            ["scanend"] = 0,
            ["scanstart"] = -140
          }
        },
        {
          id = 14,
          name = "script",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 160,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "wobblything.wobblything",
            ["once"] = true
          }
        },
        {
          id = 19,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -40,
          y = 200,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/east_wing",
            ["marker"] = "entry2"
          }
        },
        {
          id = 22,
          name = "sprite",
          class = "",
          shape = "rectangle",
          x = 246,
          y = 80,
          width = 25,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["speed"] = 0.25,
            ["texture"] = "world/maps/chapter1/torch"
          }
        },
        {
          id = 23,
          name = "sprite",
          class = "",
          shape = "rectangle",
          x = 448,
          y = 80,
          width = 25,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["speed"] = 0.25,
            ["texture"] = "world/maps/chapter1/torch"
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
          name = "spawn",
          class = "",
          shape = "point",
          x = 80,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "entry",
          class = "",
          shape = "point",
          x = 40,
          y = 240,
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
