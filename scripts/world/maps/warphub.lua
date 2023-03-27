return {
<<<<<<< Updated upstream
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
=======
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
>>>>>>> Stashed changes
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 23,
  height = 24,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 69,
  properties = {
    ["name"] = "Warp Hub"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../tilesets/castle.tsx",
<<<<<<< Updated upstream
      tilewidth = 40,
      tileheight = 40,
      spacing = 4,
      margin = 2,
      columns = 6,
      image = "../../../assets/sprites/tilesets/castle.png",
      imagewidth = 264,
      imageheight = 444,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 40,
        height = 40
      },
      properties = {},
      terrains = {},
      tilecount = 60,
      tiles = {}
    },
    {
      name = "city_alleyway",
      firstgid = 61,
      filename = "../../../../Github-Lmao/Dark-Place/scripts/world/tilesets/city_alleyway.tsx",
      tilewidth = 40,
      tileheight = 40,
      spacing = 0,
      margin = 0,
      columns = 15,
      image = "../../../../Github-Lmao/Dark-Place/assets/sprites/tilesets/bg_dw_city_alleyway.png",
      imagewidth = 600,
      imageheight = 840,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 40,
        height = 40
      },
      properties = {},
      terrains = {},
      tilecount = 315,
      tiles = {}
    },
    {
      name = "whitespace",
      firstgid = 376,
      filename = "../tilesets/whitespace.tsx",
      tilewidth = 40,
      tileheight = 40,
      spacing = 0,
      margin = 0,
      columns = 3,
      image = "../../../assets/sprites/tilesets/whitespace.png",
      imagewidth = 120,
      imageheight = 120,
      objectalignment = "unspecified",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 40,
        height = 40
      },
      properties = {},
      terrains = {},
      tilecount = 9,
      tiles = {}
