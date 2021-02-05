Map<String, dynamic> map_json = {
  "version": "1",
  "levels": [
    {
      "seq": 1,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, -1, -1],
        [101, 0, 0, 999999],
        [-1, -1, -1, -1],
        [-1, -1, -1, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq": 2,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, -1, -1],
        [101, 0, 2, 999999],
        [-1, -1, 1, -1],
        [-1, -1, 0, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq": 3,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [999999, 0, 0, 1],
        [-1, -1, -1, 1],
        [0, 0, 0, 1],
        [-1, -1, -1, 101]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq": 4,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, -1, 1, -1],
        [0, 0, 2, 0],
        [-1, 2, 0, -1],
        [-1, -1, 0, 999999]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq": 5,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, 1, -1],
        [101, 0, 2, 999999],
        [-1, -1, 1, -1],
        [-1, -1, 1, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq": 6,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [2, 0, 2, 999999],
        [0, -1, -1, 2],
        [0, -1, -1, -0],
        [101, 0, 0, 2]
      ],
      "pStarCondition": [
        "clear",
        "move 25 & clear",
        "move 15 & clear",
      ]
    },
    {
      "seq": 7,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, 1, 2, 0],
        [0, 0, 1, 2],
        [-1, -1, -1, -0],
        [-1, -1, -1, 999999]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ],
      "items": {
        "isolate": 1,
      },
    },
    {
      "seq": 8,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, 999999, -1],
        [2, 0, 2, 0],
        [2, 0, 0, 2],
        [-1, 101, 0, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ],
      "items": {
        "isolate": 1,
      },
    },
    {
      "seq": 9,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, 0, 0, 2],
        [-1, -1, -1, 0],
        [1, 999999, 0, 0],
        [3, 0, 2, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 20 & clear",
        "move 15 & clear",
      ],
      "items": {
        "isolate": 1,
      },
    },
    {
      "seq": 10,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, 0, -1, -1],
        [-1, 1, 1, 999999],
        [-1, 0, 3, 0],
        [-1, 3, 0, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "no isolate & clear",
      ],
      "items": {
        "isolate": 1,
      },
    },
    {
      "seq": 11,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, -1, -1],
        [0, 101, 1, 2],
        [-1, 1, 999999, 1],
        [-1, 2, 1, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "no isolate & clear",
      ],
      "items": {
        "isolate": 1,
      },
    },
    {
      "seq": 12,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, 1, 1, -1],
        [1, 1, 0, -1],
        [1, 0, 2, 1],
        [-1, -1, 1, 999999]
      ],
      "pStarCondition": [
        "clear",
        "move 15 & clear",
        "no isolate & clear",
      ],
      "items": {
        "isolate": 1,
      },
    },
    {
      "seq": 13,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, 1, -1, -1],
        [101, 2, 0, 999999],
        [-1, 3, -1, -1],
        [-1, 1, -1, -1]
      ],
      "isolated": [
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 10 & clear",
        "move 5 & clear",
      ],
      "items": {
        "release": 1,
      },
    },
    {
      "seq": 14,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, 1, -1, -1],
        [101, 1, 1, -1],
        [-1, 2, 1, 2],
        [-1, -1, 999999, -1]
      ],
      "isolated": [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 10 & clear",
        "no release & clear",
      ],
      "items": {
        "release": 1,
      },
    },
    {
      "seq": 15,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, -1, -1, 1],
        [0, 1, 1, 1],
        [3, -1, -1, 1],
        [1, 0, -1, 999999]
      ],
      "isolated": [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 0, 0, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 20 & clear",
        "move 15 & clear",
      ],
      "items": {
        "release": 1,
      },
    },
    {
      "seq": 16,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, -1, 999999],
        [2, 0, 2, 0],
        [-1, 101, -1, 101],
        [2, 0, 2, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 20 & clear",
        "move 15 & clear",
      ],
      "items": {
        "isolate": 1,
        "release": 1,
      },
    },
    {
      "seq": 17,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, -1, -1, -1],
        [0, 3, 0, 999999],
        [3, 0, 2, 0],
        [101, -1, -1, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 25 & clear",
        "move 15 & clear",
      ],
      "items": {
        "isolate": 1,
        "release": 1,
      },
    },
    {
      "seq": 18,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, 0, 999999, 3],
        [-1, 3, -1, 0],
        [101, 0, 3, 0],
        [-1, 101, -1, 0]
      ],
      "pStarCondition": [
        "clear",
        "move 25 & clear",
        "move 15 & clear",
      ],
      "items": {
        "isolate": 1,
        "release": 1,
      },
    },
    {
      "seq": 19,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [101, 0, 1, 1],
        [101, -1, -1, 1],
        [-1, -1, -1, 0],
        [-1, -1, 0, 999999]
      ],
      "pStarCondition": [
        "clear",
        "move 25 & clear",
        "move 15 & clear",
      ],
      "items": {
        "vaccine": 1,
      },
    },
    {
      "seq": 20,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [101, -1, 0, 3, 0],
        [0, 1, 0, -1, 999999],
        [0, -1, 0, -1, -1],
        [0, 101, 0, -1, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 20 & clear",
        "move 15 & clear",
      ],
      "items": {
        "vaccine": 1,
      },
    },
    {
      "seq": 21,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [1, -1, -1, -1, 2],
        [1, 2, 999999, 3, 0],
        [-1, 1, -1, 0, -1],
        [-1, 101, -1, 101, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 20 & clear",
        "move 15 & clear",
      ],
      "items": {
        "vaccine": 2,
      },
    },
    {
      "seq": 22,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [-1, -1, 0, -1, 999999],
        [-1, -1, 2, 0, 2],
        [2, 0, 2, -1, -1],
        [101, -1, 0, -1, -1]
      ],
      "pStarCondition": [
        "clear",
        "move 20 & clear",
        "move 15 & clear",
      ],
      "items": {
        "vaccine": 2,
      },
    },
    {
      "seq": 23,
      "mapWidth": 5,
      "mapHeight": 5,
      "map": [
        [0, 3, -1, -1, -1],
        [101, 0, -1, -1, -1],
        [-1, 0, -1, 0, 999999],
        [-1, 0, -1, 1, 2],
        [2, 2, 0, 1, -1]
      ],
      "items": {"isolate": 1, "release": 1, "vaccine": 1},
      "pStarCondition": ["clear", "move 15 & clear", "no vaccine & clear"]
    },
    {
      "seq": 24,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [2, 0, 3, 0, 2],
        [
          999999,
          -1,
          0,
          2,
          0,
        ],
        [-1, -1, -1, 0, 0],
        [101, 101, 0, 0, 0]
      ],
      "pStarCondition": ["clear", "move 25 & clear", "no vaccine & clear"],
      "items": {"isolate": 1, "release": 1, "vaccine": 1},
    },
    {
      "seq": 25,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, -1, 999999],
        [0, 0, 0, 3],
        [1, 2, -1, 1],
        [101, 1, -1, 2]
      ],
      "isolated": [
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        [1, 0, 0, 0],
        [0, 0, 0, 0]
      ],
      "items": {"isolate": 1, "release": 1},
      "pStarCondition": ["clear", "move 25 & clear", "no isolate & clear"]
    },
    {
      "seq": 26,
      "mapWidth": 4,
      "mapHeight": 4,
      "map": [
        [-1, -1, -1, 999999],
        [101, 0, 2, 0],
        [-1, 2, 2, -1],
        [-1, 101, 0, -1]
      ],
      "items": {"vaccine": 2},
      "pStarCondition": ["clear", "move 15 & clear", "move 10 & clear"]
    },
    {
      "seq": 27,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [101, 2, 2, -1, 101],
        [1,0,999999,2,1],
        [2,1,0,-1,-1],
        [-1,-1,101,-1,-1],
      ],
      "items": {"isolate" : 1, "release" : 1, "vaccine": 1},
      "pStarCondition": ["clear", "move 25 & clear", "no vaccine & clear"]
    },
    {
      "seq": 28,
      "mapWidth": 5,
      "mapHeight": 5,
      "map": [
        [-1, 102, -1, -1, -1],
        [-1,0,2,0,1],
        [-1,1,999999,3,-1],
        [1,1,1,0,-1],
        [-1,-1,-1,102,-1],
      ],
      "isolated": [
        [0, 0, 0, 0,0],
        [0, 0, 0, 0,0],
        [0, 0, 0, 0,0],
        [1, 0, 1, 0,0],
        [0, 0, 0, 0,0]
      ],
      "items": {"isolate" : 1, "release" : 1},
      "pStarCondition": ["clear", "move 15 & clear", "no isolate & clear"]
    },

    {
      "seq": 29,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [-1, -1, 101, -1, -1],
        [1,2,0,101,-1],
        [1,0,2,-1,-1],
        [-1,-1,1,1,999999],
      ],
      "items": {"isolate" : 1, "release" : 1},
      "pStarCondition": ["clear", "move 20 & clear", "move 15 & clear"]
    },
    {
      "seq": 30,
      "mapWidth": 5,
      "mapHeight": 4,
      "map": [
        [-1, 2, -1, 2, -1],
        [101,0,2,0,2],
        [2,0,2,0,999999],
        [-1,2,-1,2,-1],
      ],
      "items": {"isolate" : 1, "release" : 1, "vaccine": 1},
      "pStarCondition": ["clear", "move 30 & clear", "no item & clear"]
    },

  ]
};

