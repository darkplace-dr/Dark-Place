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
  nextobjectid = 24,
  properties = {
    ["music"] = "weller"
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../../../../assets/sprites/world/maps/ship/captain_upper_half.png",
      id = 3,
      name = "upper_half",
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
      type = "imagelayer",
      image = "../../../../../../assets/sprites/world/maps/ship/captain_lower_half.png",
      id = 2,
      name = "lower_half",
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 640,
          height = 120,
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
          y = 120,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 40,
          height = 80,
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
          y = 440,
          width = 600,
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
          x = 600,
          y = 120,
          width = 40,
          height = 320,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 278,
          width = 256,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 298,
          width = 250,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 348,
          y = 278,
          width = 252,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 352,
          y = 298,
          width = 248,
          height = 20,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "polygon",
          x = 290,
          y = 317,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -0.0909091, y = 10.8182 },
            { x = -8, y = 42.8182 },
            { x = -15.8182, y = 43 },
            { x = -16.8182, y = -0.636364 }
          },
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 120,
          width = 36,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 76,
          y = 154,
          width = 36,
          height = 54,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 22,
          name = "",
          type = "",
          shape = "rectangle",
          x = 536,
          y = 120,
          width = 64,
          height = 160,
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
          id = 20,
          name = "deck",
          type = "",
          shape = "point",
          x = 80,
          y = 380,
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
      id = 6,
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
          id = 11,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 280,
          width = 80,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "marcyquest.captain_room",
            ["once"] = false
          }
        },
        {
          id = 18,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 120,
          width = 36,
          height = 34,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "marcyquest.journal"
          }
        },
        {
          id = 19,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 0,
          width = 114,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "marcyquest.map"
          }
        },
        {
          id = 21,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 360,
          width = 20,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "marcyquest/ship/deck",
            ["marker"] = "captain"
          }
        },
        {
          id = 23,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 536,
          y = 120,
          width = 80,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "marcyquest.captain_bed"
          }
        }
      }
    }
  }
}
