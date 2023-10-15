return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 13,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 20,
  properties = {
    ["music"] = "greenroom"
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../assets/sprites/world/maps/devroom/starbeans.png",
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
          type = "",
          shape = "rectangle",
          x = 0,
          y = 480,
          width = 448,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 544,
          y = 480,
          width = 416,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 848,
          y = 0,
          width = 112,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 800,
          y = 288,
          width = 48,
          height = 64,
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
          y = 0,
          width = 106,
          height = 224,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 706,
          y = 0,
          width = 142,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 112,
          height = 480,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 112,
          y = 224,
          width = 48,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 320,
          height = 208,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "polygon",
          x = 383.984,
          y = 208,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 0, y = 34 },
            { x = 62, y = 96 },
            { x = 162, y = 96 },
            { x = 224, y = 34 },
            { x = 224, y = 15 },
            { x = 0, y = -1 }
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
          id = 11,
          name = "entry",
          type = "",
          shape = "point",
          x = 498,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "spawn",
          type = "",
          shape = "point",
          x = 498,
          y = 360,
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
          id = 16,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 520,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devdiner/devroom",
            ["marker"] = "sb"
          }
        },
        {
          id = 17,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 446,
          y = 264,
          width = 100,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "devroom.starbeans"
          }
        },
        {
          id = 18,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 480,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "darkess_beans",
            ["name"] = "Darkess Bean"
          }
        }
      }
    }
  }
}
