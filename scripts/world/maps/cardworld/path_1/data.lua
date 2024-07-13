return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 16,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 8,
  properties = {
    ["music"] = "deltarune/field_of_hopes",
    ["name"] = "Field - Card Start"
  },
  tilesets = {
    {
      name = "bg_darkfield_tiles",
      firstgid = 1,
      filename = "../../../tilesets/bg_darkfield_tiles.tsx",
      exportfilename = "../../../tilesets/bg_darkfield_tiles.lua"
    },
    {
      name = "treetiles_new",
      firstgid = 193,
      filename = "../../../tilesets/bg_treetiles_new.tsx",
      exportfilename = "../../../tilesets/bg_treetiles_new.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 16,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 194, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 193, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 67, 68, 68, 69, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        68, 68, 68, 52, 52, 52, 52, 68, 68, 52, 52, 52, 52, 68, 68, 68, 68, 68, 68, 69, 0, 0, 0, 0,
        52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 75, 0, 0, 0, 0,
        52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 52, 75, 0, 194, 0, 0,
        80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 80, 81, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 2,
          name = "",
          type = "",
          shape = "polygon",
          x = 520,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 440, y = 0 },
            { x = 440, y = 640 },
            { x = -520, y = 640 },
            { x = -520, y = 560 },
            { x = 240, y = 560 },
            { x = 280, y = 520 },
            { x = 280, y = 440 },
            { x = 240, y = 400 },
            { x = 0, y = 400 }
          },
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "polygon",
          x = 0,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 360, y = 0 },
            { x = 360, y = 400 },
            { x = 280, y = 400 },
            { x = 240, y = 360 },
            { x = 160, y = 360 },
            { x = 120, y = 400 },
            { x = 0, y = 400 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
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
          id = 4,
          name = "spawn",
          type = "",
          shape = "point",
          x = 640,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "cs",
          type = "",
          shape = "point",
          x = 40,
          y = 480,
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
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 700,
          y = 460,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* You find yourselves lost in a familiar field...",
            ["text2"] = "* The power of new-yet-familiar paths shines within you."
          }
        },
        {
          id = 7,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 400,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cardworld/start",
            ["marker"] = "spawn"
          }
        }
      }
    }
  }
}
