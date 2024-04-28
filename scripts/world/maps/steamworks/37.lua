return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 39,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 11,
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
      width = 39,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 895, 0, 0, 929, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 895, 0, 0, 895, 0, 0, 929, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 929, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 929, 0, 0, 929, 0, 0, 895, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 929, 0, 0, 895, 0, 0, 895, 0, 0, 929, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0,
        0, 0, 0, 0, 0, 0, 959, 960, 960, 960, 961, 0, 0, 0, 0, 0, 0, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0,
        0, 0, 0, 0, 0, 0, 885, 886, 886, 886, 887, 0, 0, 0, 0, 0, 0, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0, 0, 895, 0,
        0, 0, 0, 0, 0, 0, 885, 958, 886, 886, 923, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960, 960,
        0, 0, 0, 0, 0, 0, 885, 886, 886, 958, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886, 886,
        0, 0, 0, 0, 0, 0, 919, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920, 920,
        0, 0, 0, 0, 0, 0, 962, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963,
        0, 0, 0, 0, 0, 0, 962, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963, 963
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
          x = 200,
          y = 160,
          width = 40,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 160,
          width = 40,
          height = 120,
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
          y = 160,
          width = 200,
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
          x = 240,
          y = 400,
          width = 1320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 240,
          width = 1080,
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
          x = 1520,
          y = 280,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "steamworks/36",
            ["marker"] = "left"
          }
        },
        {
          id = 9,
          name = "stw_elevator",
          type = "",
          shape = "point",
          x = 340,
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
          id = 7,
          name = "right",
          type = "",
          shape = "point",
          x = 1480,
          y = 340,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "elevator",
          type = "",
          shape = "point",
          x = 340,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "spawn",
          type = "",
          shape = "point",
          x = 1400,
          y = 340,
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
