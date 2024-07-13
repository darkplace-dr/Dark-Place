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
  nextlayerid = 6,
  nextobjectid = 10,
  properties = {
    ["music"] = "deltarune/field_of_hopes"
  },
  tilesets = {
    {
      name = "bg_darkfield_tiles",
      firstgid = 1,
      filename = "../../../tilesets/bg_darkfield_tiles.tsx",
      exportfilename = "../../../tilesets/bg_darkfield_tiles.lua"
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 67, 68, 68, 68, 68, 68, 68, 68, 68, 69, 0, 0, 0,
        0, 0, 67, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 69, 0, 0,
        0, 0, 73, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 68, 68,
        0, 0, 73, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
        0, 0, 73, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52,
        0, 0, 73, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 80, 80,
        0, 0, 79, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 81, 0, 0,
        0, 0, 0, 79, 80, 80, 80, 80, 80, 80, 80, 80, 81, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          id = 3,
          name = "",
          type = "",
          shape = "polygon",
          x = 640,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -80, y = 0 },
            { x = -160, y = 80 },
            { x = -480, y = 80 },
            { x = -560, y = 0 },
            { x = -560, y = -160 },
            { x = -480, y = -240 },
            { x = -160, y = -240 },
            { x = -80, y = -160 },
            { x = 0, y = -160 },
            { x = 0, y = -320 },
            { x = -640, y = -320 },
            { x = -640, y = 160 },
            { x = 0, y = 160 }
          },
          properties = {}
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
          name = "spawn",
          type = "",
          shape = "point",
          x = 600,
          y = 240,
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
          id = 7,
          name = "dwexit",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flagcheck"] = "canReturnFromCardWorld",
            ["map"] = "deoxynn/frivatown_2",
            ["mapFacing"] = "down",
            ["mapX"] = "1176",
            ["mapY"] = "270",
            ["marker"] = "CardWorld"
          }
        },
        {
          id = 9,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 160,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cardworld/path_1",
            ["marker"] = "cs"
          }
        }
      }
    }
  }
}
