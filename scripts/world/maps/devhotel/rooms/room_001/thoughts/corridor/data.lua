return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 25,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 10,
  properties = {
    ["border"] = "simple",
    ["music"] = "deltarune/wind_highplace"
  },
  tilesets = {
    {
      name = "thoughts",
      firstgid = 1,
      filename = "../../../../../../tilesets/thoughts.tsx",
      exportfilename = "../../../../../../tilesets/thoughts.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "objects_bg",
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
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 25,
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
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 4, 5, 5, 6, 0, 0, 0, 0, 0, 0
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
          x = 200,
          y = 0,
          width = 40,
          height = 1000,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 0,
          width = 40,
          height = 1000,
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
          id = 3,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 1000,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/rooms/room_001/thoughts/crossroads",
            ["marker"] = "north"
          }
        },
        {
          id = 4,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 240,
          y = -40,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/rooms/room_001/thoughts/final",
            ["marker"] = "entry"
          }
        },
        {
          id = 8,
          name = "script",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 640,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "thoughts.corridor",
            ["once"] = true
          }
        },
        {
          id = 9,
          name = "npc",
          class = "",
          shape = "point",
          x = 320,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "brenda_dreamscape",
            ["facing"] = "up",
            ["flagcheck"] = "!b_corridor"
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
          name = "south",
          class = "",
          shape = "point",
          x = 320,
          y = 960,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "spawn",
          class = "",
          shape = "point",
          x = 320,
          y = 760,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "north",
          class = "",
          shape = "point",
          x = 320,
          y = 40,
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
