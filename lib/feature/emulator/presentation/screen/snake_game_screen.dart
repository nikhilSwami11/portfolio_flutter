import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/widget/main_app_bar.dart';

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
    // Check if snake collides with itself
    // Simple check: duplicate items in list
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
          title: const Text('Game Over'),
          content: Text('Your Score: $score'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                startGame();
              },
              child: const Text('Play Again'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: MainAppBar(
        title: "Snake Game",
        color: Colors.green.shade800,
      ),
      body: Column(
        children: [
          Expanded(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: squaresPerRow,
                ),
                itemBuilder: (context, index) {
                  if (snake.contains(index)) {
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }
                  if (index == food) {
                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    );
                  }
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.1), width: 0.5)),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Score: $score',
                  style: AppStyles.h6TextStyle.copyWith(color: AppColors.white),
                ),
                if (!isPlaying)
                  NeoPopButton(
                    color: Colors.white,
                    bottomShadowColor: Colors.green.shade900,
                    rightShadowColor: Colors.green.shade900,
                    animationDuration: const Duration(milliseconds: 200),
                    depth: 5,
                    onTapUp: () {
                      HapticFeedback.vibrate();
                      startGame();
                    },
                    onTapDown: () {
                      HapticFeedback.vibrate();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text("Start",
                          style: AppStyles.smTextBoldStyle
                              .copyWith(color: Colors.black)),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // D-Pad Controls for Interaction
          if (isPlaying)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  _buildControlBtn(Icons.arrow_upward, 'up'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildControlBtn(Icons.arrow_back, 'left'),
                      const SizedBox(width: 40),
                      _buildControlBtn(Icons.arrow_forward, 'right'),
                    ],
                  ),
                  _buildControlBtn(Icons.arrow_downward, 'down'),
                ],
              ),
            )
        ],
      ),
    );
  }

  Widget _buildControlBtn(IconData icon, String moveDir) {
    return NeoPopButton(
      color: Colors.white,
      bottomShadowColor: Colors.grey.shade800,
      rightShadowColor: Colors.grey.shade800,
      onTapUp: () {
        HapticFeedback.vibrate();
        if (moveDir == 'up' && direction != 'down') direction = 'up';
        if (moveDir == 'down' && direction != 'up') direction = 'down';
        if (moveDir == 'left' && direction != 'right') direction = 'left';
        if (moveDir == 'right' && direction != 'left') direction = 'right';
      },
      onTapDown: () => HapticFeedback.vibrate(),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Icon(icon, color: Colors.black),
      ),
    );
  }
}
