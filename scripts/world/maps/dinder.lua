return {
  version = "1.9",
  luaversion = "5.1",
  tiledversion = "1.9.0",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 20,
  height = 20,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 6,
  nextobjectid = 26,
  properties = {
    ["border"] = "glow",
    ["music"] = "deltarune/dogcheck"
  },
  tilesets = {
    {
      name = "devroom-objects",
      firstgid = 1,
      filename = "../tilesets/devroom-objects.tsx",
      exportfilename = "../tilesets/devroom-objects.lua"
    },
    {
      name = "city_alleyway",
      firstgid = 47,
      filename = "../tilesets/city_alleyway.tsx",
      exportfilename = "../tilesets/city_alleyway.lua"
    }
  },
  layers = {
    {
      type = "imagelayer",
      image = "../../../assets/sprites/world/maps/dinder.jpg",
      id = 2,
      name = "dinder",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 25,
      offsety = 22.5,
      parallaxx = 1,
      parallaxy = 1,
      repeatx = false,
      repeaty = false,
      properties = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 20,
      height = 20,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 268, 269, 270, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 283, 284, 285, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
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
          class = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 25,
          height = 800,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 777.504,
          width = 800,
          height = 22.4961,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          class = "",
          shape = "rectangle",
          x = 775,
          y = 0,
          width = 25,
          height = 800,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          class = "",
          shape = "rectangle",
          x = 0,
          y = 0,
          width = 800,
          height = 22.5,
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
          id = 5,
          name = "",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 400,
          width = 40,
          height = 40,
          rotation = 0,
          gid = 44,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["solid"] = true,
            ["text1"] = "* Heya,[wait:5] welcome to the Dinder room![wait:10] Aka,[wait:5] the half-baked WWC 1 year celebration room!",
            ["text10"] = "* Even during my toughest times.",
            ["text11"] = "* I know WWC is nowhere close to being finished...",
            ["text12"] = "* But I still would like to thank all of you.",
            ["text13"] = "* - BrandonK7200",
            ["text14"] = "* P.S:[wait:10] If you get a Maxim Tomato instead of a weapon/armor...",
            ["text15"] = "* It's because the item hasn't been made yet.",
            ["text16"] = "* Rest assured,[wait:5] they'll be added eventually.",
            ["text2"] = "* Here,[wait:5] you'll find several items that are planned for When Worlds Collide.",
            ["text3"] = "* Specifically,[wait:5] the weapons and armors given out by each section's secret boss.",
            ["text4"] = "* Along side a chest containing a butt ton of money,[wait:5] as a way of saying thanks.",
            ["text5"] = "* Thanks to everyone who is,[wait:5] has,[wait:5] and will help out with WWC.",
            ["text6"] = "* Without you guys,[wait:5] WWC could never get as far as I wanted it to.",
            ["text7"] = "* Thanks to the entire Kristal engine dev team.",
            ["text8"] = "* Without your hard work,[wait:5] WWC would most likely never have seen the light of day.",
            ["text9"] = "* Thanks to all of my friends who've helped me through a lot."
          }
        },
        {
          id = 7,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 320,
          y = 480,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 8,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 480,
          y = 480,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 9,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "originshield"
          }
        },
        {
          id = 10,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 280,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 11,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 520,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 17,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 160,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "aeonlance"
          }
        },
        {
          id = 19,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 600,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 20,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 560,
          y = 560,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 21,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 240,
          y = 560,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 22,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 200,
          y = 360,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["item"] = "maximtomato"
          }
        },
        {
          id = 23,
          name = "chest",
          class = "",
          shape = "rectangle",
          x = 400,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["money"] = "9999"
          }
        },
        {
          id = 25,
          name = "interactable",
          class = "",
          shape = "rectangle",
          x = 364,
          y = 600,
          width = 116,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamroom.warpbin",
            ["solid"] = true
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
          id = 24,
          name = "spawn",
          class = "",
          shape = "point",
          x = 420,
          y = 560,
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
