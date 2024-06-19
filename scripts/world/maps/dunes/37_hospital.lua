return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 20,
  properties = {
    ["light"] = true,
    ["music"] = "undertale_yellow/the_wild_east_hospital",
    ["name"] = "Wild East - Hospital"
  },
  tilesets = {
    {
      name = "we_saloon",
      firstgid = 1,
      filename = "../../tilesets/wild_east_buildings_inside.tsx",
      exportfilename = "../../tilesets/wild_east_buildings_inside.lua"
    }
  },
  layers = {
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        16, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    },
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
      offsetx = -6,
      offsety = -6,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 18, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
          x = 34,
          y = 438,
          width = 538,
          height = 42,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 34,
          y = 166,
          width = 540,
          height = 42,
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
          y = 166,
          width = 34,
          height = 314,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 572,
          y = 354,
          width = 68,
          height = 126,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 574,
          y = 166,
          width = 66,
          height = 74,
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 6,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 574,
          y = 240,
          width = 66,
          height = 114,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "dunes/37",
            ["marker"] = "hospital"
          }
        },
        {
          id = 7,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 408,
          y = 208,
          width = 74,
          height = 82,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A nap sounds nice...[wait:5]\ntaken anywhere but here.)"
          }
        },
        {
          id = 8,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 198,
          y = 208,
          width = 74,
          height = 82,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A nap sounds nice...[wait:5]\ntaken anywhere but here.)"
          }
        },
        {
          id = 9,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 100,
          y = 208,
          width = 74,
          height = 82,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A nap sounds nice...[wait:5]\ntaken anywhere but here.)"
          }
        },
        {
          id = 10,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 100,
          y = 400,
          width = 74,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A nap sounds nice...[wait:5]\ntaken anywhere but here.)"
          }
        },
        {
          id = 11,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 198,
          y = 400,
          width = 74,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A nap sounds nice...[wait:5]\ntaken anywhere but here.)"
          }
        },
        {
          id = 12,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 408,
          y = 400,
          width = 74,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A nap sounds nice...[wait:5]\ntaken anywhere but here.)"
          }
        },
        {
          id = 13,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 282,
          y = 208,
          width = 116,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (Several odd smells seep\nfrom the dresser.)",
            ["text2"] = "* (You decide not to inspect\nit further.)"
          }
        },
        {
          id = 14,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 488,
          y = 208,
          width = 74,
          height = 28,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (A closet with some cleaning\nsupplies inside.)",
            ["text2"] = "* (They all look brand new.)"
          }
        },
        {
          id = 15,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 490,
          y = 400,
          width = 74,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (You don't know what you're\nlooking at,[wait:5] but it's probably\ndangerous.)"
          }
        },
        {
          id = 16,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 284,
          y = 422,
          width = 112,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* (The drawers are filled with\nclean...[wait:5]ish sheets and\npillowcases.)"
          }
        },
        {
          id = 19,
          name = "npc",
          type = "",
          shape = "point",
          x = 97,
          y = 330,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "wild_east_doc",
            ["cutscene"] = "wildeast_hospital.doc"
          }
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
          id = 17,
          name = "right",
          type = "",
          shape = "point",
          x = 534,
          y = 297,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "spawn",
          type = "",
          shape = "point",
          x = 340,
          y = 320,
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
      width = 16,
      height = 12,
      id = 6,
      name = "Tile Layer 3",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 20,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
