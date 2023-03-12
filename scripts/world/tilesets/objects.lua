return {
  version = "1.5",
  luaversion = "5.1",
  tiledversion = "1.8.4",
  name = "objects",
  tilewidth = 66,
  tileheight = 725,
  spacing = 0,
  margin = 0,
  columns = 0,
  objectalignment = "unspecified",
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
  tilecount = 8,
  tiles = {
    {
      id = 0,
      image = "../../../assets/sprites/objects/tissuebox.png",
      width = 21,
      height = 20
    },
    {
      id = 1,
      image = "../../../assets/sprites/objects/laptop1.png",
      width = 31,
      height = 21,
      animation = {
        {
          tileid = 1,
          duration = 100
        },
        {
          tileid = 2,
          duration = 100
        },
        {
          tileid = 3,
          duration = 100
        }
      }
    },
    {
      id = 2,
      image = "../../../assets/sprites/objects/laptop2.png",
      width = 31,
      height = 21
    },
    {
      id = 3,
      image = "../../../assets/sprites/objects/laptop3.png",
      width = 31,
      height = 21
    },
    {
      id = 4,
      image = "../../../assets/sprites/objects/sketchbook.png",
      width = 14,
      height = 17
    },
    {
      id = 5,
      image = "../../../assets/sprites/objects/lightbulb1.png",
      width = 15,
      height = 725,
      animation = {
        {
          tileid = 5,
          duration = 500
        },
        {
          tileid = 6,
          duration = 500
        }
      }
    },
    {
      id = 6,
      image = "../../../assets/sprites/objects/lightbulb2.png",
      width = 15,
      height = 725
    },
    {
      id = 10,
      image = "../../../assets/sprites/objects/spamton_graffiti.png",
      width = 66,
      height = 40
    }
  }
}
