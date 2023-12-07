import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/board/board_view.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/home/home_view.dart';
import 'package:growing_cell/launcher/adjuster_view.dart';
import 'package:growing_cell/launcher/zoo.dart';

class LauncherView extends ConsumerWidget {
  static const iconSize = 40.0;
  static const iconBgColor = Colors.blueGrey;
  static final iconFgColor = Colors.blueGrey[50]!;

  const LauncherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var game = ref.watch(gameProvider).model;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(100),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.all(iconSize),
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: iconBgColor.shade200,
                        width: 5,
                      )),
                      child: const FittedBox(
                        child: BoardView(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: iconBgColor,
                    radius: iconSize,
                    child: IconButton(
                      tooltip: "start game",
                      icon: FittedBox(
                          child: Icon(Icons.fullscreen,
                              size: iconSize, color: iconFgColor)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => const HomeView()));
                      },
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AdjusterView(
                      label: "Board Size",
                      value: game.board.W,
                      onMinusButtonPressed: () => decreaseBoardSize(ref),
                      onPlusButtonPressed: () => increaseBoardSize(ref),
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          for (var player in game.players) ZooView(player),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void increaseBoardSize(WidgetRef ref) {
    var board = ref.read(gameProvider).model.board;
    ref
        .read(gameProvider)
        .setBoardSize(min(board.W + 1, 26), min(board.H + 1, 26));
  }

  void decreaseBoardSize(WidgetRef ref) {
    var board = ref.read(gameProvider).model.board;
    ref
        .read(gameProvider)
        .setBoardSize(max(3, board.W - 1), max(3, board.H - 1));
  }
}
