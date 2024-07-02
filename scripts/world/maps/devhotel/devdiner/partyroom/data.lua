return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 24,
  height = 18,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 9,
  nextobjectid = 90,
  properties = {
    ["border"] = "dev",
    ["music"] = "greenroom"
  },
  tilesets = {
    {
      name = "devroom",
      firstgid = 1,
      filename = "../../../../tilesets/devroom.tsx",
      exportfilename = "../../../../tilesets/devroom.lua"
    },
    {
      name = "devroom-objects",
      firstgid = 73,
      filename = "../../../../tilesets/devroom-objects.tsx",
      exportfilename = "../../../../tilesets/devroom-objects.lua"
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 8,
      name = "objects_bg",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {}
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 24,
      height = 18,
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
        8, 8, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 8, 8,
        8, 8, 7, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 8, 8,
        8, 8, 7, 7, 8, 8, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 8, 8, 9, 9, 8, 8,
        8, 8, 7, 7, 8, 8, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 8, 8, 9, 9, 8, 8,
        8, 8, 7, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 6, 9, 8, 8,
        8, 8, 4, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 6, 8, 8,
        8, 8, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 3, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8,
        8, 8, 13, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 15, 8, 8,
        8, 8, 8, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 8, 8, 14, 14, 14, 15, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 9, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 9, 8, 8, 8, 8, 8, 8, 8
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
          type = "",
          shape = "rectangle",
          x = 80,
          y = 600,
          width = 40,
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
          x = 120,
          y = 640,
          width = 480,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 680,
          y = 640,
          width = 160,
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
          x = 840,
          y = 600,
          width = 40,
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
          x = 880,
          y = 240,
          width = 40,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 240,
          width = 40,
          height = 360,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 0,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 720,
          height = 200,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 840,
          y = 0,
          width = 40,
          height = 240,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 609,
          y = 360,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 274,
          y = 360,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 609,
          y = 460,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 274,
          y = 460,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 410,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 46,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 530,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 47,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 290,
          width = 100,
          height = 30,
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
          id = 22,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 600,
          y = 720,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devdiner/devroom",
            ["marker"] = "entry1"
          }
        },
        {
          id = 24,
          name = "wardrobe",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 220,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 25,
          name = "jukebox",
          type = "",
          shape = "rectangle",
          x = 720,
          y = 180,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 26,
          name = "npc",
          type = "",
          shape = "point",
          x = 460,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "char",
            ["cutscene"] = "devroom.charshop"
          }
        },
        {
          id = 28,
          name = "npc",
          type = "",
          shape = "point",
          x = 105,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "susie",
            ["cutscene"] = "partyroom.susie",
            ["sprite"] = "wall_right"
          }
        },
        {
          id = 31,
          name = "npc",
          type = "",
          shape = "point",
          x = 810,
          y = 220,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "dess",
            ["cutscene"] = "partyroom.dess",
            ["flagcheck"] = "dess_obtained"
          }
        },
        {
          id = 60,
          name = "npc",
          type = "",
          shape = "point",
          x = 112,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ceroba_dw",
            ["cutscene"] = "partyroom.ceroba",
            ["flagcheck"] = "ceroba_inparty",
            ["sprite"] = "cool"
          }
        },
        {
          id = 33,
          name = "npc",
          type = "",
          shape = "point",
          x = 800,
          y = 620,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "starwalker",
            ["cutscene"] = "partyroom.starwalker",
            ["flagcheck"] = "ostarwalker_inparty"
          }
        },
        {
          id = 35,
          name = "",
          type = "",
          shape = "rectangle",
          x = 274,
          y = 500,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 274,
          y = 400,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 450,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 38,
          name = "",
          type = "",
          shape = "rectangle",
          x = 609,
          y = 500,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 39,
          name = "",
          type = "",
          shape = "rectangle",
          x = 609,
          y = 400,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 40,
          name = "npc",
          type = "",
          shape = "point",
          x = 535,
          y = 400,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "dumbie",
            ["flagcheck"] = "dumbie_inparty"
          }
        },
        {
          id = 48,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 570,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 49,
          name = "",
          type = "",
          shape = "rectangle",
          x = 440,
          y = 330,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "npc",
          type = "",
          shape = "point",
          x = 270,
          y = 454,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "YOU",
            ["cutscene"] = "partyroom.you",
            ["sprite"] = "e1"
          }
        },
        {
          id = 52,
          name = "npc",
          type = "",
          shape = "point",
          x = 379,
          y = 458,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "noyno",
            ["flagcheck"] = "noyno_inparty",
            ["sprite"] = "sit_4"
          }
        },
        {
          id = 53,
          name = "npc",
          type = "",
          shape = "point",
          x = 325,
          y = 464,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "robo_susie",
            ["facing"] = "down",
            ["flagcheck"] = "robo_susie_inparty"
          }
        },
        {
          id = 56,
          name = "npc",
          type = "",
          shape = "point",
          x = 520,
          y = 281,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "berdly",
            ["flagcheck"] = "berdly_inparty"
          }
        },
        {
          id = 77,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 285,
          y = 0,
          width = 80,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 78,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 450,
          y = 0,
          width = 80,
          height = 330,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 79,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 620,
          y = 0,
          width = 80,
          height = 400,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 80,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 450,
          y = 0,
          width = 80,
          height = 570,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 81,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 450,
          y = 0,
          width = 80,
          height = 450,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 82,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 285,
          y = 0,
          width = 80,
          height = 500,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 83,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 620,
          y = 0,
          width = 80,
          height = 500,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ff310094",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#334700aa",
            ["top_color"] = "#806a00ff"
          }
        },
        {
          id = 84,
          name = "npc",
          type = "",
          shape = "point",
          x = 160,
          y = 560,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "noel",
            ["cutscene"] = "partyroom.noel",
            ["sprite"] = "brella"
          }
        },
        {
          id = 86,
          name = "spotlight",
          type = "",
          shape = "rectangle",
          x = 120,
          y = 0,
          width = 80,
          height = 563,
          rotation = 0,
          visible = true,
          properties = {
            ["base_color"] = "#ffb9b9b9",
            ["base_thickness"] = 10,
            ["bottom_color"] = "#33c8c8c8",
            ["top_color"] = "#80e1e1e1"
          }
        },
        {
          id = 89,
          name = "superstar",
          type = "",
          shape = "point",
          x = 840,
          y = 280,
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
          id = 23,
          name = "entry",
          type = "",
          shape = "point",
          x = 640,
          y = 680,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 59,
          name = "wardrobe_unstuck",
          type = "",
          shape = "point",
          x = 200,
          y = 280,
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
      name = "controllers",
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
          id = 30,
          name = "toggle",
          type = "",
          shape = "point",
          x = 160,
          y = 360,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!susie_party",
            ["target"] = { id = 28 }
          }
        },
        {
          id = 32,
          name = "toggle",
          type = "",
          shape = "point",
          x = 840,
          y = 200,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!dess_party",
            ["target"] = { id = 31 }
          }
        },
        {
          id = 34,
          name = "toggle",
          type = "",
          shape = "point",
          x = 840,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!ostarwalker_party",
            ["target"] = { id = 33 }
          }
        },
        {
          id = 41,
          name = "toggle",
          type = "",
          shape = "point",
          x = 560,
          y = 383,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!dumbie_party",
            ["target"] = { id = 40 }
          }
        },
        {
          id = 50,
          name = "toggle",
          type = "",
          shape = "point",
          x = 270,
          y = 415,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!YOU_party",
            ["target"] = { id = 51 }
          }
        },
        {
          id = 54,
          name = "toggle",
          type = "",
          shape = "point",
          x = 380,
          y = 415,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!noyno_party",
            ["target"] = { id = 52 }
          }
        },
        {
          id = 55,
          name = "toggle",
          type = "",
          shape = "point",
          x = 325,
          y = 415,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!robo_susie_party",
            ["target"] = { id = 53 }
          }
        },
        {
          id = 58,
          name = "toggle",
          type = "",
          shape = "point",
          x = 545,
          y = 266,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!berdly_party",
            ["target"] = { id = 56 }
          }
        },
        {
          id = 61,
          name = "toggle",
          type = "",
          shape = "point",
          x = 156,
          y = 286,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "!ceroba_party",
            ["target"] = { id = 60 }
          }
        },
        {
          id = 85,
          name = "toggle",
          type = "",
          shape = "point",
          x = 120,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "noel_partyroom",
            ["target"] = { id = 84 }
          }
        },
        {
          id = 87,
          name = "toggle",
          type = "",
          shape = "point",
          x = 80,
          y = 600,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["flag"] = "noel_partyroom",
            ["target"] = { id = 86 }
          }
        }
      }
    }
  }
}
