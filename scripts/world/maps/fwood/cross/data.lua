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
  nextlayerid = 6,
  nextobjectid = 18,
  properties = {
    ["music"] = "forgotten_wood"
  },
  tilesets = {
    {
      name = "forgotten_wood",
      firstgid = 1,
      filename = "../../../tilesets/forgotten_wood.tsx"
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
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 39, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 41, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 47, 56, 56, 56, 56, 56, 56, 56, 56, 56, 40, 56,
        56, 56, 56, 41, 56, 56, 56, 56, 56, 56, 39, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 39, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 39, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 41, 56, 56,
        56, 56, 47, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 40, 56,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 39, 56, 56, 41, 56, 56, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56
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
        151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 93, 150, 151, 150, 151, 150,
        151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 93, 150, 151, 150, 151, 150,
        151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 93, 150, 151, 150, 151, 150,
        146, 147, 146, 147, 146, 147, 102, 0, 0, 0, 104, 147, 146, 147, 146, 147,
        157, 156, 157, 156, 157, 156, 113, 0, 0, 0, 115, 156, 157, 156, 157, 116,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        135, 134, 135, 134, 135, 83, 84, 0, 0, 0, 82, 134, 135, 134, 135, 83,
        151, 150, 151, 150, 151, 94, 95, 0, 0, 0, 93, 150, 151, 150, 151, 150,
        151, 150, 151, 150, 151, 94, 95, 0, 0, 0, 93, 150, 151, 150, 151, 150,
        151, 150, 151, 150, 151, 94, 95, 0, 0, 0, 93, 150, 151, 150, 151, 150
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          x = 0,
          y = 0,
          width = 280,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 0,
          width = 240,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 320,
          width = 280,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 320,
          width = 240,
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
          name = "up",
          type = "",
          shape = "point",
          x = 340,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "down",
          type = "",
          shape = "point",
          x = 340,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "left",
          type = "",
          shape = "point",
          x = 40,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "right",
          type = "",
          shape = "point",
          x = 600,
          y = 260,
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
      id = 5,
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
          id = 13,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 280,
          y = -40,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.up",
            ["once"] = false
          }
        },
        {
          id = 14,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 480,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.down",
            ["once"] = false
          }
        },
        {
          id = 15,
          name = "script",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.left",
            ["once"] = false
          }
        },
        {
          id = 16,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.right",
            ["once"] = false
          }
        },
        {
          id = 17,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 400,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "binaribeans",
            ["name"] = "Binaribean"
          }
        }
      }
    }
  }
}
