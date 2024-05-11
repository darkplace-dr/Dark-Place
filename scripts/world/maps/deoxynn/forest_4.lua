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
  nextlayerid = 7,
  nextobjectid = 13,
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
        56, 3, 56, 56, 41, 56, 45, 47, 56, 56, 56, 45, 56, 56, 56, 56,
        56, 56, 56, 2, 56, 56, 56, 56, 41, 56, 39, 56, 56, 56, 56, 40,
        11, 56, 41, 56, 56, 39, 56, 56, 3, 56, 10, 56, 38, 56, 56, 56,
        56, 40, 56, 56, 11, 56, 56, 41, 56, 56, 56, 39, 56, 56, 11, 56,
        56, 56, 39, 56, 38, 56, 56, 56, 40, 56, 56, 56, 56, 41, 56, 56,
        56, 3, 56, 56, 56, 56, 56, 2, 56, 39, 56, 56, 56, 2, 56, 56,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
        145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146,
        156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135,
        145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146,
        156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 640,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 280,
          width = 640,
          height = 200,
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
          id = 5,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 40,
          width = 20,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "forest_3",
            ["marker"] = "for4"
          }
        },
        {
          id = 6,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 40,
          width = 0,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "forest.meet_up1"
          }
        },
        {
          id = 7,
          name = "npc",
          type = "",
          shape = "point",
          x = 440,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "stacy",
            ["facing"] = "right",
            ["flagcheck"] = "!Stacy1"
          }
        },
        {
          id = 8,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 625,
          y = 40,
          width = 20,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "forest_5",
            ["marker"] = "for4"
          }
        },
        {
          id = 10,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 40,
          width = 0,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "secret.pocketwatch",
            ["once"] = false
          }
        },
        {
          id = 11,
          name = "shine",
          type = "",
          shape = "point",
          x = 200,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["cond"] = "secret_flowers and not secret_shine"
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
          id = 3,
          name = "for3",
          type = "",
          shape = "point",
          x = 40,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "for5",
          type = "",
          shape = "point",
          x = 600,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "alexa_goto",
          type = "",
          shape = "point",
          x = 240,
          y = 160,
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
        145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146,
        114, 157, 114, 157, 114, 157, 114, 157, 114, 157, 114, 157, 114, 157, 114, 157,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
