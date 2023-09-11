return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 20,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 42,
  properties = {
    ["music"] = "greenroom_outside",
    ["name"] = "Dev Diner - Exterior"
  },
  tilesets = {
    {
      name = "devroom-objects",
      firstgid = 1,
      filename = "../../tilesets/devroom-objects.tsx",
      exportfilename = "../../tilesets/devroom-objects.lua"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/world/maps/devroom/exterior/layout.png",
      id = 2,
      name = "bg",
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
          width = 40,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 920,
          y = 0,
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
          x = 200,
          y = 600,
          width = 120,
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
          x = 640,
          y = 600,
          width = 120,
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
          x = 400,
          y = 680,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 680,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          class = "",
          shape = "polygon",
          x = 320,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 120, y = 40 },
            { x = 120, y = 80 },
            { x = 0, y = 80 }
          },
          properties = {}
        },
        {
          id = 11,
          name = "",
          class = "",
          shape = "polygon",
          x = 520,
          y = 680,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 120, y = 0 },
            { x = 120, y = -80 },
            { x = 0, y = -40 }
          },
          properties = {}
        },
        {
          id = 13,
          name = "",
          class = "",
          shape = "polygon",
          x = 760,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 160, y = 0 },
            { x = 160, y = -160 }
          },
          properties = {}
        },
        {
          id = 14,
          name = "",
          class = "",
          shape = "polygon",
          x = 40,
          y = 440,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 160, y = 160 },
            { x = 0, y = 160 }
          },
          properties = {}
        },
        {
          id = 24,
          name = "",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 280,
          width = 480,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 120,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "",
          class = "",
          shape = "rectangle",
          x = 720,
          y = 0,
          width = 120,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          class = "",
          shape = "rectangle",
          x = 242,
          y = 572,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          class = "",
          shape = "rectangle",
          x = 681,
          y = 564,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          class = "",
          shape = "rectangle",
          x = 52,
          y = 422,
          width = 40,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          class = "",
          shape = "rectangle",
          x = 870,
          y = 422,
          width = 40,
          height = 20,
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
          id = 20,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 40,
          y = -32,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/dumpster",
            ["marker"] = "entry"
          }
        },
        {
          id = 21,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 792,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "",
            ["marker"] = "entry"
          }
        },
        {
          id = 23,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 362,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devhotel_lobby",
            ["marker"] = "south"
          }
        },
        {
          id = 27,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 440,
          y = 720,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 28,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 480,
          y = 720,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 29,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 40,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 30,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 80,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 31,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 840,
          y = -32,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["marker"] = "entry_bor",
            ["shop"] = "borshop"
          }
        },
        {
          id = 32,
          name = "",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 590,
          width = 108,
          height = 180,
          rotation = 0,
          gid = 51,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          class = "",
          shape = "rectangle",
          x = 615,
          y = 590,
          width = 108,
          height = 180,
          rotation = 0,
          gid = 2147483699,
          visible = true,
          properties = {}
        },
        {
          id = 34,
          name = "",
          class = "",
          shape = "rectangle",
          x = 50,
          y = 440,
          width = 108,
          height = 180,
          rotation = 0,
          gid = 51,
          visible = true,
          properties = {}
        },
        {
          id = 35,
          name = "",
          class = "",
          shape = "rectangle",
          x = 804,
          y = 440,
          width = 108,
          height = 180,
          rotation = 0,
          gid = 2147483699,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 840,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
          }
        },
        {
          id = 41,
          name = "dogconegroup",
          class = "",
          shape = "rectangle",
          x = 880,
          y = 80,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["default_state"] = true
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
          id = 15,
          name = "spawn",
          class = "",
          shape = "point",
          x = 480,
          y = 560,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "entry_diner",
          class = "",
          shape = "point",
          x = 480,
          y = 460,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "entry_alley",
          class = "",
          shape = "point",
          x = 80,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "entry_bor",
          class = "",
          shape = "point",
          x = 880,
          y = 80,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "entry",
          class = "",
          shape = "point",
          x = 480,
          y = 760,
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
