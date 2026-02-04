import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:portfolio/core/theme/colors.dart';
import 'package:portfolio/core/theme/text_styles.dart';
import 'package:portfolio/feature/emulator/presentation/widget/main_app_bar.dart';

class TicTacToeScreen extends StatefulWidget {
  const TicTacToeScreen({super.key});

  @override
  State<TicTacToeScreen> createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  List<String> board = List.filled(9, '');
  String currentPlayer = 'X';
  String winner = '';
  bool isDraw = false;

  void handleTap(int index) {
    if (board[index].isEmpty && winner.isEmpty) {
      HapticFeedback.vibrate();
      setState(() {
        board[index] = currentPlayer;
        if (checkWinner()) {
          winner = currentPlayer;
        } else if (board.every((element) => element.isNotEmpty)) {
          isDraw = true;
        } else {
          currentPlayer = currentPlayer == 'X' ? 'O' : 'X';
        }
      });
    }
  }

  bool checkWinner() {
    // Rows
    if (board[0] == currentPlayer &&
        board[1] == currentPlayer &&
        board[2] == currentPlayer) return true;
    if (board[3] == currentPlayer &&
        board[4] == currentPlayer &&
        board[5] == currentPlayer) return true;
    if (board[6] == currentPlayer &&
        board[7] == currentPlayer &&
        board[8] == currentPlayer) return true;
    // Columns
    if (board[0] == currentPlayer &&
        board[3] == currentPlayer &&
        board[6] == currentPlayer) return true;
    if (board[1] == currentPlayer &&
        board[4] == currentPlayer &&
        board[7] == currentPlayer) return true;
    if (board[2] == currentPlayer &&
        board[5] == currentPlayer &&
        board[8] == currentPlayer) return true;
    // Diagonals
    if (board[0] == currentPlayer &&
        board[4] == currentPlayer &&
        board[8] == currentPlayer) return true;
    if (board[2] == currentPlayer &&
        board[4] == currentPlayer &&
        board[6] == currentPlayer) return true;

    return false;
  }

  void resetGame() {
    HapticFeedback.vibrate();
    setState(() {
      board = List.filled(9, '');
      currentPlayer = 'X';
      winner = '';
      isDraw = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: "Tic Tac Toe",
        color: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            winner.isNotEmpty
                ? 'Winner: $winner'
                : isDraw
                    ? "It's a Draw!"
                    : 'Player: $currentPlayer',
            style: AppStyles.h5TextStyle.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return NeoPopButton(
                    color: Colors.indigo.shade50,
                    bottomShadowColor: Colors.indigo.shade100,
                    rightShadowColor: Colors.indigo.shade100,
                    depth: 4,
                    onTapUp: () => handleTap(index),
                    onTapDown: () => HapticFeedback.vibrate(),
                    child: Center(
                      child: Text(
                        board[index],
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: board[index] == 'X'
                              ? Colors.blue
                              : Colors.redAccent,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          NeoPopButton(
            color: Colors.indigo,
            bottomShadowColor: Colors.indigo.shade900,
            rightShadowColor: Colors.indigo.shade900,
            depth: 5,
            onTapUp: () => resetGame(),
            onTapDown: () => HapticFeedback.vibrate(),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text(
                'Reset Game',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
