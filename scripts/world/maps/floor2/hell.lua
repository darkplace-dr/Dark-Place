return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 30,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 349,
  properties = {
    ["music"] = "flandre"
  },
  tilesets = {
    {
      name = "queen_room",
      firstgid = 1,
      filename = "../../tilesets/queen_room.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 30,
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
        138, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 50, 138,
        138, 14, 15, 14, 15, 14, 15, 14, 15, 14, 15, 14, 15, 14, 23, 138,
        138, 27, 29, 30, 31, 32, 28, 29, 30, 31, 32, 33, 34, 35, 36, 138,
        138, 40, 41, 42, 43, 44, 45, 46, 47, 48, 47, 42, 43, 44, 45, 138,
        138, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 53, 54, 80, 47, 138,
        138, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 47, 47, 48, 62, 138,
        138, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 47, 47, 110, 58, 50,
        138, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 47, 47, 75, 47, 138,
        138, 106, 107, 108, 109, 79, 111, 112, 113, 53, 47, 47, 80, 47, 47, 138,
        138, 92, 93, 94, 95, 79, 97, 98, 99, 100, 101, 62, 62, 62, 62, 138,
        138, 40, 41, 42, 43, 44, 45, 46, 47, 48, 47, 42, 43, 44, 45, 138,
        138, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 53, 54, 80, 47, 138,
        138, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 47, 47, 48, 47, 138,
        138, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 47, 47, 110, 58, 138,
        138, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 47, 47, 62, 47, 138,
        138, 106, 107, 108, 109, 79, 111, 112, 113, 53, 79, 79, 80, 47, 47, 138,
        138, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 79, 47, 47, 47, 138,
        138, 40, 41, 42, 43, 44, 45, 46, 47, 48, 79, 42, 43, 44, 45, 138,
        138, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 53, 54, 80, 79, 138,
        138, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 47, 47, 48, 47, 138,
        138, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 79, 79, 110, 58, 138,
        138, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 79, 79, 80, 79, 138,
        138, 53, 54, 55, 56, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 138,
        138, 92, 93, 94, 95, 96, 49, 49, 49, 47, 49, 49, 49, 49, 49, 138,
        138, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 53, 54, 80, 79, 138,
        138, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 47, 47, 48, 93, 138,
        118, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 79, 79, 110, 58, 138,
        118, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 79, 79, 96, 79, 138,
        118, 105, 107, 108, 109, 110, 111, 112, 113, 53, 79, 79, 80, 79, 114, 138,
        118, 118, 118, 118, 138, 138, 138, 53, 57, 138, 138, 50, 138, 138, 138, 138
      }
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
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1,
          y = 2,
          width = 39,
          height = 1198,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 599,
          y = -2,
          width = 39,
          height = 1202,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 41,
          y = -1,
          width = 556,
          height = 41,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 41,
          y = 1158,
          width = 236.667,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 43,
          y = 38,
          width = 555,
          height = 43,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 346,
          name = "",
          type = "",
          shape = "rectangle",
          x = 362.333,
          y = 1157.67,
          width = 235.334,
          height = 42,
          rotation = 0,
          visible = true,
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
          id = 113,
          name = "spawn",
          type = "",
          shape = "point",
          x = 320,
          y = 1159.33,
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
          id = 208,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 301.369,
          y = 659.635,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 211,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 533.904,
          y = 880.783,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 213,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 154.967,
          y = 890.545,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 217,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 224.002,
          y = 660.826,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 218,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 257.329,
          y = 898.877,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 221,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 348.979,
          y = 798.895,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 225,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 307.32,
          y = 960.77,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 226,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 400.16,
          y = 951.248,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 227,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 476.336,
          y = 936.965,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 228,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 390.638,
          y = 851.267,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 232,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 458.482,
          y = 589.41,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 233,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 498.951,
          y = 791.754,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 234,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 394.209,
          y = 721.529,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 236,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 238.285,
          y = 820.32,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 237,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 160.919,
          y = 764.378,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 243,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 164.489,
          y = 596.552,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 244,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 467.56,
          y = 301.201,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 248,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 166.87,
          y = 432.297,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 257,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 269.232,
          y = 334.696,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 258,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 213.29,
          y = 381.116,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 259,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 257.329,
          y = 489.429,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 260,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 346.598,
          y = 481.097,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 263,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 248.998,
          y = 575.127,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 268,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 372.784,
          y = 383.496,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 269,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 443.009,
          y = 484.668,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 270,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 531.088,
          y = 587.03,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 271,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 539.42,
          y = 688.202,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 278,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 78.7911,
          y = 385.877,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 280,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 45.464,
          y = 601.313,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 284,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 74.0301,
          y = 478.717,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 286,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 165.901,
          y = 293.375,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 289,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 470.385,
          y = 200.197,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 292,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 460.863,
          y = 402.54,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 297,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 470.385,
          y = 99.0255,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 298,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 273.941,
          y = 169.119,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 299,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 348.008,
          y = 112.353,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 301,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 133.543,
          y = 93.0742,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 309,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 129.972,
          y = 200.197,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 313,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 56.1763,
          y = 827.461,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 315,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 50.1794,
          y = 916.731,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 318,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 46.6543,
          y = 726.29,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 327,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 540.61,
          y = 187.104,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 328,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 538.229,
          y = 366.833,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 329,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 539.42,
          y = 512.044,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 330,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 370.754,
          y = 249.187,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 337,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 39.5127,
          y = 446.58,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 340,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 41.8932,
          y = 284.705,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 341,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 41.8932,
          y = 89.5034,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 344,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 360.882,
          y = 601.313,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "bluehaunt",
            ["encounter"] = "bluehaunt"
          }
        },
        {
          id = 348,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 241.333,
          y = 1201,
          width = 160,
          height = 40.6667,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/doors_right",
            ["marker"] = "exit_justadoor"
          }
        }
      }
    }
  }
}
