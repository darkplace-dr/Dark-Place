return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 14,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 8,
  nextobjectid = 30,
  properties = {
    ["border"] = "simple"
  },
  tilesets = {
    {
      name = "bg_dw_mansion_spamton_basement",
      firstgid = 1,
      filename = "../tilesets/basement1.tsx"
    },
    {
      name = "bg_dw_mansion_basement_door",
      firstgid = 53,
      filename = "../tilesets/basement2.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 14,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 49, 0, 0, 0,
        0, 0, 0, 49, 50, 49, 49, 50, 49, 52, 52, 49, 50, 49, 49, 50, 49, 0, 0, 0,
        0, 0, 0, 49, 49, 49, 49, 49, 49, 52, 52, 49, 49, 49, 49, 49, 49, 0, 0, 0,
        0, 0, 0, 38, 34, 30, 30, 29, 30, 30, 30, 30, 29, 30, 34, 30, 30, 0, 0, 0,
        0, 0, 0, 42, 29, 30, 30, 33, 30, 30, 30, 30, 30, 30, 29, 30, 30, 0, 0, 0,
        0, 0, 0, 30, 30, 30, 30, 30, 30, 30, 29, 30, 30, 30, 30, 33, 30, 0, 0, 0,
        0, 0, 0, 33, 30, 30, 29, 30, 30, 30, 30, 30, 30, 29, 30, 30, 30, 0, 0, 0,
        0, 0, 0, 30, 30, 30, 30, 34, 30, 30, 34, 30, 30, 30, 30, 30, 29, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 30, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          class = "",
          shape = "rectangle",
          x = 320,
          y = 440,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 440,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          class = "",
          shape = "rectangle",
          x = 480,
          y = 440,
          width = 200,
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
          x = 440,
          y = 440,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          class = "",
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
          id = 24,
          name = "",
          class = "",
          shape = "rectangle",
          x = 680,
          y = 240,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 27,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 200,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 28,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 200,
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
      id = 7,
      name = "objects_bg",
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
          id = 10,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 61,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 61,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 57,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 58,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 60,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 62,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
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
          id = 16,
          name = "spawn",
          class = "",
          shape = "point",
          x = 400,
          y = 360,
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
          id = 8,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 160,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamgolorneo.door",
            ["solid"] = true
          }
        },
        {
          id = 29,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 200,
          width = 80,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "controllers",
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
          id = 17,
          name = "toggle",
          class = "",
          shape = "point",
          x = 520,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "spamgolorneo_door",
            ["target"] = { id = 10 }
          }
        },
        {
          id = 18,
          name = "toggle",
          class = "",
          shape = "point",
          x = 560,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "spamgolorneo_door",
            ["target"] = { id = 11 }
          }
        },
        {
          id = 19,
          name = "toggle",
          class = "",
          shape = "point",
          x = 600,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "spamgolorneo_door",
            ["target"] = { id = 12 }
          }
        },
        {
          id = 20,
          name = "toggle",
          class = "",
          shape = "point",
          x = 640,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "spamgolorneo_door",
            ["target"] = { id = 13 }
          }
        },
        {
          id = 21,
          name = "toggle",
          class = "",
          shape = "point",
          x = 680,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "spamgolorneo_door",
            ["target"] = { id = 14 }
          }
        },
        {
          id = 22,
          name = "toggle",
          class = "",
          shape = "point",
          x = 720,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "spamgolorneo_door",
            ["target"] = { id = 15 }
          }
        },
        {
          id = 26,
          name = "toggle",
          class = "",
          shape = "point",
          x = 760,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!spamgolorneo_door",
            ["target"] = { id = 8 }
          }
        }
      }
    }
  }
}
