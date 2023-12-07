import 'package:flutter/material.dart';
import 'package:growing_cell/board/board_view.dart';
import 'package:growing_cell/game/info_view.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 3,
          child: FittedBox(child: BoardView()),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: FittedBox(child: InfoView()),
          ),
        ),
      ],
    );
  }
}
