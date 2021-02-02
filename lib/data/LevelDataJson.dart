Map<String, dynamic> map_json = {
  "version" : "1",
  "levels" : [

    {
      "seq" : 1,
      "mapWidth" : 4,
      "mapHeight" : 4,
      "map" : [[-1,-1,-1,-1],[101,0,0,999999],[-1,-1,-1,-1],[-1,-1,-1,-1]],
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq" : 2,
      "mapWidth" : 4,
      "mapHeight" : 4,
      "map" : [[-1,-1,-1,-1],[101,0,2,999999],[-1,-1,1,-1],[-1,-1,0,-1]],
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq" : 3,
      "mapWidth" : 4,
      "mapHeight" : 4,
      "map" : [[999999,0,0,1],[-1,-1,-1,1],[0,0,0,1],[-1,-1,-1,101]],
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
    },
    {
      "seq" : 4,
      "mapWidth" : 4,
      "mapHeight" : 4,
      "map" : [[101,-1,1,-1],[0,0,2,0],[-1,2,0,-1],[-1,-1,0,999999]],
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "move 10 & clear",
      ]
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