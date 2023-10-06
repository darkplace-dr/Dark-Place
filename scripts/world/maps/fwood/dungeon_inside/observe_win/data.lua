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
  nextobjectid = 11,
  properties = {
    ["music"] = "jamm_dungeon"
  },
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
        0, 0, 0, 0, 22, 23, 29, 23, 23, 23, 23, 24, 0, 0, 0, 0,
        0, 0, 0, 0, 23, 23, 23, 23, 23, 23, 30, 23, 0, 0, 0, 0,
        0, 0, 0, 0, 37, 38, 37, 37, 36, 37, 37, 37, 0, 0, 0, 0,
        0, 0, 0, 0, 42, 58, 58, 58, 58, 58, 58, 39, 0, 0, 0, 0,
        0, 0, 0, 0, 52, 34, 51, 51, 33, 51, 51, 50, 0, 0, 0, 0,
        0, 0, 0, 0, 52, 51, 51, 51, 51, 51, 34, 50, 0, 0, 0, 0,
        0, 0, 0, 0, 52, 51, 40, 51, 51, 51, 51, 50, 0, 0, 0, 0,
        0, 0, 0, 0, 35, 44, 44, 45, 43, 44, 44, 32, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 52, 50, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 52, 50, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 52, 50, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 52, 50, 0, 0, 0, 0, 0, 0, 0
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
          x = 0,
          y = 0,
          width = 640,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 120,
          width = 160,
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
          y = 120,
          width = 160,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
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
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 320,
          width = 280,
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
      id = 3,
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
          name = "entry",
          type = "",
          shape = "point",
          x = 320,
          y = 440,
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
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "a_dungeon.observe_key",
            ["flagcheck"] = "!acj_observe_key"
          }
        },
        {
          id = 9,
          name = "shine",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 120,
          width = 20,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "!acj_observe_key"
          }
        },
        {
          id = 10,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/observe_trial",
            ["marker"] = "prize"
          }
        }
      }
    }
  }
}
