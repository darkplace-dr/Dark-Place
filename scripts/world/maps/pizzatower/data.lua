return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 14,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 15,
  nextobjectid = 93,
  properties = {
    ["border"] = "simple",
    ["music"] = "mmm_yess_put_the_tree_on_my_pizza",
    ["name"] = "Gnome Forest...?"
  },
  tilesets = {
    {
      name = "objects",
      firstgid = 1,
      filename = "../../tilesets/objects.tsx",
      exportfilename = "../../tilesets/objects.lua"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/world/maps/pizzatower/main.png",
      id = 6,
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
          id = 17,
          name = "",
          class = "",
          shape = "polygon",
          x = -0.5,
          y = 236,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 123.591, y = 72 },
            { x = 120.5, y = 4 }
          },
          properties = {}
        },
        {
          id = 18,
          name = "",
          class = "",
          shape = "polygon",
          x = 123.078,
          y = 307.984,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 51.9219, y = 28.5156 },
            { x = 36.9219, y = -27.9844 },
            { x = -3.07813, y = -67.9844 }
          },
          properties = {}
        },
        {
          id = 19,
          name = "",
          class = "",
          shape = "polygon",
          x = 174.984,
          y = 336.453,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 85.3793, y = 40.0923 },
            { x = 65.0156, y = -16.4531 },
            { x = -14.9844, y = -56.4531 }
          },
          properties = {}
        },
        {
          id = 20,
          name = "",
          class = "",
          shape = "polygon",
          x = 0.125,
          y = 305.25,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 150.33, y = 91.5682 },
            { x = -0.125, y = 94.75 }
          },
          properties = {}
        },
        {
          id = 22,
          name = "",
          class = "",
          shape = "rectangle",
          x = 260.375,
          y = 296.521,
          width = 717.583,
          height = 73,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 23,
          name = "",
          class = "",
          shape = "rectangle",
          x = 260.545,
          y = 357.455,
          width = 47.4545,
          height = 19.8182,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          class = "",
          shape = "polygon",
          x = 307.978,
          y = 377.267,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 13.9111, y = -7.88889 },
            { x = -0.0222222, y = -7.77778 }
          },
          properties = {}
        },
        {
          id = 27,
          name = "",
          class = "",
          shape = "polygon",
          x = 738.182,
          y = 369.091,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 14.4848, y = 10.5758 },
            { x = 257.818, y = 40.9091 },
            { x = 253.818, y = -43.0909 },
            { x = 21.1515, y = -21.7576 }
          },
          properties = {}
        },
        {
          id = 28,
          name = "",
          class = "",
          shape = "polygon",
          x = 260,
          y = 376.375,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 9.4375, y = -4.3125 },
            { x = 4.3125, y = -28.6875 },
            { x = -9.875, y = -24.9375 }
          },
          properties = {}
        },
        {
          id = 31,
          name = "",
          class = "",
          shape = "rectangle",
          x = -36.6667,
          y = 550,
          width = 1036.67,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          class = "",
          shape = "rectangle",
          x = 960,
          y = 160,
          width = 40,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          class = "",
          shape = "polygon",
          x = 150.727,
          y = 397.273,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -26.7273, y = 7.06061 },
            { x = -110.061, y = 17.3939 },
            { x = -163.727, y = 18.0606 },
            { x = -157.061, y = -17.9394 },
            { x = -33.3939, y = -15.2727 }
          },
          properties = {}
        },
        {
          id = 37,
          name = "",
          class = "",
          shape = "rectangle",
          x = 858,
          y = 360,
          width = 142,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 41,
          name = "",
          class = "",
          shape = "rectangle",
          x = -40,
          y = 160,
          width = 53.3333,
          height = 440,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          class = "",
          shape = "rectangle",
          x = 388,
          y = 468.5,
          width = 66.5,
          height = 44.5,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          class = "",
          shape = "rectangle",
          x = 451.091,
          y = 495.091,
          width = 56.5455,
          height = 12,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 84,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 266,
          width = 104,
          height = 140,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 85,
          name = "",
          class = "",
          shape = "rectangle",
          x = 467.333,
          y = 231.333,
          width = 128.667,
          height = 164.667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          class = "",
          shape = "rectangle",
          x = 597.455,
          y = 281.5,
          width = 111.045,
          height = 120.864,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 13,
      name = "objects_npcs2",
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
          id = 71,
          name = "ralgay",
          class = "",
          shape = "rectangle",
          x = 457.833,
          y = 404.5,
          width = 147,
          height = 235,
          rotation = 0,
          gid = 17,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 12,
      name = "objects_npcs",
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
          id = 68,
          name = "susy",
          class = "",
          shape = "rectangle",
          x = 356.939,
          y = 411.333,
          width = 118,
          height = 138,
          rotation = 0,
          gid = 18,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "chris hansen",
          class = "",
          shape = "rectangle",
          x = 592.333,
          y = 407.333,
          width = 120,
          height = 103,
          rotation = 0,
          gid = 15,
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
          id = 9,
          name = "entrance",
          class = "",
          shape = "point",
          x = 146,
          y = 355.667,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "spawn",
          class = "",
          shape = "point",
          x = 146.333,
          y = 355.606,
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
      visible = false,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 34,
          name = "",
          class = "",
          shape = "rectangle",
          x = 382.167,
          y = 519.333,
          width = 125,
          height = 99,
          rotation = 0,
          gid = 16,
          visible = true,
          properties = {
            ["solid"] = true
          }
        },
        {
          id = 89,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = -40,
          y = 160,
          width = 103.667,
          height = 218.333,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "room1",
            ["marker"] = "entry2"
          }
        },
        {
          id = 90,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 359,
          y = 261,
          width = 106.5,
          height = 148,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "gosh dan it, hansen. where are we"
          }
        },
        {
          id = 91,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 467,
          y = 238.5,
          width = 129,
          height = 159.5,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "dubie"
          }
        },
        {
          id = 92,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 596.5,
          y = 276.5,
          width = 115,
          height = 127,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (Holy hell, it's Kris Deltarune!)"
          }
        }
      }
    },
    {
      type = "imagelayer",
      image = "../../../../assets/sprites/world/maps/pizzatower/parallax.png",
      id = 11,
      name = "trees",
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
    }
  }
}
