import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/core/constants/globals.dart';
import 'package:portfolio/feature/emulator/presentation/widget/clean_app_bar.dart';

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

  @override
  void initState() {
    Globals.isBackDisabled = false;
    super.initState();
  }

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
      backgroundColor: Colors.grey.shade50,
      appBar: const CleanAppBar(
        title: 'Tic Tac Toe',
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Status
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: winner.isNotEmpty
                  ? Colors.teal.shade50
                  : isDraw
                      ? Colors.orange.shade50
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              winner.isNotEmpty
                  ? '🎉  Player $winner wins!'
                  : isDraw
                      ? "It's a draw!"
                      : "Player $currentPlayer's turn",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: winner.isNotEmpty
                    ? Colors.teal.shade700
                    : isDraw
                        ? Colors.orange.shade700
                        : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          // Board
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AspectRatio(
              aspectRatio: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return Material(
                      color: board[index].isEmpty
                          ? Colors.grey.shade50
                          : board[index] == 'X'
                              ? Colors.indigo.shade50
                              : Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => handleTap(index),
                        child: Center(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              board[index],
                              key: ValueKey('$index-${board[index]}'),
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: board[index] == 'X'
                                    ? Colors.indigo.shade600
                                    : Colors.pink.shade400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          // Reset button
          ElevatedButton.icon(
            onPressed: resetGame,
            icon: const Icon(Icons.refresh_rounded, size: 20),
            label: const Text(
              'Reset Game',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo.shade600,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Globals.isBackDisabled = true;
    super.dispose();
  }
}
