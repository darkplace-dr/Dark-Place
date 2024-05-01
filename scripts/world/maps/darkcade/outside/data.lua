return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 24,
  properties = {
    ["border"] = "dev",
    ["music"] = "castle_funk"
  },
  tilesets = {
    {
      name = "devroom-objects",
      firstgid = 1,
      filename = "../../../tilesets/devroom-objects.tsx",
      exportfilename = "../../../tilesets/devroom-objects.lua"
    },
    {
      name = "warp_bin",
      firstgid = 54,
      filename = "../../../tilesets/warp_bin.tsx",
      exportfilename = "../../../tilesets/warp_bin.tsx"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../assets/sprites/world/maps/darkcade/outside.png",
      id = 2,
      name = "Image Layer 1",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
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
          x = 0,
          y = 0,
          width = 328,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 392,
          y = 0,
          width = 248,
          height = 240,
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
          y = 240,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          class = "",
          shape = "rectangle",
          x = 600,
          y = 240,
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
          x = 40,
          y = 440,
          width = 560,
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
          x = 101,
          y = 237,
          width = 110,
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
          id = 8,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 101,
          y = 193,
          width = 110,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "warp_bin",
            ["solid"] = true
          }
        },
        {
          id = 13,
          name = "savepoint",
          class = "",
          shape = "rectangle",
          x = 500,
          y = 340,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* The power of video games and pizza shines within you."
          }
        },
        {
          id = 15,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 160,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "darkcade/floor1",
            ["marker"] = "entry"
          }
        },
        {
          id = 16,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 480,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "refund"
          }
        },
        {
          id = 17,
          name = "",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 43,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 200,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* This place SUCKS![wait:5] All of the games are totally rigged!",
            ["text2"] = "* I want a refund, dammit!"
          }
        },
        {
          id = 19,
          name = "",
          class = "",
          shape = "rectangle",
          x = 94,
          y = 282,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 54,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          class = "",
          shape = "rectangle",
          x = 174,
          y = 282,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 56,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          class = "",
          shape = "rectangle",
          x = 134,
          y = 282,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 55,
          visible = true,
          properties = {}
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
          id = 9,
          name = "spawn",
          class = "",
          shape = "point",
          x = 460,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "exit",
          class = "",
          shape = "point",
          x = 360,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "warp",
          class = "",
          shape = "point",
          x = 160,
          y = 320,
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
