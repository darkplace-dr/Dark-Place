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
  nextlayerid = 8,
  nextobjectid = 9,
  properties = {
    ["border"] = "deoxynn/deep_forest"
  },
  tilesets = {
    {
      name = "forgotten_wood",
      firstgid = 1,
      filename = "../../../tilesets/forgotten_wood.tsx"
    },
    {
      name = "jamm_dungeon",
      firstgid = 430,
      filename = "../../../tilesets/jamm_dungeon.tsx"
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
        452, 452, 452, 459, 452, 452, 452, 452, 460, 452, 452, 452, 452, 452, 452, 458,
        452, 452, 452, 452, 452, 458, 452, 452, 452, 452, 452, 452, 459, 452, 452, 452,
        460, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 458, 452,
        452, 452, 459, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452, 452,
        452, 452, 452, 452, 452, 452, 452, 452, 452, 459, 452, 452, 452, 460, 452, 452,
        466, 467, 466, 466, 466, 465, 466, 466, 466, 466, 467, 465, 466, 466, 467, 466,
        60, 60, 60, 60, 60, 45, 60, 60, 40, 60, 2, 60, 60, 60, 60, 60,
        60, 60, 60, 60, 60, 60, 60, 38, 60, 60, 60, 60, 60, 60, 60, 60,
        60, 60, 60, 60, 39, 60, 60, 60, 60, 40, 60, 60, 60, 37, 60, 60,
        60, 60, 2, 60, 60, 60, 60, 60, 60, 60, 60, 37, 60, 60, 60, 60,
        60, 60, 60, 60, 37, 60, 40, 60, 60, 34, 60, 60, 60, 60, 60, 60,
        60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 60, 39, 60, 60, 60
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "Tiles Layer Offset",
      visible = true,
      opacity = 1,
      offsetx = 20,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 482, 483, 484, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 489, 490, 491, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 496, 497, 498, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 503, 504, 505, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
      id = 3,
      name = "Tile Layer 3",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        82, 83, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 83, 84,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 94, 95
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 4,
      name = "door_closed",
      visible = true,
      opacity = 1,
      offsetx = 20,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 500, 501, 502, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 507, 508, 509, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 514, 515, 516, 0, 0, 0, 0, 0, 0, 0,
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
      id = 5,
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
          width = 640,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 240,
          width = 120,
          height = 240,
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
          y = 240,
          width = 120,
          height = 240,
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
          x = 120,
          y = 480,
          width = 400,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "fwood/graves",
            ["marker"] = "exit"
          }
        },
        {
          id = 6,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 200,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.door"
          }
        },
        {
          id = 7,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 400,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "binaribeans",
            ["name"] = "Binaribean"
          }
        },
        {
          id = 8,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 200,
          y = 320,
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
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
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
        }
      }
    }
  }
}