// Map<String, dynamic> map_json = {
//   "version" : "1",
//   "levels" : [
//
//     {
//       "seq" : 1,
//       "mapWidth" : 4,
//       "mapHeight" : 4,
//       "map" : [[-1,-1,-1,999999],[0,0,0,3],[0,2,-1,1],[101, 1,-1,2]],
//       "items" : {
//         "isolate" : 1,
//         "release" : 1,
//         "vaccine" : 2
//       },
//       "pStarCondition" : [
//         "clear",
//         "move 15 & clear",
//         "no item & clear"
//       ]
//     },
//     {
//       "seq" : 2,
//       "mapWidth" : 5,
//       "mapHeight" : 5,
//       "map" : [[0,3,-1,-1,-1],[101,0,-1,-1,-1],[-1,0,-1,1,999999],[-1,0,-1,1,2], [2,2,0,0,-1]],
//       "items" : {
//         "isolate" : 1,
//         "release" : 1,
//         "vaccine" : 2
//       },
//       "pStarCondition" : [
//         "clear",
//         "move 15 & clear",
//         "no isolate & clear"
//       ]
//     },
//     {
//       "seq" : 3,
//       "mapWidth" : 4,
//       "mapHeight" : 4,
//       "map" : [[-1,-1,-1,999999],[101,0,2,0],[-1,2,2,-1],[-1, 101,0,-1]],
//       "items" : {
//         "isolate" : 1,
//         "release" : 1,
//         "vaccine" : 2
//       },
//       "pStarCondition" : [
//         "clear",
//         "move 15 & clear",
//         "no isolate & clear"
//       ]
//     },
//     {
//       "seq" : 4,
//       "mapWidth" : 5,
//       "mapHeight" : 4,
//       "map" :  [[0,0,2,3,2],[999999,-1,0,2,0,],[-1,-1,-1,0,0],[101,101,0,0,0]],
//       "pStarCondition" : [
//         "clear",
//         "move 25 & clear",
//         "no vaccine & clear"
//       ],
//       "items" : {
//         "isolate" : 1,
//         "release" : 1,
//         "vaccine" : 2
//       },
//     },
//     {
//       "seq" : 5,
//       "mapWidth" : 4,
//       "mapHeight" : 4,
//       "map" : [[2,1,0,0],[1,0,1,0],[0,1,101,0],[0, 0,0,999999]],
//       "items" : {
//         "isolate" : 1,
//         "release" : 1,
//         "vaccine" : 2
//       },
//       "pStarCondition" : [
//         "clear",
//         "move 15 & clear",
//         "no item & clear"
//       ]
//     },
//   ]
// };
