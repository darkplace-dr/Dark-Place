return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 18,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 21,
  properties = {
    ["music"] = "deltarune/field_of_hopes"
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
      width = 16,
      height = 18,
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
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        194, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 193, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 52, 68, 68, 68, 68, 69, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 52, 52, 52, 52, 52, 75, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 52, 52, 52, 52, 52, 75, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 52, 80, 80, 80, 80, 81, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        194, 0, 0, 0, 0, 0, 73, 52, 52, 75, 193, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 73, 52, 52, 75, 0, 0, 0, 0, 0, 0
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
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 240,
          height = 720,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "polygon",
          x = 400,
          y = 0,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 240, y = 0 },
            { x = 240, y = 720 },
            { x = 0, y = 720 },
            { x = 0, y = 400 },
            { x = 160, y = 400 },
            { x = 200, y = 360 },
            { x = 200, y = 280 },
            { x = 160, y = 240 },
            { x = 0, y = 240 }
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
          id = 8,
          name = "walkto_party",
          type = "",
          shape = "point",
          x = 320,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "path1",
          type = "",
          shape = "point",
          x = 320,
          y = 680,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "terry_walkto",
          type = "",
          shape = "point",
          x = 400,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 13,
          name = "jamm_walkto",
          type = "",
          shape = "point",
          x = 320,
          y = 120,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "terry_walkto_2",
          type = "",
          shape = "point",
          x = 320,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 16,
          name = "terry_walkto_3",
          type = "",
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
          name = "script",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 400,
          width = 160,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "cards.tutorial_terry_1"
          }
        },
        {
          id = 5,
          name = "npc",
          type = "",
          shape = "point",
          x = 320,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "jamm",
            ["facing"] = "up",
            ["flagcheck"] = "!tutorial_terry_1"
          }
        },
        {
          id = 6,
          name = "npc",
          type = "",
          shape = "point",
          x = 520,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "tutorial_terry",
            ["facing"] = "left",
            ["flagcheck"] = "!tutorial_terry_1"
          }
        },
        {
          id = 10,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 720,
          width = 160,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cardworld/path_1",
            ["marker"] = "path2"
          }
        }
      }
    }
  }
}
