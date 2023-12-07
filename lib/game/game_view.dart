import 'package:flutter/material.dart';
import 'package:growing_cell/board/board_view.dart';
import 'package:growing_cell/game/info_view.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: FittedBox(child: BoardView())),
        Padding(
          padding: EdgeInsets.all(30),
          child: SizedBox(
            width: 300,
            child: FittedBox(child: InfoView()),
          ),
        ),
      ],
    );
  }
}
