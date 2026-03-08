import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/feature/emulator/presentation/widget/clean_app_bar.dart';

class SnakeGameScreen extends StatefulWidget {
  const SnakeGameScreen({super.key});

  @override
  State<SnakeGameScreen> createState() => _SnakeGameScreenState();
}

class _SnakeGameScreenState extends State<SnakeGameScreen> {
  static const int squaresPerRow = 20;
  static const int squaresPerCol = 20;
  static const int folderCount = squaresPerRow * squaresPerCol;
  static const duration = Duration(milliseconds: 300);

  List<int> snake = [45, 44, 43];
  int food = 0;
  String direction = 'right';
  bool isPlaying = false;
  Timer? timer;
  int score = 0;

  @override
  void initState() {
    Globals.isBackDisabled = false;
    super.initState();
    generateFood();
  }

  void generateFood() {
    food = Random().nextInt(folderCount);
    if (snake.contains(food)) {
      generateFood();
    }
  }

  void startGame() {
    score = 0;
    snake = [45, 44, 43];
    direction = 'right';
    isPlaying = true;
    timer = Timer.periodic(duration, (Timer t) {
      updateSnake();
    });
    setState(() {});
  }

  void stopGame() {
    timer?.cancel();
    isPlaying = false;
    setState(() {});
  }

  void updateSnake() {
    setState(() {
      if (checkCollision()) {
        stopGame();
        showGameOverDialog();
        return;
      }

      if (snake.first == food) {
        score++;
        generateFood();
      } else {
        snake.removeLast();
      }

      switch (direction) {
        case 'up':
          if (snake.first < squaresPerRow) {
            snake.insert(0, snake.first - squaresPerRow + folderCount);
          } else {
            snake.insert(0, snake.first - squaresPerRow);
          }
          break;
        case 'down':
          if (snake.first >= folderCount - squaresPerRow) {
            snake.insert(0, snake.first + squaresPerRow - folderCount);
          } else {
            snake.insert(0, snake.first + squaresPerRow);
          }
          break;
        case 'left':
          if (snake.first % squaresPerRow == 0) {
            snake.insert(0, snake.first - 1 + squaresPerRow);
          } else {
            snake.insert(0, snake.first - 1);
          }
          break;
        case 'right':
          if ((snake.first + 1) % squaresPerRow == 0) {
            snake.insert(0, snake.first + 1 - squaresPerRow);
          } else {
            snake.insert(0, snake.first + 1);
          }
          break;
      }
    });
  }

  bool checkCollision() {
    if (snake.sublist(1).contains(snake.first)) {
      return true;
    }
    return false;
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          title: const Text(
            'Game Over',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          content: Text(
            'Your Score: $score',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Exit',
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    Globals.isBackDisabled = true;
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: const CleanAppBar(
        title: 'Snake',
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Score & Start row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Score: $score',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
                if (!isPlaying)
                  ElevatedButton(
                    onPressed: () {
                      HapticFeedback.vibrate();
                      startGame();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal.shade600,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          // Game grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: GestureDetector(
                    onVerticalDragUpdate: (details) {
                      if (direction != 'up' && details.delta.dy > 0) {
                        direction = 'down';
                      } else if (direction != 'down' && details.delta.dy < 0) {
                        direction = 'up';
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      if (direction != 'left' && details.delta.dx > 0) {
                        direction = 'right';
                      } else if (direction != 'right' && details.delta.dx < 0) {
                        direction = 'left';
                      }
                    },
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: folderCount,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: squaresPerRow,
                      ),
                      itemBuilder: (context, index) {
                        if (snake.first == index) {
                          // Snake head
                          return Container(
                            margin: const EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade700,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          );
                        }
                        if (snake.contains(index)) {
                          // Snake body
                          return Container(
                            margin: const EdgeInsets.all(0.5),
                            decoration: BoxDecoration(
                              color: Colors.teal.shade400,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          );
                        }
                        if (index == food) {
                          return Container(
                            margin: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.orange.shade400,
                              shape: BoxShape.circle,
                            ),
                          );
                        }
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade100,
                              width: 0.5,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          // D-Pad Controls
          if (isPlaying)
            Padding(
              padding: const EdgeInsets.only(bottom: 16, top: 4),
              child: Column(
                children: [
                  _buildControlBtn(Icons.keyboard_arrow_up_rounded, 'up'),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlBtn(
                          Icons.keyboard_arrow_left_rounded, 'left'),
                      const SizedBox(width: 48),
                      _buildControlBtn(
                          Icons.keyboard_arrow_right_rounded, 'right'),
                    ],
                  ),
                  const SizedBox(height: 4),
                  _buildControlBtn(Icons.keyboard_arrow_down_rounded, 'down'),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildControlBtn(IconData icon, String moveDir) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      shadowColor: Colors.black12,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          HapticFeedback.vibrate();
          if (moveDir == 'up' && direction != 'down') direction = 'up';
          if (moveDir == 'down' && direction != 'up') direction = 'down';
          if (moveDir == 'left' && direction != 'right') direction = 'left';
          if (moveDir == 'right' && direction != 'left') direction = 'right';
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: Colors.grey.shade700, size: 28),
        ),
      ),
    );
  }
}
