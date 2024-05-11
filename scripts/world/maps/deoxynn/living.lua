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
  nextlayerid = 6,
  nextobjectid = 17,
  properties = {
    ["light"] = true,
    ["music"] = "room_003"
  },
  tilesets = {
    {
      name = "home",
      firstgid = 1,
      filename = "../../tilesets/frivatown/home.tsx",
      exportfilename = "../../tilesets/frivatown/home.lua"
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
        0, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 0,
        0, 426, 427, 428, 429, 430, 431, 432, 433, 434, 435, 436, 437, 438, 439, 0,
        0, 451, 452, 453, 454, 455, 456, 457, 458, 459, 460, 461, 462, 463, 464, 0,
        0, 476, 477, 478, 479, 480, 481, 482, 483, 484, 485, 486, 487, 488, 489, 0,
        0, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 512, 513, 514, 0,
        0, 526, 527, 528, 529, 530, 531, 532, 533, 534, 535, 536, 537, 538, 539, 0,
        0, 551, 552, 553, 554, 555, 556, 557, 558, 559, 560, 561, 562, 563, 564, 0,
        0, 576, 577, 578, 579, 580, 581, 582, 583, 584, 585, 586, 587, 588, 589, 0,
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
          x = 0,
          y = 0,
          width = 640,
          height = 258,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 376,
          y = 240,
          width = 98,
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
          x = 166,
          y = 240,
          width = 94,
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
          x = 240,
          y = 240,
          width = 160,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 400,
          width = 640,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "polygon",
          x = 119.992,
          y = 322,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 48.0078, y = -48 },
            { x = 40.0078, y = -82 },
            { x = 0.0078125, y = -82 }
          },
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "polygon",
          x = 514,
          y = 318,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -42, y = -41.9961 },
            { x = -34, y = -78 },
            { x = 6, y = -78 }
          },
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
          id = 9,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 40,
          y = 320,
          width = 80,
          height = 82,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "deoxynn/kitchen",
            ["marker"] = "liv"
          }
        },
        {
          id = 10,
          name = "transition",
          type = "",
          shape = "rectangle",
          x = 514,
          y = 318,
          width = 80,
          height = 82,
          rotation = 0,
          visible = true,
          properties = {
            ["map"] = "deoxynn/frivatown_home",
            ["marker"] = "liv"
          }
        },
        {
          id = 15,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 274,
          y = 240,
          width = 94,
          height = 64,
          rotation = 0,
          visible = true,
          properties = {
            ["cutscene"] = "frivatown.tv"
          }
        },
        {
          id = 16,
          name = "interactable",
          type = "",
          shape = "rectangle",
          x = 166,
          y = 240,
          width = 94,
          height = 80,
          rotation = 0,
          visible = true,
          properties = {
            ["text1"] = "* It's not Chariel."
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
          id = 13,
          name = "kit",
          type = "",
          shape = "point",
          x = 145,
          y = 345,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "frih",
          type = "",
          shape = "point",
          x = 490,
          y = 345,
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
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 601, 602, 603, 604, 605, 606, 607, 608, 609, 610, 611, 612, 613, 614, 0,
        0, 626, 627, 628, 629, 630, 631, 632, 633, 634, 635, 636, 637, 638, 639, 0,
        0, 651, 652, 653, 654, 655, 656, 657, 658, 659, 660, 661, 662, 663, 664, 0,
        0, 676, 677, 678, 679, 680, 681, 682, 683, 684, 685, 686, 687, 688, 689, 0,
        0, 701, 702, 703, 704, 705, 706, 707, 708, 709, 710, 711, 712, 713, 714, 0,
        0, 726, 727, 728, 729, 730, 731, 732, 733, 734, 735, 736, 737, 738, 739, 0,
        0, 751, 752, 753, 754, 755, 756, 757, 758, 759, 760, 761, 762, 763, 764, 0,
        0, 776, 777, 778, 779, 780, 781, 782, 783, 784, 785, 786, 787, 788, 789, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
      }
    }
  }
}
