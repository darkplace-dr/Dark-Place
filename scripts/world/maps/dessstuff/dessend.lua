return {
  version = "1.4",
  luaversion = "5.1",
  tiledversion = "1.4.3",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 16,
  height = 24,
  tilewidth = 40,
  tileheight = 40,
  nextlayerid = 7,
  nextobjectid = 65,
  properties = {
    ["music"] = "gimmieyourwalletmiss",
    ["name"] = "Dess - THE ENDING"
  },
  tilesets = {
    {
      name = "castle",
      firstgid = 1,
      filename = "../../tilesets/castle.tsx",
      tilewidth = 40,
      tileheight = 40,
      spacing = 4,
      margin = 2,
      columns = 6,
      image = "../../../../assets/sprites/tilesets/castle.png",
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
      name = "whitespace",
      firstgid = 61,
      filename = "../../tilesets/whitespace.tsx",
      tilewidth = 40,
      tileheight = 40,
      spacing = 0,
      margin = 0,
      columns = 3,
      image = "../../../../assets/sprites/tilesets/whitespace.png",
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
    },
    {
      name = "city_alleyway",
      firstgid = 70,
      filename = "../../../../../Github-Lmao/Dark-Place/scripts/world/tilesets/city_alleyway.tsx",
      tilewidth = 40,
      tileheight = 40,
      spacing = 0,
      margin = 0,
      columns = 15,
      image = "../../../../../Github-Lmao/Dark-Place/assets/sprites/tilesets/bg_dw_city_alleyway.png",
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
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 24,
      id = 1,
      name = "tiles",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 68, 68, 68, 68, 68, 68, 68, 68, 68, 65, 65, 65, 65,
        65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65,
        65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65,
        65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65,
        65, 65, 66, 65, 65, 65, 65, 65, 65, 65, 65, 65, 64, 65, 65, 65,
        65, 65, 65, 62, 62, 62, 63, 65, 61, 62, 62, 62, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 61, 65, 62, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65,
        65, 65, 65, 65, 65, 65, 64, 65, 65, 64, 65, 65, 65, 65, 65, 65
      }
    },
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 16,
      height = 24,
      id = 2,
      name = "decal",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 291, 292, 293, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 306, 307, 308, 0, 0, 0, 0, 0, 0, 0,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
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
      id = 3,
      name = "collision",
      visible = true,
      opacity = 0.5,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 17,
          name = "",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 280,
          width = 40,
          height = 680,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "rectangle",
          x = 360,
          y = 280,
          width = 40,
          height = 680,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 50,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 240,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 51,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 240,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 62,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 40,
          width = 440,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 63,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 80,
          width = 40,
          height = 160,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 64,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 80,
          width = 40,
          height = 160,
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
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 53,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 240,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ufoofdoom",
            ["encounter"] = "mimicboss"
          }
        },
        {
          id = 54,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 600,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ufoofdoom",
            ["encounter"] = "ufoofdooms",
            ["group"] = 1
          }
        },
        {
          id = 55,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 600,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ufoofdoom",
            ["encounter"] = "ufoofdooms",
            ["group"] = 1
          }
        },
        {
          id = 56,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 260,
          y = 480,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ufoofdoom",
            ["encounter"] = "ufoofdooms",
            ["group"] = 2
          }
        },
        {
          id = 57,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 300,
          y = 480,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ufoofdoom",
            ["encounter"] = "ufoofdooms",
            ["group"] = 2
          }
        },
        {
          id = 58,
          name = "enemy",
          type = "",
          shape = "rectangle",
          x = 280,
          y = 720,
          width = 40,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["actor"] = "ufoofdoom",
            ["encounter"] = "ufoofdooms"
          }
        },
        {
          id = 59,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 70,
          width = 120,
          height = 90,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "spamroom.warpbin",
            ["solid"] = true
          }
        },
        {
          id = 60,
          name = "script",
          type = "",
          shape = "rectangle",
          x = 240,
          y = 280,
          width = 120,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "desslmao.dessboss",
            ["once"] = true
          }
        },
        {
          id = 61,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 200,
          y = 960,
          width = 200,
          height = 40,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "dessstuff/dessstart",
            ["marker"] = "entry"
          }
        }
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 5,
      name = "markers",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      objects = {
        {
          id = 20,
          name = "entry",
          type = "",
          shape = "point",
          x = 300,
          y = 920,
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
