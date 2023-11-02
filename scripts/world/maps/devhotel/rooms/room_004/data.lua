return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 11,
  nextobjectid = 16,
  properties = {
    ["music"] = "greenroom"
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
      name = "devroom_sam",
      firstgid = 161,
      class = "",
      tilewidth = 64,
      tileheight = 51,
      spacing = 0,
      margin = 0,
      columns = 0,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 1,
        height = 1
      },
      properties = {},
      wangsets = {},
      tilecount = 5,
      tiles = {
        {
          id = 0,
          image = "../../../../../../assets/sprites/world/events/devroom/devroom-hifi.png",
          width = 64,
          height = 28
        },
        {
          id = 1,
          image = "../../../../../../assets/sprites/world/events/devroom/devroom-portal_1.png",
          width = 22,
          height = 48,
          animation = {
            {
              tileid = 1,
              duration = 200
            },
            {
              tileid = 3,
              duration = 200
            },
            {
              tileid = 4,
              duration = 200
            }
          }
        },
        {
          id = 2,
          image = "../../../../../../assets/sprites/world/events/devroom/devroom-spherekeeper_1.png",
          width = 34,
          height = 51
        },
        {
          id = 3,
          image = "../../../../../../assets/sprites/world/events/devroom/devroom-portal_2.png",
          width = 22,
          height = 48
        },
        {
          id = 4,
          image = "../../../../../../assets/sprites/world/events/devroom/devroom-portal_3.png",
          width = 22,
          height = 48
        }
      }
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
      name = "room",
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
        0, 0, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 0,
        0, 0, 13, 8, 8, 14, 14, 14, 14, 14, 14, 14, 14, 14, 15, 0,
        0, 0, 0, 7, 9, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 3,
      name = "carpet",
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
        0, 0, 37, 38, 39, 40, 38, 39, 40, 38, 39, 38, 39, 40, 41, 0,
        0, 0, 43, 44, 45, 45, 45, 45, 45, 45, 45, 45, 45, 46, 47, 0,
        0, 0, 49, 50, 51, 51, 51, 51, 51, 51, 51, 51, 51, 52, 53, 0,
        0, 0, 55, 50, 51, 51, 51, 57, 57, 57, 57, 57, 57, 58, 59, 0,
        0, 0, 49, 50, 51, 51, 52, 53, 62, 63, 64, 62, 63, 64, 65, 0,
        0, 0, 55, 56, 57, 57, 58, 59, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 61, 62, 63, 64, 63, 65, 0, 0, 0, 0, 0, 0, 0, 0,
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
      id = 4,
      name = "carpet 2",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 37, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0,
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
      id = 2,
      name = "tiles_objects",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 80, 81, 82, 83, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 78, 79, 0, 102, 103, 104, 105, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 100, 101, 73, 75, 76, 75, 76, 77, 0,
        0, 0, 0, 0, 0, 0, 0, 122, 123, 95, 97, 98, 97, 98, 99, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 117, 119, 120, 119, 120, 121, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 139, 141, 142, 141, 142, 143, 0,
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
      id = 10,
      name = "objects_below",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 156,
          y = 152,
          width = 128,
          height = 56,
          rotation = 0,
          gid = 161,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 92,
          y = 144,
          width = 44,
          height = 96,
          rotation = 0,
          gid = 162,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "objects_others",
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
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 156.125,
          y = 120,
          width = 129.875,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_004.hifi",
            ["solid"] = true
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 286.125,
          y = 120,
          width = 73.875,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["cutscene"] =  "devhotel_room_004.light"
          }
        },
        {
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 80,
          width = 240,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A king-size bed for two people.)",
            ["text2"] = "* (Useful when you have a romantic partner or friends to spend the night with.)",
            ["text3"] = "* (It's out of place.)"
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 93.5,
          y = 119.875,
          width = 40.625,
          height = 24.25,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_004.book",
            ["solid"] = true
          }
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 513.75,
          y = 400.125,
          width = 68.375,
          height = 33.75,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devhotel_room_004.sphere",
            ["solid"] = true
          }
        },
        {
          id = 15,
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
            ["map"] = "devhotel/devhotel1",
            ["marker"] = "door_004"
          }
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 514,
          y = 434,
          width = 68,
          height = 102,
          rotation = 0,
          gid = 163,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../../../../assets/sprites/world/maps/room004_ghost.png",
      id = 9,
      name = "ghost",
      class = "",
      visible = true,
      opacity = 0,
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
      id = 6,
      name = "collisions",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {
        ["solid"] = true
      },
      objects = {
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 440,
          width = 400,
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
          x = 40,
          y = 440,
          width = 80,
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
          x = 40,
          y = 0,
          width = 40,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 80,
          width = 280,
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
          x = 600,
          y = 0,
          width = 40,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 7,
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
          id = 13,
          name = "spawn",
          type = "",
          shape = "point",
          x = 160,
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
