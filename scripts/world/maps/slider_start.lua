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
  nextlayerid = 6,
  nextobjectid = 11,
  properties = {
    ["music"] = "slider"
  },
  tilesets = {
    {
      name = "darktiles_ribbitmobdt",
      firstgid = 1,
      filename = "../tilesets/darktiles_ribbitmobdt.tsx",
      exportfilename = "../tilesets/darktiles_ribbitmobdt.lua"
    },
    {
      name = "city_alleyway",
      firstgid = 241,
      filename = "../tilesets/city_alleyway.tsx",
      exportfilename = "../tilesets/city_alleyway.lua"
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 0,
        0, 14, 15, 13, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 16, 0,
        0, 14, 15, 15, 15, 15, 15, 15, 13, 15, 15, 15, 15, 15, 16, 0,
        0, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 13, 15, 15, 16, 0,
        0, 14, 25, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 3,
        0, 14, 15, 15, 15, 15, 15, 15, 15, 25, 15, 15, 15, 15, 13, 27,
        0, 14, 15, 15, 15, 13, 15, 15, 15, 15, 15, 15, 15, 15, 16, 38,
        0, 26, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 28, 50,
        0, 38, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 39, 40, 50,
        0, 50, 51, 51, 5, 51, 51, 51, 51, 51, 5, 51, 51, 51, 29, 50,
        0, 41, 51, 51, 51, 17, 51, 51, 51, 51, 51, 51, 51, 51, 52, 50
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 3,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 462, 463, 464, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 477, 478, 479, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
          x = 600,
          y = 40,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 280,
          width = 40,
          height = 80,
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
          y = 40,
          width = 40,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 360,
          width = 640,
          height = 120,
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
          id = 7,
          name = "spawn",
          type = "",
          shape = "point",
          x = 160,
          y = 160,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "slider",
          type = "",
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
          x = 87,
          y = 30,
          width = 110,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text"] = "* It doesn't seem to be working."
          }
        },
        {
          id = 9,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 200,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "slider",
            ["marker"] = "entry"
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "point",
          x = 240,
          y = 40,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "slider.fonttest",
            ["once"] = false
          }
        }
      }
    }
  }
}
