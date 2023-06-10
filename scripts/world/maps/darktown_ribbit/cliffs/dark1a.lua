return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 20,
  properties = {
    ["music"] = "jazzylandscape",
    ["use_footstep_sounds"] = "true"
  },
  tilesets = {
    {
      name = "darktiles_ribbitmobdt",
      firstgid = 1,
      filename = "../../../tilesets/darktiles_ribbitmobdt.tsx",
      exportfilename = "../../../tilesets/darktiles_ribbitmobdt.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          id = 16,
          name = "sprite",
          class = "",
          shape = "rectangle",
          x = 228,
          y = 80,
          width = 144,
          height = 82,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["texture"] = "world/maps/cliffs/bigposter2"
          }
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 1,
      name = "tiles",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 7, 120, 3, 3, 4, 0, 0, 0, 0, 0, 0,
        8, 8, 8, 8, 8, 20, 20, 12, 15, 15, 3, 3, 3, 119, 8, 8,
        20, 20, 20, 20, 20, 20, 20, 20, 12, 15, 15, 15, 11, 20, 20, 20,
        44, 44, 44, 44, 44, 31, 20, 12, 15, 28, 39, 39, 39, 83, 44, 44,
        56, 10, 10, 56, 56, 43, 31, 12, 28, 40, 51, 51, 47, 10, 10, 56,
        56, 56, 56, 56, 56, 55, 43, 84, 40, 52, 51, 47, 56, 56, 56, 56,
        56, 56, 56, 56, 56, 55, 55, 22, 52, 52, 51, 51, 47, 56, 56, 56,
        56, 56, 56, 56, 56, 55, 55, 56, 52, 52, 51, 51, 51, 47, 56, 56
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "decal",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 65, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 25, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        181, 181, 181, 181, 181, 0, 0, 0, 0, 0, 181, 181, 181, 181, 181, 181,
        169, 169, 169, 169, 169, 181, 0, 0, 0, 181, 169, 169, 169, 169, 169, 169,
        169, 169, 169, 169, 169, 169, 181, 181, 181, 169, 169, 169, 169, 169, 169, 169
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
          class = "",
          shape = "rectangle",
          x = 200,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 160,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 160,
          width = 240,
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
          x = 240,
          y = 120,
          width = 120,
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
          x = 0,
          y = 280,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 360,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 320,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 280,
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
          id = 13,
          name = "script",
          class = "",
          shape = "rectangle",
          x = 160,
          y = 160,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "ribbitmobdt.ponman_intro",
            ["once"] = false
          }
        },
        {
          id = 14,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -20,
          y = 200,
          width = 30,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "darktown_ribbit/cliffs/dark1",
            ["marker"] = "entry"
          }
        },
        {
          id = 17,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 228,
          y = 140,
          width = 160,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "ribbitmobdt.ponman_poster"
          }
        },
        {
          id = 19,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 630,
          y = 200,
          width = 30,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "darktown_ribbit/cliffs/dark2",
            ["marker"] = "entry"
          }
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
          id = 15,
          name = "entry",
          class = "",
          shape = "point",
          x = 40,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "entry2",
          class = "",
          shape = "point",
          x = 600,
          y = 240,
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
