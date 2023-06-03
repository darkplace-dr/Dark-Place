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
  nextlayerid = 8,
  nextobjectid = 32,
  properties = {
    ["border"] = "city",
    ["music"] = "cutawayofundertale",
    ["name"] = "Test City - Peetah's House"
  },
  tilesets = {},
  layers = {
    {
      type = "imagelayer",
      image = "../../../assets/sprites/world/maps/house.png",
      id = 5,
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
      type = "imagelayer",
      image = "../../../assets/sprites/world/npcs/peter.png",
      id = 7,
      name = "Image Layer 3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 71.3333,
      offsety = 15.3333,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "imagelayer",
      image = "../../../assets/sprites/world/npcs/lois.png",
      id = 6,
      name = "Image Layer 2",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 50.6667,
      offsety = 196,
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
          id = 14,
          name = "",
          type = "",
          shape = "polygon",
          x = 350,
          y = 225.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 230, y = 12 },
            { x = 232.5, y = -167 },
            { x = -153.5, y = -173.5 },
            { x = -171.5, y = -10 }
          },
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "polygon",
          x = 565.636,
          y = 232.545,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 26, y = 31.4545 },
            { x = 20.1818, y = -2 }
          },
          properties = {}
        },
        {
          id = 23,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 360,
          width = 40,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 480,
          width = 560,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 30,
          name = "",
          type = "",
          shape = "polygon",
          x = 124.667,
          y = 485.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 149.667, y = -212.333 },
            { x = 144.667, y = -260.333 },
            { x = -50, y = -6.33333 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "",
          type = "",
          shape = "polygon",
          x = 587,
          y = 258.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -4, y = 49.5 },
            { x = 55.5, y = 114.5 },
            { x = 55, y = 25.5 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
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
          id = 22,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 470,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "cybercity/alley2",
            ["marker"] = "entrydown"
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "polygon",
          x = 273,
          y = 234.5,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 66, y = 5 },
            { x = 78.5, y = -12.5 },
            { x = 74.5, y = -81.5 },
            { x = -55.5, y = -85.5 },
            { x = -48.5, y = -5 }
          },
          properties = {
            ["solid"] = true,
            ["text1"] = "It is a thing."
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "polygon",
          x = 380.5,
          y = 244,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 12.5, y = -1 },
            { x = 18.5, y = -13.5 },
            { x = 31.5, y = -12 },
            { x = 39, y = -5 },
            { x = 53, y = -4 },
            { x = 50, y = -18.5 },
            { x = 42, y = -17 },
            { x = 34, y = -32 },
            { x = -1, y = -31.5 }
          },
          properties = {
            ["solid"] = true,
            ["text1"] = "It is a wooden thing."
          }
        },
        {
          id = 27,
          name = "interactable",
          type = "",
          shape = "polygon",
          x = 81.3333,
          y = 480,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 190, y = -249.333 },
            { x = 195.333, y = -206.667 },
            { x = 50.6667, y = -0.666667 }
          },
          properties = {
            ["solid"] = true,
            ["text1"] = "- Hey Lois Family Guy, who's that little fella down there?",
            ["text2"] = "- PEEEEEEETAAAHH!!!!! IT'S THE DELTA RUNE CHARACTERS!"
          }
        },
        {
          id = 28,
          name = "interactable",
          type = "",
          shape = "polygon",
          x = 584.333,
          y = 252.333,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -4.66667, y = 56.6667 },
            { x = 64.3333, y = 133 },
            { x = 71.6667, y = 39.6667 }
          },
          properties = {
            ["solid"] = true,
            ["text1"] = "Television."
          }
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
          id = 5,
          name = "spawn",
          type = "",
          shape = "point",
          x = 400,
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
