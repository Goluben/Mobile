class Levels {

  List<int> barriers = [];
  List<int> boxes = [];
  List<int> stars = [];
  List <int> heart = [];

  List<int> barriers1 = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
  ];

  List<int> boxes1 = [
    12,
    14,
    16,
    28,
    21,
    41,
    61,
    81,
    83,
    63,
    63,
    65,
    67,
    47,
    39,
    19,
    1,
    30,
    50,
    70,
    96,
    79,
    7,
    3
  ];

  List<int> stars1 = [
    2,
    4,
    59,
    64,
    94
  ];

  List<int> heart1 = [
    26
  ];
  
  List<int> barriers2 = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
  ];

  List<int> boxes2 = [
    12,
    14,
    16,
    28,
    21,
    41,
    61,
    81,
    83,
    63,
    63,
    65,
    67,
    47,
    39,
    19,
    1,
    30,
    50,
    70,
    96,
    79,
    7,
    3
  ];

  List<int> stars2 = [
    5,
    20,
    92,
    9,
    43
  ];

  List<int> heart2 = [
    94
  ];

  void initLevel(int levelNumber) {
    switch (levelNumber) {
      case 1: {
        barriers = barriers1;
        boxes = boxes1;
        stars = stars1;
        heart = heart1;
        break;
      }

      case 2: {
        barriers = barriers2;
        boxes = boxes2;
        stars = stars2;
        heart = heart2;
        break;
      }
    }
  }
}