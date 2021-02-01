Map<String, dynamic> map_json = {
  "version" : "1",
  "levels" : [
    {
      "seq" : 1,
      "mapWidth" : 4,
      "mapHeight" : 4,
      "map" : [[-1,-1,-1,999999],[0,0,0,3],[0,2,-1,1],[101, 1,-1,2]],
      "items" : {
        "isolate" : 1,
        "release" : 1,
        "vaccine" : 2
      },
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "no item & clear"
      ]
    },
    {
      "seq" : 2,
      "mapWidth" : 5,
      "mapHeight" : 5,
      "map" : [[0,3,-1,-1,-1],[101,0,-1,-1,-1],[-1,0,-1,1,999999],[-1,0,-1,1,2], [2,2,0,0,-1]],
      "items" : {
        "isolate" : 1,
        "release" : 1,
        "vaccine" : 1
      },
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "no item & clear"
      ]
    },
    {
      "seq" : 3,
      "mapWidth" : 4,
      "mapHeight" : 4,
      "map" : [[-1,-1,-1,999999],[101,0,2,0],[-1,2,2,-1],[-1, 101,0,-1]],
      "items" : {
        "isolate" : 1,
        "release" : 1,
        "vaccine" : 2
      },
      "pStarCondition" : [
        "clear",
        "move 15 & clear",
        "no item & clear"
      ]
    }
  ]
};