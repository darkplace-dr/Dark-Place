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
  nextobjectid = 19,
  properties = {
    ["border"] = "castle",
    ["music"] = "jamm_dungeon"
  },
  tilesets = {
    {
      name = "jamm_dungeon",
      firstgid = 1,
      filename = "../../../../tilesets/jamm_dungeon.tsx"
    },
    {
      name = "Machines",
      firstgid = 106,
      filename = "../../../../tilesets/Machines.tsx",
      exportfilename = "../../../../tilesets/Machines.lua"
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
        0, 0, 22, 23, 29, 23, 23, 23, 23, 23, 23, 23, 23, 23, 0, 0,
        0, 0, 23, 23, 23, 23, 30, 23, 23, 23, 23, 23, 29, 23, 0, 0,
        0, 0, 23, 30, 23, 23, 23, 23, 23, 23, 23, 23, 23, 24, 23, 23,
        0, 0, 37, 37, 37, 37, 37, 36, 37, 37, 37, 37, 37, 38, 23, 30,
        0, 0, 48, 58, 58, 58, 58, 58, 58, 58, 58, 58, 58, 39, 22, 23,
        0, 0, 52, 25, 51, 41, 51, 40, 51, 51, 51, 51, 34, 50, 37, 37,
        0, 0, 52, 51, 51, 51, 51, 51, 51, 51, 51, 51, 51, 57, 58, 58,
        0, 0, 52, 51, 34, 51, 51, 51, 51, 51, 41, 51, 51, 51, 40, 51,
        0, 0, 52, 51, 51, 51, 51, 34, 51, 51, 51, 51, 51, 43, 44, 44,
        0, 0, 52, 40, 51, 51, 51, 51, 51, 34, 51, 51, 51, 50, 0, 0,
        0, 0, 35, 44, 44, 44, 44, 44, 44, 44, 44, 44, 44, 26, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 53, 54, 55, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 60, 61, 62, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 20, 21, 0, 67, 68, 69, 0, 0, 81, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 74, 75, 76, 0, 0, 81, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 81, 0,
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
      id = 5,
      name = "door_layer",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 71, 72, 73, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 78, 79, 80, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 85, 86, 87, 0, 0, 0, 0,
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
      id = 3,
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
          name = "door_collision",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 120,
          width = 120,
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
          x = 0,
          y = 0,
          width = 80,
          height = 480,
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
          y = 440,
          width = 480,
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
          x = 560,
          y = 360,
          width = 80,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 280,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 0,
          width = 80,
          height = 160,
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
          y = 80,
          width = 80,
          height = 160,
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
          id = 8,
          name = "prize",
          type = "",
          shape = "point",
          x = 420,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "entry",
          type = "",
          shape = "point",
          x = 600,
          y = 300,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "dess_dungeonkiller",
          type = "",
          shape = "point",
          x = 240,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "jamm_dungeonkiller",
          type = "",
          shape = "point",
          x = 160,
          y = 280,
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
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 190,
          width = 94,
          height = 134,
          rotation = 0,
          gid = 106,
          visible = true,
          properties = {
            ["flagcheck"] = "!acj_dungeonkiller_1"
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 150,
          width = 94,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "a_dungeon.game",
            ["flagcheck"] = "!acj_dungeonkiller_1",
            ["solid"] = "true"
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 120,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* My dearest Luthane,[wait:5] a warrior in the realm of games.",
            ["text2"] = "* You love developing,[wait:5] but you're also a gamer yourself.",
            ["text3"] = "* As such,[wait:5] here is your trial:",
            ["text4"] = "* Upon pressing this button,[wait:5] you will start playing Ball Jump level 1.",
            ["text5"] = "* Get 5000 points and beat the level,[wait:5] and you win."
          }
        },
        {
          id = 13,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 118,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/game_win",
            ["marker"] = "entry"
          }
        },
        {
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 240,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["facing"] = "down",
            ["map"] = "fwood/dungeon_inside/game_hall",
            ["marker"] = "trial"
          }
        }
      }
    }
  }
}
