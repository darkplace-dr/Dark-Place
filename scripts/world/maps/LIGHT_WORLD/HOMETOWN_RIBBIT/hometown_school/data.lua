return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 29,
  height = 16,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 15,
  nextobjectid = 117,
  properties = {
    ["border"] = "leaves",
    ["light"] = true,
    ["music"] = "town",
    ["name"] = "Bunker"
  },
  tilesets = {
    {
      name = "bunker",
      firstgid = 1,
      filename = "../../../../tilesets/bunker.tsx",
      exportfilename = "../../../../tilesets/bunker.lua"
    },
    {
      name = "castle",
      firstgid = 2,
      filename = "../../../../tilesets/castle.tsx",
      exportfilename = "../../../../tilesets/castle.lua"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 29,
      height = 16,
      id = 14,
      name = "tiles",
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "imagelayer",
      image = "../../../../../../assets/sprites/world/maps/hometown_ribbit/room_town_school.png",
      id = 11,
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
      id = 4,
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
          id = 105,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 480,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 106,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 0,
          width = 200,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 108,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 80,
          width = 120,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 109,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 80,
          width = 120,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 110,
          name = "",
          type = "",
          shape = "rectangle",
          x = 920,
          y = 0,
          width = 160,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 111,
          name = "",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 0,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 112,
          name = "",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 80,
          width = 160,
          height = 92.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 113,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1080,
          y = 0,
          width = 80,
          height = 640,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 114,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 560,
          width = 1080,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 115,
          name = "",
          type = "",
          shape = "polygon",
          x = 1080,
          y = 520,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -40, y = 40 },
            { x = 0, y = 40 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "objects_mirror",
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
      name = "objects_npcs",
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
      id = 7,
      name = "objects_misc",
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
          id = 104,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 40,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "LIGHT_WORLD/HOMETOWN_RIBBIT/hometown_south",
            ["marker"] = "entrysc"
          }
        },
        {
          id = 116,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 240,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "LIGHT_WORLD/HOMETOWN_RIBBIT/schoollobby",
            ["marker"] = "entryup"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
      name = "objects_scripts",
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
      id = 3,
      name = "objects_save",
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
      id = 2,
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
          id = 94,
          name = "entrydown",
          type = "",
          shape = "point",
          x = 760,
          y = 332,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 95,
          name = "entryleft",
          type = "",
          shape = "point",
          x = 80,
          y = 520,
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
      id = 10,
      name = "objects_party",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    }
  }
}
