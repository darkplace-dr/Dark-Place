return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  name = "steamworks",
  class = "",
  tilewidth = 1024,
  tileheight = 1200,
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
  tilecount = 6,
  tiles = {
    {
      id = 2,
      image = "../../../assets/sprites/world/maps/steamworks/13_bg.png",
      width = 1024,
      height = 1200
    },
    {
      id = 3,
      image = "../../../assets/sprites/world/maps/steamworks/13_obj.png",
      width = 1024,
      height = 1200
    },
    {
      id = 4,
      image = "../../../assets/sprites/world/maps/steamworks/15_building_1.png",
      width = 624,
      height = 520,
      animation = {
        {
          tileid = 5,
          duration = 500
        },
        {
          tileid = 6,
          duration = 500
        },
        {
          tileid = 7,
          duration = 500
        },
        {
          tileid = 4,
          duration = 500
        }
      }
    },
    {
      id = 5,
      image = "../../../assets/sprites/world/maps/steamworks/15_building_2.png",
      width = 624,
      height = 520
    },
    {
      id = 6,
      image = "../../../assets/sprites/world/maps/steamworks/15_building_3.png",
      width = 624,
      height = 520
    },
    {
      id = 7,
      image = "../../../assets/sprites/world/maps/steamworks/15_building_4.png",
      width = 624,
      height = 520
    }
  }
}
