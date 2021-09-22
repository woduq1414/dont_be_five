class MapJsonClass {
  static Map<String, dynamic> getMapJson() {
    return {
      "version": "2",
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
          ],
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
          ],
          "rule": "limit6"
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
            [1, 0, 999999, 2, 1],
            [2, 1, 0, -1, -1],
            [-1, -1, 101, -1, -1],
          ],
          "items": {"isolate": 1, "release": 1, "vaccine": 1},
          "pStarCondition": ["clear", "move 25 & clear", "no vaccine & clear"]
        },
        {
          "seq": 28,
          "mapWidth": 5,
          "mapHeight": 5,
          "map": [
            [-1, 102, -1, -1, -1],
            [-1, 0, 2, 0, 1],
            [-1, 1, 999999, 3, -1],
            [1, 1, 1, 0, -1],
            [-1, -1, -1, 102, -1],
          ],
          "isolated": [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [1, 0, 1, 0, 0],
            [0, 0, 0, 0, 0]
          ],
          "items": {"isolate": 1, "release": 1},
          "pStarCondition": ["clear", "move 15 & clear", "no isolate & clear"]
        },
        {
          "seq": 29,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [-1, -1, 101, -1, -1],
            [1, 2, 0, 101, -1],
            [1, 0, 2, -1, -1],
            [-1, -1, 1, 1, 999999],
          ],
          "items": {"isolate": 1, "release": 1},
          "pStarCondition": ["clear", "move 20 & clear", "move 15 & clear"]
        },
        {
          "seq": 30,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [-1, 2, -1, 2, -1],
            [101, 0, 2, 0, 2],
            [2, 0, 2, 0, 999999],
            [-1, 2, -1, 2, -1],
          ],
          "items": {"isolate": 1, "release": 1, "vaccine": 1},
          "pStarCondition": ["clear", "move 30 & clear", "no item & clear"]
        },
        {
          "seq": 31,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [-1, 1, -1, -1],
            [101, 0, 2, 2],
            [-1, 0, 0, 999999],
            [-1, 1, -1, -1],
          ],
          "confined": [
            [0, 0, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 0],
            [0, 0, 0, 0],
          ],
          "pStarCondition": ["clear", "move 15 & clear", "move 10 & clear"]
        },
        {
          "seq": 32,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [999999, 1, 0, 102],
            [1, 0, -1, -1],
            [1, 0, -1, -1],
            [0, 1, 0, 101],
          ],
          "confined": [
            [0, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 0, 0],
          ],
          "items": {"vaccine": 1},
          "pStarCondition": ["clear", "move 15 & clear", "no vaccine & clear"]
        },
        {
          "seq": 33,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [-1, 0, 2, -1],
            [1, 101, 0, 0],
            [-1, 1, 2, -1],
            [-1, 1, 999999, -1],
          ],
          "confined": [
            [0, 1, 1, 0],
            [1, 0, 0, 1],
            [0, 0, 0, 0],
            [0, 1, 0, 0],
          ],
          "pStarCondition": ["clear", "move 15 & clear", "move 10 & clear"]
        },
        {
          "seq": 34,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [101, 0, 1, -1, -1],
            [0, 3, 0, 3, 999999],
            [2, 0, 2, 0, 0],
            [0, -1, 1, 0, 0],
          ],
          "confined": [
            [0, 0, 0, 0, 0],
            [0, 1, 0, 1, 0],
            [0, 1, 0, 1, 0],
            [0, 0, 0, 0, 0],
          ],
          "items": {
            "isolate": 1,
            "vaccine": 1,
          },
          "pStarCondition": ["clear", "move 20 & clear", "no vaccine & clear"]
        },
        {
          "seq": 35,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [101, 0, 0, 2, 2],
            [0, 2, 2, 0, 0],
            [0, 0, 0, 2, 2],
            [2, 2, 0, 0, 999999],
          ],
          "confined": [
            [0, 0, 0, 0, 0],
            [0, 1, 1, 1, 0],
            [0, 1, 1, 1, 0],
            [0, 0, 0, 0, 0],
          ],
          "items": {
            "isolate": 1,
            "vaccine": 2,
          },
          "pStarCondition": ["clear", "move 20 & clear", "no vaccine & clear"]
        },
        {
          "seq": 36,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [102, 0, -1, -1, -1],
            [0, 2, 0, 2, -1],
            [3, -1, 3, 0, 999999],
            [0, 2, 0, -1, -1],
          ],
          "confined": [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [1, 1, 1, 0, 0],
          ],
          "items": {
            "isolate": 1,
            "release": 1,
            "vaccine": 1,
          },
          "pStarCondition": ["clear", "move 20 & clear", "no isolate & clear"]
        },
        {
          "seq": 37,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [101, -1, -1, 101],
            [0, 0, 0, 1],
            [1, 1, 0, 0],
            [1, -1, -1, 999999],
          ],
          "isolated": [
            [0, 0, 0, 0],
            [0, 1, 0, 0],
            [0, 0, 1, 0],
            [0, 0, 0, 0],
          ],
          "items": {
            "isolate": 1,
            "release": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 20 & clear", "move 15 & clear"]
        },
        {
          "seq": 38,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [-1, -1, 1, 999999],
            [-1, 2, 0, 1],
            [1, 0, 2, -1],
            [101, 1, -1, -1],
          ],
          "items": {
            "isolate": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 20 & clear", "no isolate & clear"]
        },
        {
          "seq": 39,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [0, 101, 0, 101, 0],
            [0, 2, -1, 2, 0],
            [1, -1, 2, -1, 1],
            [1, 0, 999999, 0, 1]
          ],
          "confined": [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [1, 0, 0, 0, 1],
            [1, 1, 0, 1, 1],
          ],
          "items": {
            "vaccine": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 10 & clear", "no vaccine & clear"]
        },
        {
          "seq": 40,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [1, 2, 999999, 3, 1],
            [0, -1, 2, -1, 0],
            [1, 1, 1, 1, 1],
            [-1, 101, -1, 101, -1]
          ],
          "confined": [
            [1, 1, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [1, 0, 0, 0, 1],
            [0, 0, 0, 0, 0],
          ],
          "isolated": [
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
          ],
          "items": {
            "vaccine": 1,
            "release": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 18 & clear", "no vaccine & clear"]
        },
        {
          "seq": 41,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [-1, 1, 0, 2, 999999],
            [2, 0, 0, 2, 0],
            [1, 0, 2, 0, 1],
            [101, 2, 0, 1, 2]
          ],
          "confined": [
            [0, 1, 1, 1, 0],
            [0, 0, 0, 0, 1],
            [0, 0, 0, 0, 1],
            [0, 0, 0, 0, 1],
          ],
          "isolated": [
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 1, 0],
            [0, 0, 0, 0, 0],
          ],
          "items": {
            "vaccine": 1,
            "release": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 20 & clear", "no vaccine & clear"]
        },
        {
          "seq": 42,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [-1, 999999, -1, 1, -1],
            [3, 0, 3, 0, 1],
            [1, 0, -1, 1, 101],
            [-1, 101, 1, 1, -1]
          ],
          "confined": [
            [0, 0, 0, 1, 0],
            [1, 0, 1, 0, 1],
            [1, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
          ],
          "isolated": [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
          ],
          "items": {
            "isolate": 1,
            "release": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 21 & clear", "move 18 & clear"]
        },
        {
          "seq": 5001,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [-1, -1, 2, -1],
            [101, 0, 0, 999999],
            [-1, -1, 3, -1],
            [-1, -1, 1, -1]
          ],
          "pStarCondition": [
            "clear",
            "move 15 & clear",
            "move 10 & clear",
          ],
          "rule": "limit5"
        },
        {
          "seq": 5004,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [101, 0, 0, 2, 2],
            [0, 2, 2, 0, 0],
            [0, 0, 0, 2, 2],
            [2, 2, 0, 0, 999999],
          ],
          "confined": [
            [0, 0, 0, 0, 0],
            [0, 1, 1, 1, 0],
            [0, 1, 1, 1, 0],
            [0, 0, 0, 0, 0],
          ],
          "items": {
            "isolate": 1,
            "vaccine": 2,
          },
          "pStarCondition": [
            "clear",
            "move 25 & clear",
            "move 20 & clear",
          ],
          "rule": "limit5"
        },
        {
          "seq": 5006,
          "mapWidth": 4,
          "mapHeight": 4,
          "map": [
            [101, 0, 1, 0],
            [101, 0, 0, 1],
            [-1, -1, -1, 0],
            [1, 1, 0, 999999]
          ],
          "pStarCondition": [
            "clear",
            "move 20 & clear",
            "no vaccine & clear",
          ],
          "items": {
            "vaccine": 1,
          },
          "rule": "limit3"
        },
        {
          "seq": 5009,
          "mapWidth": 5,
          "mapHeight": 4,
          "map": [
            [0, 101, 0, 101, 0],
            [101, 2, 0, 2, 101],
            [1, -1, 5, -1, 1],
            [2, 0, 999999, 0, 2]
          ],
          "confined": [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [1, 0, 0, 0, 1],
            [1, 1, 0, 1, 1],
          ],
          "items": {
            "vaccine": 1,
            "diagonal": 1,
          },
          "pStarCondition": ["clear", "move 18 & clear", "no vaccine & clear"],
          "rule": "limit7"
        },
        // {
        //   "seq": 43,
        //   "mapWidth": 4,
        //   "mapHeight": 4,
        //   "map": [
        //     [0,1,0,0],
        //     [1,0,1,0],
        //     [0,0,0,0],
        //     [0,0,101,999999]
        //   ],
        //   "confined": [
        //     [0,0,0,0],
        //     [0,1,1,0],
        //     [0,0,0,0],
        //     [0,0,0,0]
        //   ],
        //   "pStarCondition": ["clear", "move 21 & clear", "move 18 & clear"]
        // },
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
  }

  static Map<String, dynamic> getStoryMapJson() {
    return {
      "stories": [
        {
          "time": "2020년 12월",
          "confirmedSum": "52,550",
          "description": "23일, 수도권 내 첫 <5인 이상 집합 금지> 명령이 내려졌습니다. 변화된 상황 속에서 적응해나가야 합니다.",
          "levels": [5001, 5002, 5003]
        },
        {
          "time": "2021년 2월",
          "confirmedSum": "81,908",
          "description": "26일, 국내 코로나19 백신 접종이 전국 보건소와 요양병원에서 일제히 시작되었습니다.",
          "levels": [5004, 5005]
        },
        {
          "time": "2021년 7월",
          "confirmedSum": "81,908",
          "description": "12일, 수도권 거리두기 4단계 첫 날이 왔습니다. 오후 6시 이후에는 3인 이상 모일 수 없게되었습니다.",
          "levels": [5006, 5007, 5008]
        },
        {
          "time": "2021년 9월",
          "confirmedSum": "248,048",
          "description": "6일, 수도권 내 6인 모임이 허용되었습니다. 현재 18세 이상 인구를 기준으로 40% 가량이 2차 접종까지 마쳤습니다.",
          "levels": [5009, 5010, 5011]
        }
      ]
    };
  }
}