=======
      exportfilename = "../tilesets/castle.lua"
    },
    {
      name = "whitespace",
      firstgid = 61,
      filename = "../tilesets/whitespace.tsx"
    },
    {
      name = "city_alleyway",
      firstgid = 70,
      filename = "../tilesets/city_alleyway.tsx"
>>>>>>> Stashed changes
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 23,
      height = 24,
      id = 1,
      name = "tiles",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
      properties = {},
      encoding = "lua",
      data = {
        380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 376, 377, 377, 377, 377, 377, 377, 377, 377, 377, 377, 377, 378, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 379, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 381, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 379, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 381, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 379, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 381, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 379, 380, 380, 380, 380, 382, 383, 384, 380, 380, 380, 380, 381, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 379, 380, 380, 380, 380, 379, 380, 381, 380, 380, 380, 380, 381, 380, 380, 380, 380, 380,
        380, 376, 377, 377, 377, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 377, 377, 377, 378, 380,
        380, 379, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 381, 380,
        380, 379, 380, 380, 380, 380, 380, 380, 380, 376, 377, 377, 377, 378, 380, 380, 380, 380, 380, 380, 380, 381, 380,
        380, 379, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 381, 380,
        380, 377, 377, 377, 378, 380, 380, 380, 380, 379, 380, 380, 380, 381, 380, 380, 380, 380, 376, 377, 377, 377, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 382, 383, 383, 383, 384, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 381, 383, 383, 383, 383, 383, 383, 383, 383, 383, 383, 383, 383, 383, 379, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380,
        380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380, 380
=======
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 61, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 62, 63, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 64, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 66, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 64, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 66, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 64, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 66, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 64, 65, 65, 65, 65, 67, 68, 69, 65, 65, 65, 65, 66, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 64, 65, 65, 65, 65, 64, 65, 66, 65, 65, 65, 65, 66, 65, 65, 65, 65, 65,
        65, 61, 62, 62, 62, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 62, 62, 62, 63, 65,
        65, 64, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 66, 65,
        65, 64, 65, 65, 65, 65, 65, 65, 65, 61, 62, 62, 62, 63, 65, 65, 65, 65, 65, 65, 65, 66, 65,
        65, 64, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 66, 65,
        65, 62, 62, 62, 63, 65, 65, 65, 65, 64, 65, 65, 65, 66, 65, 65, 65, 65, 61, 62, 62, 62, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 67, 68, 68, 68, 69, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 66, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 68, 64, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65
>>>>>>> Stashed changes
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 23,
      height = 24,
      id = 2,
      name = "decal",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
=======
      parallaxx = 1,
      parallaxy = 1,
>>>>>>> Stashed changes
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 43, 44, 45, 43, 44, 45, 0, 43, 44, 45, 43, 44, 45, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 49, 50, 51, 49, 50, 51, 0, 49, 50, 51, 49, 50, 51, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 55, 56, 57, 55, 56, 57, 0, 55, 56, 57, 55, 56, 57, 0, 0, 0, 0, 0,
<<<<<<< Updated upstream
        0, 0, 0, 0, 0, 289, 289, 289, 289, 289, 289, 0, 289, 289, 289, 289, 289, 289, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 44, 45, 0,
        0, 49, 50, 51, 0, 0, 0, 0, 0, 0, 285, 300, 106, 0, 0, 0, 0, 0, 0, 49, 50, 51, 0,
        0, 55, 56, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 56, 57, 0,
        0, 289, 289, 289, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 289, 289, 289, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 282, 283, 284, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 297, 298, 299, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
=======
        0, 0, 0, 0, 0, 298, 298, 298, 298, 298, 298, 0, 298, 298, 298, 298, 298, 298, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 43, 44, 45, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 43, 44, 45, 0,
        0, 49, 50, 51, 0, 0, 0, 0, 0, 0, 294, 309, 115, 0, 0, 0, 0, 0, 0, 49, 50, 51, 0,
        0, 55, 56, 57, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 55, 56, 57, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 298, 298, 298, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 291, 292, 293, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 306, 307, 308, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>>> Stashed changes
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 3,
      name = "collision",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
=======
      parallaxx = 1,
      parallaxy = 1,
>>>>>>> Stashed changes
      properties = {},
      objects = {
        {
          id = 57,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 200,
          y = 120,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 58,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 480,
          y = 120,
          width = 240,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 760,
          y = 360,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
<<<<<<< Updated upstream
          id = 60,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 360,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 61,
          name = "",
          type = "",
=======
          id = 61,
          name = "",
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 40,
          y = 260,
          width = 120,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 200,
          y = 20,
          width = 240,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 480,
          y = 20,
          width = 240,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 760,
          y = 260,
          width = 120,
          height = 100,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 65,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 0,
          y = -40,
          width = 920,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 66,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 920,
          y = -40,
          width = 40,
          height = 1040,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 67,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = -40,
          y = -40,
          width = 40,
          height = 1040,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 0,
          y = 960,
          width = 920,
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
      name = "objects",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
=======
      parallaxx = 1,
      parallaxy = 1,
>>>>>>> Stashed changes
      properties = {},
      objects = {
        {
          id = 27,
          name = "savepoint",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 360,
          y = 560,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* Another time,[wait:5] another place...",
            ["text2"] = "* The power of tourism shines within you."
          }
        },
        {
          id = 43,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 410,
          y = 480,
          width = 110,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamroom.warpbin",
            ["solid"] = true
          }
        },
        {
          id = 45,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 390,
          y = 260,
          width = 140,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* There appears to be some advertisements for codes here.",
            ["text2"] = "* \"Go to code 'spamroom'! It's where all the big shots are!\"",
            ["text3"] = "* \"yo whaddup. go to 'desshere'.\"",
<<<<<<< Updated upstream
            ["text4"] = "* It looks like until someone posts another ad,[wait:10] that's all there is here."
=======
            ["text4"] = "* \"Want to fight boss you've prevously fought?[wait:10]\nGo to 'bossrush'!\"",
            ["text5"] = "* It looks like until someone posts another ad,[wait:10] that's all there is here."
>>>>>>> Stashed changes
          }
        },
        {
          id = 46,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 60,
          y = 320,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
<<<<<<< Updated upstream
            ["solid"] = true,
            ["text1"] = "* This room appears to be for rent.",
            ["text2"] = "* But,[wait:10] you don't know how to rent it."
=======
            ["cutscene"] = "warphub.spamgolor",
            ["solid"] = true
>>>>>>> Stashed changes
          }
        },
        {
          id = 52,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 220,
          y = 80,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* This room appears to be for rent.",
            ["text2"] = "* But,[wait:10] you don't know how to rent it."
          }
        },
        {
          id = 53,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 340,
          y = 80,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* This room appears to be for rent.",
            ["text2"] = "* But,[wait:10] you don't know how to rent it."
          }
        },
        {
          id = 54,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 500,
          y = 80,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* This room appears to be for rent.",
            ["text2"] = "* But,[wait:10] you don't know how to rent it."
          }
        },
        {
          id = 55,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 620,
          y = 80,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* This room appears to be for rent.",
            ["text2"] = "* But,[wait:10] you don't know how to rent it."
          }
        },
        {
          id = 56,
          name = "interactable",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "rectangle",
          x = 780,
          y = 320,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* This room appears to be for rent.",
            ["text2"] = "* But,[wait:10] you don't know how to rent it."
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "markers",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
=======
      parallaxx = 1,
      parallaxy = 1,
>>>>>>> Stashed changes
      properties = {},
      objects = {
        {
          id = 20,
          name = "spawn",
<<<<<<< Updated upstream
          type = "",
=======
          class = "",
>>>>>>> Stashed changes
          shape = "point",
          x = 460,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 23,
      height = 24,
      id = 7,
      name = "above",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
=======
      parallaxx = 1,
      parallaxy = 1,
>>>>>>> Stashed changes
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
<<<<<<< Updated upstream
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 376, 377, 378, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
=======
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 61, 62, 63, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>>> Stashed changes
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 23,
      height = 24,
      id = 8,
      name = "abovedecal",
<<<<<<< Updated upstream
=======
      class = "",
>>>>>>> Stashed changes
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
<<<<<<< Updated upstream
=======
      parallaxx = 1,
      parallaxy = 1,
>>>>>>> Stashed changes
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
<<<<<<< Updated upstream
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 270, 0, 91, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
=======
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 279, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>>>>>>> Stashed changes
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
