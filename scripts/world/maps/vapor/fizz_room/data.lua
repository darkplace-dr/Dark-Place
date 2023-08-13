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
  nextlayerid = 7,
  nextobjectid = 15,
  properties = {
    ["border"] = "vaporwave",
    ["music"] = "forest"
  },
  tilesets = {
    {
      name = "vapor",
      firstgid = 1,
      filename = "../../../tilesets/vapor.tsx",
      exportfilename = "../../../tilesets/vapor.lua"
    },
    {
      name = "devroom-objects",
      firstgid = 36,
      filename = "../../../tilesets/devroom-objects.tsx",
      exportfilename = "../../../tilesets/devroom-objects.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
      type = "imagelayer",
      image = "../../../../../assets/sprites/world/maps/vapor/background/mountains.png",
      id = 2,
      name = "mountains",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 105,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 1, 1, 1, 2, 3, 3, 6, 7, 5, 3, 3, 4, 0, 0,
        0, 0, 1, 1, 2, 3, 3, 6, 7, 5, 3, 3, 4, 1, 0, 0,
        0, 0, 1, 2, 3, 3, 6, 7, 5, 3, 3, 4, 1, 1, 1, 1,
        0, 0, 2, 3, 3, 6, 7, 5, 3, 3, 4, 1, 1, 1, 1, 1,
        0, 0, 3, 3, 6, 7, 5, 3, 3, 4, 1, 1, 1, 1, 8, 8,
        0, 0, 3, 6, 7, 5, 3, 3, 4, 1, 1, 1, 1, 1, 0, 0,
        0, 0, 9, 10, 10, 9, 9, 9, 8, 8, 8, 8, 8, 8, 0, 0,
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 120,
          width = 80,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 560,
          y = 280,
          width = 80,
          height = 80,
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
          y = 80,
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
          x = 40,
          y = 120,
          width = 40,
          height = 240,
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
          y = 360,
          width = 480,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 110.76,
          y = 120,
          width = 38.2396,
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
          x = 491,
          y = 120,
          width = 38.2396,
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
          id = 7,
          name = "fizz_entry",
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
          id = 8,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 200,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "vapor/bb_shop",
            ["marker"] = "entry2"
          }
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 160,
          width = 134,
          height = 128,
          rotation = 0,
          gid = 47,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 426,
          y = 160,
          width = 134,
          height = 128,
          rotation = 0,
          gid = 2147483695,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "npc",
          type = "",
          shape = "point",
          x = 320,
          y = 180,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "addisonsoda",
            ["cutscene"] = "vapor.addisonsoda"
          }
        }
      }
    }
  }
}
