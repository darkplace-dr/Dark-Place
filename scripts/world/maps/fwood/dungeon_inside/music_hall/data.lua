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
  nextlayerid = 7,
  nextobjectid = 9,
  properties = {
    ["music"] = "jamm_dungeon"
  },
  tilesets = {
    {
      name = "jamm_dungeon",
      firstgid = 1,
      filename = "../../../../tilesets/jamm_dungeon.tsx"
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
        0, 0, 23, 23, 23, 31, 51, 51, 33, 51, 51, 51, 23, 23, 23, 23,
        0, 0, 22, 23, 23, 23, 51, 51, 51, 51, 34, 51, 23, 23, 30, 23,
        0, 0, 23, 23, 23, 24, 51, 51, 51, 51, 51, 51, 29, 23, 23, 23,
        0, 0, 23, 30, 23, 23, 51, 40, 51, 51, 51, 51, 23, 23, 23, 31,
        0, 0, 37, 37, 37, 38, 51, 51, 51, 51, 51, 51, 37, 36, 37, 37,
        0, 0, 42, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "imagelayer",
      image = "../../../../../../assets/sprites/world/npcs/king/sulking.png",
      id = 6,
      name = "Image Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 372,
      offsety = 80,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "Tile Layer 2",
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
        0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 10, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 10, 11, 10, 10, 10, 10, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 12, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 10, 10, 10, 10, 10, 10, 15, 16, 0, 0,
        0, 0, 0, 0, 0, 0, 19, 17, 17, 18, 17, 17, 0, 0, 0, 37,
        0, 0, 0, 51, 51, 33, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51,
        0, 0, 52, 51, 51, 51, 51, 51, 34, 51, 51, 51, 51, 33, 51, 51,
        0, 0, 52, 51, 43, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44,
        0, 0, 52, 40, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 52, 51, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 52, 51, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 52, 41, 50, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 80,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 320,
          width = 440,
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
          x = 80,
          y = 0,
          width = 560,
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
          id = 4,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 480,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/floor2_main",
            ["marker"] = "music"
          }
        },
        {
          id = 7,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 200,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/music_trial",
            ["marker"] = "entry"
          }
        },
        {
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 374,
          y = 160,
          width = 98,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "a_dungeon.king"
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
          id = 5,
          name = "entry",
          type = "",
          shape = "point",
          x = 140,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "trial",
          type = "",
          shape = "point",
          x = 600,
          y = 260,
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
