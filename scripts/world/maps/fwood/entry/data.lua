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
  nextobjectid = 19,
  properties = {
    ["border"] = "deoxynn/deep_forest",
    ["music"] = "forgotten_wood",
    ["name"] = "F. Wood - Entrance"
  },
  tilesets = {
    {
      name = "forgotten_wood",
      firstgid = 1,
      filename = "../../../tilesets/forgotten_wood.tsx"
    },
    {
      name = "city_alleyway",
      firstgid = 430,
      filename = "../../../tilesets/city_alleyway.tsx",
      exportfilename = "../../../tilesets/city_alleyway.lua"
    },
    {
      name = "warp_bin",
      firstgid = 745,
      filename = "../../../tilesets/warp_bin.tsx",
      exportfilename = "../../../tilesets/warp_bin.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 2,
      name = "Tile Layer 2",
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
        0, 0, 0, 0, 0, 0, 0, 41, 56, 56, 56, 56, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 56, 56, 56, 56, 39, 56, 56, 56, 56,
        0, 56, 56, 56, 56, 56, 56, 56, 56, 40, 56, 56, 56, 56, 56, 56,
        0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 41, 56,
        0, 56, 56, 56, 56, 56, 47, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        0, 56, 56, 39, 56, 56, 56, 56, 56, 56, 56, 56, 39, 56, 56, 56,
        0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        0, 56, 56, 56, 56, 56, 56, 39, 56, 56, 56, 56, 56, 41, 56, 56,
        0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 47, 56, 56, 56, 56,
        0, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56, 56,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
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
        152, 151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 93, 94, 151, 152, 151,
        152, 151, 152, 151, 152, 151, 152, 95, 0, 0, 0, 104, 145, 146, 145, 151,
        152, 151, 145, 146, 145, 146, 105, 106, 0, 0, 0, 115, 156, 157, 156, 123,
        94, 122, 156, 157, 156, 157, 116, 306, 0, 0, 0, 0, 0, 0, 0, 93,
        94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
        94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
        94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
        94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
        94, 95, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 93,
        150, 242, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 135, 134, 124,
        161, 162, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 146, 145, 162,
        172, 173, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 157, 156, 173
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 12,
      id = 3,
      name = "Tile Layer 3",
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
        0, 0, 651, 652, 653, 0, 0, 216, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 745, 746, 747, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 320,
          height = 160,
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
          y = 160,
          width = 200,
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
          x = 0,
          y = 200,
          width = 80,
          height = 280,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 360,
          width = 560,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 0,
          width = 200,
          height = 120,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 120,
          width = 40,
          height = 240,
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
          id = 13,
          name = "savepoint",
          type = "",
          shape = "rectangle",
          x = 500,
          y = 220,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* The darkness of the forest shines within you."
          }
        },
        {
          id = 14,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 320,
          y = -40,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "tombsite.transition_1",
            ["once"] = false
          }
        },
        {
          id = 15,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 84,
          y = 110,
          width = 116,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "warp_bin",
            ["solid"] = true
          }
        },
        {
          id = 16,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 400,
          y = 320,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "binaribeans",
            ["name"] = "Binaribean"
          }
        },
        {
          id = 17,
          name = "beanspot",
          type = "",
          shape = "point",
          x = 240,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["inc_flag"] = "binaribeans",
            ["name"] = "Binaribean"
          }
        },
        {
          id = 18,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 120,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* DEVELOPER NOTE",
            ["text2"] = "* Forgotten Wood is planned to phase out into its own area in Frivatown's dark worlds.",
            ["text3"] = "* Please be quick,[wait:5] whatever you do.",
            ["text4"] = "* (Signed,[wait:5] AcousticJamm)"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
          name = "warp",
          type = "",
          shape = "point",
          x = 140,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "exit",
          type = "",
          shape = "point",
          x = 380,
          y = 40,
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
          x = 460,
          y = 240,
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
