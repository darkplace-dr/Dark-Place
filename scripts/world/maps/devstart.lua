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
  nextobjectid = 19,
  properties = {
    ["music"] = "greenroom",
    ["name"] = "Dev Diner - Spawn Point"
  },
  tilesets = {
    {
      name = "city_alleyway",
      firstgid = 1,
      filename = "../tilesets/city_alleyway.tsx"
    },
    {
      name = "devroom",
      firstgid = 316,
      filename = "../tilesets/devroom.tsx"
    },
    {
      name = "objects",
      firstgid = 334,
      filename = "../tilesets/objects.tsx",
      exportfilename = "../tilesets/objects.lua"
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
        323, 323, 323, 322, 322, 323, 323, 323, 323, 323, 323, 323, 323, 322, 322, 323,
        323, 323, 323, 322, 322, 325, 327, 323, 323, 323, 325, 327, 323, 322, 322, 323,
        323, 323, 323, 322, 322, 331, 333, 323, 323, 323, 331, 333, 323, 322, 322, 323,
        323, 323, 323, 322, 319, 320, 320, 320, 320, 320, 320, 320, 320, 322, 322, 323,
        323, 323, 323, 319, 316, 317, 317, 317, 317, 317, 317, 317, 318, 319, 322, 323,
        323, 323, 323, 316, 323, 323, 323, 323, 323, 323, 323, 323, 323, 318, 319, 320,
        323, 323, 323, 322, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 317, 317,
        323, 323, 323, 322, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 329, 329,
        323, 323, 323, 328, 323, 323, 323, 323, 323, 323, 323, 323, 323, 330, 323, 323,
        323, 323, 323, 323, 328, 329, 329, 329, 329, 329, 329, 329, 330, 323, 323, 323,
        323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323,
        323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323, 323
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 3,
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
        0, 0, 0, 0, 0, 0, 0, 222, 223, 224, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 237, 238, 239, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 120,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 200,
          width = 40,
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
          x = 160,
          y = 400,
          width = 360,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 360,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 320,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 200,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 120,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 287,
          y = 155,
          width = 110,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 120,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 360,
          width = 40,
          height = 80,
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
          id = 10,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 240,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devroom",
            ["marker"] = "entry"
          }
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 286,
          y = 111,
          width = 110,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamroom.warpbin",
            ["solid"] = true
          }
        },
        {
          id = 18,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 280,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text2"] = "* The power of fine dining and breathing shines within you."
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
          id = 12,
          name = "spawn",
          type = "",
          shape = "point",
          x = 340,
          y = 235,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "entry",
          type = "",
          shape = "point",
          x = 600,
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
