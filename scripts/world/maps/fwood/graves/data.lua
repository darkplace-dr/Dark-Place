return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.6",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 16,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 18,
  properties = {
    ["border"] = "deoxynn/deep_forest",
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
      width = 20,
      height = 16,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 39, 56, 56, 0,
        0, 0, 56, 56, 41, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 47, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 41, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 47, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 39, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 41, 56, 56, 56, 56, 56, 56, 56, 56, 47, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 56, 56, 56, 56, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 56, 56, 56, 56, 56, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 16,
      id = 2,
      name = "Tile Layer 2",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        93, 94, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152,
        93, 94, 151, 161, 162, 161, 162, 161, 162, 161, 162, 161, 162, 161, 162, 161, 162, 161, 151, 152,
        93, 94, 122, 172, 173, 172, 173, 172, 173, 172, 173, 172, 173, 172, 173, 172, 173, 172, 123, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 287, 289, 0, 0, 0, 287, 289, 0, 0, 0, 93, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 298, 300, 0, 0, 0, 298, 300, 0, 0, 0, 93, 152,
        93, 94, 95, 0, 0, 287, 289, 0, 309, 311, 0, 0, 0, 309, 311, 0, 0, 0, 93, 152,
        93, 94, 95, 0, 0, 298, 300, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 152,
        93, 94, 95, 0, 0, 309, 311, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 287, 289, 93, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 287, 289, 0, 0, 0, 0, 0, 298, 300, 93, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 298, 300, 0, 0, 0, 0, 0, 309, 311, 93, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 309, 311, 0, 0, 0, 0, 0, 0, 0, 93, 152,
        93, 94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93, 152,
        93, 94, 242, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 137, 0, 0, 0, 93, 152,
        93, 94, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 93, 152,
        93, 94, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 93, 152
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 16,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 399, 400, 0, 0, 0, 397, 398, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 410, 411, 0, 0, 0, 408, 409, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 397, 398, 0, 421, 422, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 408, 409, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 397, 398, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 397, 398, 0, 0, 0, 0, 0, 408, 409, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 408, 409, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          width = 800,
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
          x = 720,
          y = 120,
          width = 80,
          height = 520,
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
          y = 520,
          width = 600,
          height = 120,
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
          y = 120,
          width = 120,
          height = 400,
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
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 210,
          y = 170,
          width = 58,
          height = 68,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.grave_1",
            ["solid"] = true
          }
        },
        {
          id = 7,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 330,
          y = 90,
          width = 58,
          height = 68,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.grave_2",
            ["solid"] = true
          }
        },
        {
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 370,
          y = 330,
          width = 58,
          height = 68,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.grave_3",
            ["solid"] = true
          }
        },
        {
          id = 9,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 530,
          y = 90,
          width = 58,
          height = 68,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.grave_4",
            ["solid"] = true
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 650,
          y = 290,
          width = 58,
          height = 68,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.grave_5",
            ["solid"] = true
          }
        },
        {
          id = 11,
          name = "npc",
          type = "",
          shape = "point",
          x = 360,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "fake_jamm",
            ["cond"] = "marcy_father and not fake_jamm",
            ["cutscene"] = "tombsite.fake_jamm",
            ["facing"] = "up"
          }
        },
        {
          id = 14,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 640,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.transition_2",
            ["once"] = false
          }
        },
        {
          id = 15,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 560,
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
          id = 16,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 200,
          y = 480,
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
          id = 17,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 440,
          y = 200,
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
      id = 6,
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
          id = 12,
          name = "entry",
          type = "",
          shape = "point",
          x = 660,
          y = 600,
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
