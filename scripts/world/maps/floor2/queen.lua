return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 32,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 5,
  nextobjectid = 17,
  properties = {
    ["border"] = "castle",
    ["music"] = "deltarune/queen_car_radio"
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
      width = 32,
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
        143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143, 143,
        143, 143, 143, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 143, 143, 143, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
        143, 143, 143, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 143, 143, 143, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26,
        143, 143, 143, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 143, 143, 143, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
        143, 143, 143, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 143, 143, 143, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 143, 52,
        143, 143, 143, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 143, 143, 143, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 143, 143, 143,
        143, 143, 143, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 76, 76, 78, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 143, 143, 143,
        143, 143, 143, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 89, 89, 90, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 143, 143, 143,
        143, 143, 143, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 143, 143, 143, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 143, 143, 143,
        143, 143, 143, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 143, 143, 143, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117,
        143, 143, 143, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 143, 143, 143, 118, 119, 120, 143, 143, 143, 143, 143, 126, 127, 128, 129, 130,
        143, 143, 143, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 143, 143, 143, 131, 132, 143, 143, 143, 143, 143, 138, 139, 140, 141, 142, 143
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
          id = 1,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 400,
          width = 160,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 360,
          y = 400,
          width = 800,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 120,
          y = 40,
          width = 400,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          class = "",
          shape = "rectangle",
          x = 80,
          y = 120,
          width = 40,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 320,
          width = 240,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 40,
          width = 240,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          class = "",
          shape = "rectangle",
          x = 760,
          y = 40,
          width = 400,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          class = "",
          shape = "rectangle",
          x = 1160,
          y = 120,
          width = 40,
          height = 280,
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
          id = 12,
          name = "transition",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "floor2/doors_right",
            ["marker"] = "exit_queen"
          }
        },
        {
          id = 13,
          name = "npc",
          class = "",
          shape = "point",
          x = 326,
          y = 230,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "queen_speakers",
            ["cutscene"] = "floor2.queen_sip"
          }
        },
        {
          id = 15,
          name = "npc",
          class = "",
          shape = "point",
          x = 174,
          y = 389,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "rouxls",
            ["cond"] = "Game:getFlag(\"hasObtainedRouxls\") == false",
            ["cutscene"] = "floor2.rouxls",
            ["sprite"] = "lamp"
          }
        },
        {
          id = 16,
          name = "queen_arcade",
          class = "",
          shape = "rectangle",
          x = 920,
          y = 40,
          width = 80,
          height = 120,
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
          id = 10,
          name = "spawn",
          class = "",
          shape = "point",
          x = 320,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "entry",
          class = "",
          shape = "point",
          x = 320,
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
