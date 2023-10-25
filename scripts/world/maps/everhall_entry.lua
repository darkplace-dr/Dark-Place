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
    ["border"] = "dev"
  },
  tilesets = {
    {
      name = "devroom",
      firstgid = 1,
      filename = "../tilesets/devroom.tsx",
      exportfilename = "../tilesets/devroom.lua"
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
        0, 0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        0, 0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        0, 0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
        0, 0, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        0, 0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2,
        0, 0, 0, 7, 8, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
        0, 0, 0, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
        0, 0, 0, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
        0, 0, 0, 23, 23, 28, 23, 23, 23, 23, 23, 23, 23, 23, 23, 23,
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
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 640,
          height = 160,
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
          y = 160,
          width = 120,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 240,
          width = 440,
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
          id = 4,
          name = "entry",
          type = "",
          shape = "point",
          x = 160,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "hall_exit",
          type = "",
          shape = "point",
          x = 600,
          y = 200,
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
          id = 7,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devdiner/devstart",
            ["marker"] = "hall"
          }
        },
        {
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* A memento to the age of old,[wait:5] one long forgotten.",
            ["text2"] = "* Every tick on the wall represents a decade I have been lost to the void.",
            ["text3"] = "* (Before attempting this,[wait:5] be sure you have a LOT of free time and save frequently!)",
            ["text4"] = "* (I'm serious,[wait:5] one room of this alone takes a while to complete.)"
          }
        },
        {
          id = 9,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 160,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "everhall.entry",
            ["once"] = false
          }
        },
        {
          id = 10,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 280,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        }
      }
    }
  }
}
