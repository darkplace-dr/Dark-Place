return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 7,
  properties = {
    ["border"] = "castle",
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 52, 51, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 34, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 33, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 41, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 25, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 41, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 51, 50, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 52, 51, 40, 50, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 240,
          height = 480,
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
          height = 480,
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
        },
        {
          id = 6,
          name = "trial",
          type = "",
          shape = "point",
          x = 320,
          y = 40,
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
          x = 240,
          y = -40,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/combat_trial",
            ["marker"] = "entry"
          }
        },
        {
          id = 4,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 480,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/floor2_main",
            ["marker"] = "combat"
          }
        }
      }
    }
  }
}
