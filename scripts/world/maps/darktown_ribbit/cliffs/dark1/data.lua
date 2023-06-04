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
  nextlayerid = 8,
  nextobjectid = 17,
  properties = {
    ["music"] = "jazzylandscape"
  },
  tilesets = {
    {
      name = "darktiles_ribbitmobdt",
      firstgid = 1,
      filename = "../../../../tilesets/darktiles_ribbitmobdt.tsx",
      exportfilename = "../../../../tilesets/darktiles_ribbitmobdt.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 2,
          name = "sprite",
          class = "",
          shape = "rectangle",
          x = 156,
          y = 0,
          width = 325,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["scalex"] = 2,
            ["scaley"] = 2,
            ["texture"] = "world/maps/cliffs/bigposter1"
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
        0, 0, 0, 0, 2, 3, 3, 3, 119, 8, 8, 9, 0, 0, 0, 0,
        0, 0, 0, 0, 14, 15, 15, 15, 15, 15, 11, 20, 8, 8, 8, 8,
        0, 0, 0, 0, 14, 15, 15, 15, 15, 11, 20, 20, 20, 20, 20, 20,
        0, 0, 0, 0, 26, 15, 15, 15, 15, 15, 11, 33, 44, 44, 44, 44,
        0, 0, 0, 0, 38, 26, 27, 27, 27, 11, 21, 45, 56, 56, 22, 56,
        0, 0, 0, 0, 50, 38, 39, 39, 39, 83, 45, 34, 56, 56, 56, 56,
        0, 0, 0, 0, 50, 50, 51, 5, 47, 56, 57, 57, 56, 56, 56, 56,
        0, 0, 0, 0, 50, 50, 51, 51, 51, 47, 57, 57, 56, 56, 56, 56
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
        0, 0, 0, 0, 0, 65, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        181, 181, 181, 181, 0, 0, 0, 0, 0, 0, 0, 0, 181, 181, 181, 181,
        169, 169, 169, 169, 181, 0, 0, 0, 0, 0, 0, 181, 169, 169, 169, 169,
        169, 169, 169, 169, 169, 181, 181, 181, 181, 181, 181, 169, 169, 169, 169, 169
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
      name = "objects_decal",
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
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 290,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 70,
          visible = true,
          properties = {}
        }
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
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 160,
          y = 120,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          class = "",
          shape = "rectangle",
          x = 160,
          y = 320,
          width = 40,
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
          x = 120,
          y = 120,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 320,
          width = 40,
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
          x = 200,
          y = 360,
          width = 240,
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
          x = 480,
          y = 280,
          width = 160,
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
          x = 480,
          y = 160,
          width = 160,
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
          id = 11,
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
            ["map"] = "darktown_ribbit/cliffs/dark1a",
            ["marker"] = "entry"
          }
        },
        {
          id = 14,
          name = "darkpuddle",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 200,
          width = 240,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 160,
          y = 120,
          width = 320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "ribbitmobdt.darkposter"
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
          id = 12,
          name = "entry",
          class = "",
          shape = "point",
          x = 600,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "spawn",
          class = "",
          shape = "point",
          x = 320,
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
