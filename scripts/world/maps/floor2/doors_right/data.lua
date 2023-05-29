return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 48,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 26,
  properties = {
    ["border"] = "castle",
    ["music"] = "deltarune/castletown"
  },
  tilesets = {
    {
      name = "castle_1f",
      firstgid = 1,
      filename = "../../../tilesets/castle_1f.tsx",
      exportfilename = "../../../tilesets/castle_1f.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 48,
      height = 12,
      id = 1,
      name = "Tile Layer 1",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 88, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 89, 90, 0,
        0, 2, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 34, 54, 54, 54, 54, 54, 54, 22, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 34, 5, 0,
        0, 3, 54, 54, 54, 54, 54, 54, 22, 54, 6, 54, 54, 22, 54, 54, 54, 54, 54, 54, 54, 54, 6, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 5, 0,
        0, 3, 6, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 34, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 18, 0,
        0, 3, 38, 39, 54, 54, 54, 54, 54, 34, 54, 54, 54, 54, 54, 6, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 54, 5, 0,
        0, 19, 20, 36, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 36, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 36, 20, 21, 0,
        0, 70, 73, 73, 86, 82, 82, 87, 73, 73, 86, 82, 82, 87, 73, 73, 86, 82, 82, 87, 73, 73, 86, 82, 82, 87, 73, 73, 86, 82, 82, 87, 73, 73, 86, 82, 82, 87, 73, 73, 86, 82, 82, 87, 73, 73, 71, 0,
        0, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 50, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 52, 82, 82, 82, 82, 82, 82, 50, 82, 82, 82, 82, 82, 82, 82, 82, 82, 0,
        0, 82, 52, 82, 82, 82, 82, 82, 82, 82, 68, 82, 82, 82, 82, 82, 82, 82, 66, 82, 82, 82, 82, 82, 82, 68, 82, 82, 82, 82, 82, 82, 68, 82, 82, 82, 82, 82, 82, 82, 82, 82, 82, 66, 82, 82, 82, 0,
        0, 82, 82, 82, 85, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 83, 82, 68, 82, 0,
        0, 82, 82, 82, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 82, 82, 82, 0,
        0, 82, 82, 68, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 52, 82, 82, 0
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
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 240,
          width = 40,
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
          x = 160,
          y = 360,
          width = 1600,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 200,
          width = 160,
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
          x = 280,
          y = 200,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 200,
          width = 1320,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1880,
          y = 240,
          width = 40,
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
      id = 5,
      name = "objects_doors",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 24,
          name = "backroomsdoor",
          type = "",
          shape = "rectangle",
          x = 204,
          y = 144,
          width = 72,
          height = 94,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "queendoor",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 84,
          width = 160,
          height = 156,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "tickdoor",
          type = "",
          shape = "rectangle",
          x = 625,
          y = 64,
          width = 170,
          height = 174,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "patatedoor",
          type = "",
          shape = "rectangle",
          x = 882,
          y = 64,
          width = 160,
          height = 174,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "objects",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 14,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 480,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/lounge",
            ["marker"] = "entry_doorsright"
          }
        },
        {
          id = 15,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1760,
          y = 480,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/east_wing",
            ["marker"] = "entry_doorsright"
          }
        },
        {
          id = 20,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 400,
          y = 230,
          width = 160,
          height = 10,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/queen",
            ["marker"] = "entry"
          }
        },
        {
          id = 21,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 160,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* NOTE: [wait:5]This room was designed so people can add doors to different areas or rooms.",
            ["text2"] = "* Feel free to add any doors you want here! ^^[wait:5]\n- J.A.R.U."
          }
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
      properties = {},
      objects = {
        {
          id = 16,
          name = "entry",
          type = "",
          shape = "point",
          x = 100,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "spawn",
          type = "",
          shape = "point",
          x = 960,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "exit_queen",
          type = "",
          shape = "point",
          x = 480,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "entry2",
          type = "",
          shape = "point",
          x = 1820,
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
