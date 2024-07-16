return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.11.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 17,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 7,
  properties = {
    ["light"] = true
  },
  tilesets = {
    {
      name = "steamworks",
      firstgid = 1,
      filename = "../../tilesets/steamworks.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 17,
      id = 1,
      name = "ground",
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
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479,
        479, 479, 479, 479, 479, 479, 446, 69, 71, 444, 479, 479, 479, 479, 479, 479
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
          x = 360,
          y = 0,
          width = 40,
          height = 680,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 0,
          width = 40,
          height = 680,
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
          id = 3,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 680,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "steamworks/13",
            ["marker"] = "door"
          }
        },
        {
          id = 4,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 360,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "steamworks.basement_axis",
            ["once"] = false
          }
        },
        {
          id = 5,
          name = "npc",
          type = "",
          shape = "point",
          x = 320,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "axis"
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
          id = 6,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 640,
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
