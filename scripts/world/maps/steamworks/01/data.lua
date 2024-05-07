return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 28,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 8,
  properties = {
    ["light"] = true,
    ["music"] = "undertale_yellow/abandoned"
  },
  tilesets = {
    {
      name = "steamworks",
      firstgid = 1,
      filename = "../../../tilesets/steamworks.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 28,
      id = 1,
      name = "Tile Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 20,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 440, 0, 94, 95, 96, 0, 440, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 407, 0, 94, 95, 96, 0, 407, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 407, 0, 94, 95, 96, 0, 407, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 407, 0, 94, 95, 96, 0, 407, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 440, 0, 94, 95, 96, 0, 440, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 94, 95, 96, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 128, 129, 130, 0, 0, 0, 0, 0, 0, 0
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
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 380,
          y = 0,
          width = 40,
          height = 1120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 220,
          y = 0,
          width = 40,
          height = 1120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 220,
          y = 1120,
          width = 200,
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
          id = 6,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 0,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "steamworks/02",
            ["marker"] = "down"
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
          id = 5,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 1040,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "up",
          type = "",
          shape = "point",
          x = 320,
          y = 80,
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
