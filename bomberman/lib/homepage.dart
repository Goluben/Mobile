import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'button.dart';
import 'pixel.dart';
import 'levels.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  int numberOfSquares = 100;
  int playerPosition = 0;
  int bombPosition = -1;
  int score = 0;
  int health = 2;

  int nextIndex = 99;

  int levelNumber = 1;
  List<int> barriers = [];
  List<int> boxes = [];
  List<int> stars = [];
  List<int> heart = [];

  void initLevel(int level) {
    Levels levels = new Levels();
    levels.initLevel(levelNumber);
    boxes = levels.boxes;
    barriers = levels.barriers;
    stars = levels.stars;
    heart = levels.heart;
  }

  showIfBad() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('You Died!!'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('OK'))
            ],
          ));

  showIfNice() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('You Won!!'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context, 'Cancel');
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('OK'))
            ],
          ));

  void nextLvl() {
    playerPosition = 0;
    bombPosition = -1;
    levelNumber++;

    if (levelNumber > 2) {
      showIfNice();
    }

    Levels levels = new Levels();
    levels.initLevel(levelNumber);
    boxes = levels.boxes;
    barriers = levels.barriers;
    stars = levels.stars;
    heart = levels.heart;
  }

  void pickUpStar() {
    setState(() {
      if (stars.contains(playerPosition)) {
        stars.remove(playerPosition);
        score += 15;
      }
    });
  }

  void pickUpHeart() {
    setState(() {
      if (heart.contains(playerPosition)) {
        heart.remove(playerPosition);
        health++;
      }
    });
  }

  void moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
        pickUpStar();
        pickUpHeart();

        if (playerPosition == nextIndex) {
          nextLvl();
        }
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0) &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
        pickUpStar();
        pickUpHeart();

        if (playerPosition == nextIndex) {
          nextLvl();
        }
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
        pickUpStar();
        pickUpHeart();

        if (playerPosition == nextIndex) {
          nextLvl();
        }
      }
    });
  }

  void moveDown() {
    setState(() {
      if (playerPosition + 10 < numberOfSquares &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
        pickUpStar();
        pickUpHeart();

        if (playerPosition == nextIndex) {
          nextLvl();
        }
      }
    });
  }

  List<int> fire = [-1];

  void placeBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(Duration(milliseconds: 1000), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition - 10);
          fire.add(bombPosition + 10);
        });
        clearFire();
      });
    });
  }

  void clearFire() {
    setState(() {
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          if (playerPosition == bombPosition ||
              playerPosition == bombPosition - 1 ||
              playerPosition == bombPosition + 1 ||
              playerPosition == bombPosition - 10 ||
              playerPosition == bombPosition + 10) {
            if (health < 2) {
              showIfBad();
            } else {
              health--;
            }
          }
          for (int i = 0; i < fire.length; i++) {
            if (boxes.contains(fire[i])) {
              boxes.remove(fire[i]);
            }
          }
          fire.clear();
          bombPosition = -1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isInit) {
      initLevel(levelNumber);
      isInit = false;
    }

    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10),
                  itemBuilder: (BuildContext context, int index) {
                    if (fire.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.orange,
                        outerColor: Colors.orange[900],
                      );
                    } else if (bombPosition == index) {
                      return MyPixel(
                        innerColor: Colors.red,
                        outerColor: Colors.red[800],
                        child: Icon(Icons.dangerous),
                      );
                    } else if (playerPosition == index) {
                      return MyPixel(
                        innerColor: Colors.red,
                        outerColor: Colors.red[800],
                        child: Icon(Icons.man),
                      );
                    } else if (nextIndex == index) {
                      return MyPixel(
                        innerColor: Colors.yellow,
                        outerColor: Colors.yellow[800],
                      );
                    } else if (heart.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.pink,
                        outerColor: Colors.pink[800],
                        child: Icon(Icons.heart_broken),
                      );
                    } else if (stars.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.blue,
                        outerColor: Colors.blue[800],
                        child: Icon(Icons.star),
                      );
                    } else if (barriers.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.black,
                        outerColor: Colors.black,
                      );
                    } else if (boxes.contains(index)) {
                      return MyPixel(
                        innerColor: Colors.deepPurple,
                        outerColor: Colors.deepPurple[800],
                      );
                    } else {
                      return MyPixel(
                        innerColor: Colors.green,
                        outerColor: Colors.green[800],
                      );
                    }
                  }),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        function: moveUp,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_up,
                          size: 70,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(
                        function: moveLeft,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_left,
                          size: 70,
                        ),
                      ),
                      MyButton(
                        function: placeBomb,
                        color: Colors.grey[900],
                        child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(Icons.dangerous_outlined)),
                      ),
                      MyButton(
                        function: moveRight,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_right,
                          size: 70,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyButton(),
                      MyButton(
                        function: moveDown,
                        color: Colors.grey,
                        child: Icon(
                          Icons.arrow_drop_down,
                          size: 70,
                        ),
                      ),
                      MyButton(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Score: ' + '$score',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Health: ' + '$health',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
