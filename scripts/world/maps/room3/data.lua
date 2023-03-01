return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 28,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 22,
  properties = {
    ["music"] = "none"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../../tilesets/castle.tsx"
    },
    {
      name = "objects",
      firstgid = 43,
      filename = "../../tilesets/objects.tsx",
      exportfilename = "../../tilesets/objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 28,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 12, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 18, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 20, 10, 12, 18, 19, 19, 19, 19, 19, 19, 19, 20,
        0, 0, 0, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 10, 12, 22, 23, 23, 23, 23, 23, 23, 23, 24,
        0, 0, 0, 22, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 10, 12, 22, 23, 23, 23, 23, 23, 23, 23, 24,
        0, 0, 0, 26, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 27, 28, 10, 12, 26, 27, 27, 27, 27, 27, 27, 27, 27,
        0, 0, 0, 6, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 7, 11, 11, 7, 7, 7, 7, 7, 7, 7, 7, 7,
        0, 0, 0, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        0, 0, 0, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        0, 0, 0, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11,
        0, 0, 0, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 120,
          y = 200,
          width = 560,
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
          x = 80,
          y = 240,
          width = 40,
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
          x = 120,
          y = 440,
          width = 1000,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 200,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 0,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 0,
          width = 40,
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
      id = 3,
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
          id = 4,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 240,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "room1",
            ["marker"] = "entry2"
          }
        },
        {
          id = 8,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 40,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "spamroom",
            ["marker"] = "entry"
          }
        },
        {
          id = 13,
          name = "whitedoor",
          type = "",
          shape = "point",
          x = 960,
          y = 244,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 770,
          y = 180,
          width = 132,
          height = 80,
          rotation = 0,
          gid = 50,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "npc",
          type = "",
          shape = "point",
          x = 420,
          y = 262,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "morshu",
            ["cutscene"] = "room3.morshu"
          }
        },
        {
          id = 19,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 120,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "room3.spam_graffiti"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 6,
          name = "entry",
          type = "",
          shape = "point",
          x = 1080,
          y = 350,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "exit_spamroom",
          type = "",
          shape = "point",
          x = 720,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "spawn",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 350,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "exit_whitespace",
          type = "",
          shape = "point",
          x = 960,
          y = 280,
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
