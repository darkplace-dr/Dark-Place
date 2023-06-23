return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 19,
  height = 16,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 26,
  nextobjectid = 36,
  properties = {
    ["music"] = "deltarune/dogcheck"
  },
  tilesets = {
    {
      name = "devroom",
      firstgid = 1,
      filename = "../../../../tilesets/devroom.tsx",
      exportfilename = "../../../../tilesets/devroom.lua"
    },
    {
      name = "devhotelfurniture",
      firstgid = 73,
      filename = "../../../../tilesets/devhotelfurniture.tsx",
      exportfilename = "../../../../tilesets/devhotelfurniture.lua"
    },
    {
      name = "devroom-objects",
      firstgid = 161,
      filename = "../../../../tilesets/devroom-objects.tsx",
      exportfilename = "../../../../tilesets/devroom-objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 19,
      height = 16,
      id = 24,
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
        8, 8, 7, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 10, 11, 11, 11, 12, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 16, 17, 17, 17, 18, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 8, 8,
        8, 8, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 13, 14, 8, 8, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 8, 8,
        8, 8, 8, 9, 8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 9, 8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 19,
      height = 16,
      id = 25,
      name = "props",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 80, 81, 82, 83, 0, 80, 83, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 102, 103, 104, 105, 0, 102, 105, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 78, 79, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 73, 75, 76, 77, 0, 100, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 95, 97, 98, 99, 0, 122, 123, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 117, 119, 120, 121, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 117, 118, 119, 121, 0, 37, 38, 39, 39, 39, 39, 40, 41, 0, 0, 0,
        0, 0, 0, 117, 118, 119, 121, 0, 43, 44, 45, 45, 45, 45, 46, 47, 0, 0, 0,
        0, 0, 0, 139, 140, 141, 143, 0, 49, 50, 51, 51, 51, 51, 52, 53, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 49, 50, 51, 51, 51, 51, 52, 53, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 55, 56, 57, 57, 57, 57, 58, 59, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 61, 62, 63, 63, 63, 63, 64, 65, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 16,
      name = "collision",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      tintcolor = { 0, 32, 255 },
      properties = {},
      objects = {
        {
          id = 6,
          name = "",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 560,
          width = 360,
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
          x = 40,
          y = 0,
          width = 40,
          height = 560,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          class = "",
          shape = "rectangle",
          x = 680,
          y = 0,
          width = 40,
          height = 560,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          class = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 600,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 138.872,
          width = 80,
          height = 101.128,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 560,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          class = "",
          shape = "rectangle",
          x = 80,
          y = 560,
          width = 80,
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
      id = 6,
      name = "objects_props",
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
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 424.166,
          y = 240,
          width = 241.5,
          height = 72.4501,
          rotation = 0,
          gid = 184,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 17,
      name = "objects_props2",
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
          name = "",
          class = "",
          shape = "rectangle",
          x = 431.961,
          y = 182.216,
          width = 226.29,
          height = 57.0646,
          rotation = 0,
          gid = 206,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          class = "",
          shape = "rectangle",
          x = 117.058,
          y = 400,
          width = 165.884,
          height = 49.7652,
          rotation = 0,
          gid = 184,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 19,
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
          id = 19,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 424.166,
          y = 160,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* There are tiny plushie Addisons all lined up!",
            ["text2"] = "* Already to advertise in their small sizes!"
          }
        },
        {
          id = 23,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 625,
          width = 160,
          height = 24.8685,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devhotel1",
            ["marker"] = "door_002"
          }
        },
        {
          id = 30,
          name = "script",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 494.004,
          width = 160,
          height = 37.5286,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_002.entry"
          }
        },
        {
          id = 27,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 360,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* It's a dog bed!",
            ["text2"] = "* Made for a little corgi"
          }
        },
        {
          id = 28,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 160,
          width = 160,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* It's a bed!",
            ["text2"] = "* It looks too big for a mouse..."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 20,
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
          id = 24,
          name = "spawn",
          class = "",
          shape = "point",
          x = 200,
          y = 528.28,
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
