return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.1",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 44,
  height = 12,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 87,
  properties = {
    ["music"] = "greenroom",
    ["name"] = "Dev Diner - Dining Area"
  },
  tilesets = {
    {
      name = "devroom",
      firstgid = 1,
      class = "",
      tilewidth = 40,
      tileheight = 40,
      spacing = 0,
      margin = 0,
      columns = 6,
      image = "../../../../../../assets/sprites/tilesets/devroom.png",
      imagewidth = 278,
      imageheight = 480,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
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
      wangsets = {},
      tilecount = 72,
      tiles = {}
    },
    {
      name = "devroom-objects",
      firstgid = 73,
      class = "",
      tilewidth = 145,
      tileheight = 120,
      spacing = 0,
      margin = 0,
      columns = 0,
      objectalignment = "unspecified",
      tilerendersize = "tile",
      fillmode = "stretch",
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 1,
        height = 1
      },
      properties = {},
      wangsets = {},
      tilecount = 19,
      tiles = {
        {
          id = 10,
          image = "../../../../../../assets/sprites/world/maps/example_area/spamton_graffiti.png",
          width = 66,
          height = 40
        },
        {
          id = 11,
          image = "../../../../../../assets/sprites/world/maps/vapor/palmtree_cyan.png",
          width = 67,
          height = 64
        },
        {
          id = 13,
          image = "../../../../../../assets/sprites/world/events/devroom/billboard.png",
          width = 120,
          height = 120
        },
        {
          id = 18,
          image = "../../../../../../assets/sprites/world/maps/vapor/pillar.png",
          width = 29,
          height = 90
        },
        {
          id = 19,
          image = "../../../../../../assets/sprites/world/events/devroom/warphub/spamgolor_door.png",
          width = 51,
          height = 40
        },
        {
          id = 20,
          image = "../../../../../../assets/sprites/world/events/devroom/diner_table.png",
          width = 50,
          height = 35
        },
        {
          id = 21,
          image = "../../../../../../assets/sprites/world/events/devroom/doorway.png",
          width = 40,
          height = 60
        },
        {
          id = 22,
          image = "../../../../../../assets/sprites/world/events/devroom/cabinet.png",
          width = 145,
          height = 64
        },
        {
          id = 23,
          image = "../../../../../../assets/sprites/world/events/devroom/counter.png",
          width = 100,
          height = 30
        },
        {
          id = 27,
          image = "../../../../../../assets/sprites/world/maps/devroom/warphub/sold_sign.png",
          width = 50,
          height = 22
        },
        {
          id = 28,
          image = "../../../../../../assets/sprites/world/events/example_area/pink_shop.png",
          width = 59,
          height = 83
        },
        {
          id = 31,
          image = "../../../../../../assets/sprites/world/events/devroom/warphub/pasta_shop_door.png",
          width = 62,
          height = 93
        },
        {
          id = 37,
          image = "../../../../../../assets/sprites/world/events/devroom/doorway_double.png",
          width = 80,
          height = 60
        },
        {
          id = 40,
          image = "../../../../../../assets/sprites/world/events/devroom/devfountain_1.png",
          width = 81,
          height = 39,
          animation = {
            {
              tileid = 40,
              duration = 1000
            },
            {
              tileid = 41,
              duration = 1000
            }
          }
        },
        {
          id = 41,
          image = "../../../../../../assets/sprites/world/events/devroom/devfountain_2.png",
          width = 81,
          height = 39
        },
        {
          id = 42,
          image = "../../../../../../assets/sprites/world/events/devroom/devsign.png",
          width = 40,
          height = 40
        },
        {
          id = 43,
          image = "../../../../../../assets/sprites/world/events/sign.png",
          width = 40,
          height = 40
        },
        {
          id = 44,
          image = "../../../../../../assets/sprites/world/events/example_area/blankie_wall_note.png",
          width = 34,
          height = 34
        },
        {
          id = 45,
          image = "../../../../../../assets/sprites/world/maps/devroom/hotel/addison_plushies.png",
          width = 115,
          height = 29
        }
      }
    }
  },
  layers = {
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 6,
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
      width = 44,
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
        8, 8, 8, 9, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 8, 8, 8,
        8, 8, 8, 9, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 10, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 11, 12, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 8, 8, 8,
        8, 8, 8, 9, 8, 7, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 16, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 17, 18, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 9, 8, 8, 8,
        8, 8, 8, 9, 8, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 8, 8, 5, 5, 6, 9, 8, 8, 8,
        8, 8, 8, 9, 5, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 8, 8, 2, 2, 3, 6, 8, 8, 8,
        5, 5, 5, 6, 1, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 3, 8, 8, 8,
        2, 2, 2, 2, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8, 8,
        14, 14, 14, 14, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 9, 8, 8, 8,
        8, 8, 8, 8, 13, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 15, 8, 8, 8,
        8, 8, 8, 8, 8, 13, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 8, 8, 14, 14, 15, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 9, 8, 8, 8, 8, 8, 8, 8,
        8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 8, 7, 9, 8, 8, 8, 8, 8, 8, 8
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "objects_props",
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
          id = 84,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1400,
          y = 160,
          width = 80,
          height = 120,
          rotation = 0,
          gid = 94,
          visible = true,
          properties = {}
        },
        {
          id = 86,
          name = "",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 160,
          width = 290,
          height = 128,
          rotation = 0,
          gid = 95,
          visible = true,
          properties = {}
        }
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
          x = 0,
          y = 200,
          width = 160,
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
          x = 0,
          y = 320,
          width = 160,
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
          x = 160,
          y = 120,
          width = 40,
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
          x = 200,
          y = 120,
          width = 1200,
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
          x = 1480,
          y = 120,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 160,
          y = 360,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 400,
          width = 1200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1640,
          y = 200,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 120,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1600,
          y = 360,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 320,
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
          x = 1120,
          y = 320,
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
          x = 1240,
          y = 240,
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
          x = 1360,
          y = 320,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 24,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 240,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 32,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 240,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 33,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 240,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 36,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 240,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 37,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 320,
          width = 100,
          height = 30,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 330,
          y = 148,
          width = 190,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 68,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 400,
          width = 120,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 69,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1360,
          y = 440,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 70,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 440,
          width = 40,
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
          id = 25,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1400,
          y = 108,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devdiner/partyroom",
            ["marker"] = "entry"
          }
        },
        {
          id = 49,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = -40,
          y = 240,
          width = 40,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devdiner/devstart",
            ["marker"] = "entry"
          }
        },
        {
          id = 58,
          name = "npc",
          type = "",
          shape = "point",
          x = 425,
          y = 153,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "shadowsalesman",
            ["cutscene"] = "devroom.shadowshop"
          }
        },
        {
          id = 63,
          name = "npc",
          type = "",
          shape = "point",
          x = 810,
          y = 180,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "brandon",
            ["cutscene"] = "devroom.brandon",
            ["flagcheck"] = "!brandon_inparty"
          }
        },
        {
          id = 65,
          name = "npc",
          type = "",
          shape = "point",
          x = 200,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "velvet",
            ["cutscene"] = "devroom.velvet"
          }
        },
        {
          id = 67,
          name = "npc",
          type = "",
          shape = "point",
          x = 810,
          y = 240,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "brandon",
            ["cond"] = "Game:getFlag(\"brandon_inparty\") and not Game:hasPartyMember(\"brandon\")",
            ["cutscene"] = "partyroom.brandon"
          }
        },
        {
          id = 71,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 1400,
          y = 480,
          width = 80,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "devhotel/devhotel_lobby",
            ["marker"] = "north"
          }
        },
        {
          id = 73,
          name = "",
          type = "",
          shape = "rectangle",
          x = 325,
          y = 190,
          width = 200,
          height = 60,
          rotation = 0,
          gid = 96,
          visible = true,
          properties = {}
        },
        {
          id = 74,
          name = "",
          type = "",
          shape = "rectangle",
          x = 520,
          y = 270,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 75,
          name = "",
          type = "",
          shape = "rectangle",
          x = 760,
          y = 270,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 76,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1000,
          y = 270,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 77,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1240,
          y = 270,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 78,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1480,
          y = 270,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 79,
          name = "",
          type = "",
          shape = "rectangle",
          x = 640,
          y = 350,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 81,
          name = "",
          type = "",
          shape = "rectangle",
          x = 880,
          y = 350,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 82,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1120,
          y = 350,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
          visible = true,
          properties = {}
        },
        {
          id = 83,
          name = "",
          type = "",
          shape = "rectangle",
          x = 1360,
          y = 350,
          width = 100,
          height = 70,
          rotation = 0,
          gid = 93,
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
          id = 50,
          name = "entry",
          type = "",
          shape = "point",
          x = 40,
          y = 280,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "entry1",
          type = "",
          shape = "point",
          x = 1440,
          y = 180,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 72,
          name = "entry2",
          type = "",
          shape = "point",
          x = 1440,
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
