return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 10,
  properties = {},
  tilesets = {
    {
      name = "jamm_dungeon",
      firstgid = 1,
      filename = "../../../../tilesets/jamm_dungeon.tsx"
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
        23, 31, 23, 23, 31, 23, 23, 23, 23, 30, 23, 29, 23, 23, 24, 0,
        22, 23, 23, 23, 23, 23, 23, 30, 23, 23, 29, 23, 23, 31, 23, 0,
        37, 37, 36, 37, 37, 38, 37, 37, 37, 37, 37, 37, 38, 37, 36, 0,
        58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 39, 0,
        51, 34, 51, 33, 51, 51, 51, 51, 51, 41, 51, 51, 51, 51, 50, 0,
        51, 51, 51, 51, 51, 40, 51, 51, 51, 51, 51, 51, 51, 33, 50, 0,
        51, 51, 34, 51, 51, 51, 41, 51, 51, 51, 51, 40, 51, 51, 50, 0,
        41, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 50, 0,
        51, 51, 51, 51, 40, 51, 51, 51, 33, 51, 51, 51, 51, 51, 50, 0,
        51, 51, 33, 51, 51, 51, 51, 51, 51, 51, 51, 51, 34, 51, 50, 0,
        44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 32, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 20, 21, 0, 0, 0, 0, 0, 0,
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
          id = 2,
          name = "shine",
          type = "",
          shape = "point",
          x = 560,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "npc",
          type = "",
          shape = "point",
          x = 480,
          y = -40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "shade_ania"
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
          name = "jamm_spawn",
          type = "",
          shape = "point",
          x = -40,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "dess_spawn",
          type = "",
          shape = "point",
          x = -80,
          y = 360,
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
