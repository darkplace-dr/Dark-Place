return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 18,
  height = 15,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 16,
  properties = {
    ["music"] = "greenroom"
  },
  tilesets = {
    {
      name = "devroom",
      firstgid = 1,
      filename = "../../../../../tilesets/devroom.tsx",
      exportfilename = "../../../../../tilesets/devroom.lua"
    },
    {
      name = "devhotelfurniture",
      firstgid = 73,
      filename = "../../../../../tilesets/devhotelfurniture.tsx",
      exportfilename = "../../../../../tilesets/devhotelfurniture.lua"
    },
    {
      name = "devroom-objects",
      firstgid = 161,
      filename = "../../../../../tilesets/devroom-objects.tsx",
      exportfilename = "../../../../../tilesets/devroom-objects.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 18,
      height = 15,
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
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 8,
        8, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 2,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 14,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8,
        8, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 18,
      height = 15,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 81, 83, 0, 0, 0, 0, 0, 0,
        0, 78, 79, 0, 0, 0, 0, 0, 0, 102, 103, 105, 0, 0, 0, 0, 0, 0,
        0, 100, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 122, 123, 73, 75, 76, 75, 76, 77, 37, 38, 40, 41, 0, 0, 0, 0, 0,
        0, 0, 0, 95, 97, 98, 97, 98, 99, 43, 44, 46, 47, 0, 0, 0, 0, 0,
        0, 0, 0, 117, 0, 0, 0, 0, 121, 55, 56, 58, 59, 0, 0, 0, 0, 0,
        0, 0, 0, 117, 0, 0, 0, 0, 121, 61, 62, 64, 65, 0, 0, 0, 0, 0,
        0, 0, 0, 139, 141, 141, 141, 141, 143, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          x = 40,
          y = 80,
          width = 640,
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
          x = 0,
          y = 120,
          width = 40,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 560,
          width = 640,
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
          x = 680,
          y = 320,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 680,
          y = 120,
          width = 40,
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
          id = 8,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 120,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_001.dresser",
            ["solid"] = true
          }
        },
        {
          id = 9,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 120,
          width = 240,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_001.bed",
            ["solid"] = true
          }
        },
        {
          id = 10,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 720,
          y = 240,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/rooms/room_001/entrance",
            ["marker"] = "west"
          }
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "rectangle",
          x = 600,
          y = 160,
          width = 80,
          height = 80,
          rotation = 0,
          gid = 210,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "npc",
          class = "",
          shape = "point",
          x = 440,
          y = 210,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "breadulous",
            ["cutscene"] = "devhotel_room_001.breadulous"
          }
        },
        {
          id = 13,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 618,
          y = 130,
          width = 44,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_001.foodbowl",
            ["solid"] = true
          }
        },
        {
          id = 14,
          name = "npc",
          class = "",
          shape = "rectangle",
          x = 80,
          y = 480,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "brenda_plush",
            ["cutscene"] = "plushies.brenda_plush",
            ["flagcheck"] = "!brenda_plush"
          }
        },
        {
          id = 15,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 80,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_001.window"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 4,
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
          id = 6,
          name = "entry",
          class = "",
          shape = "point",
          x = 680,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "spawn",
          class = "",
          shape = "point",
          x = 480,
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
