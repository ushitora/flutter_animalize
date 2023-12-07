import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/board/board_view.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/home/home_view.dart';
import 'package:growing_cell/launcher/adjuster_view.dart';
import 'package:growing_cell/launcher/zoo.dart';

class LauncherView extends ConsumerWidget {
  static const iconSize = 60.0;
  static const borderWidth = 10.0;
  static const iconBgColor = Colors.blueGrey;
  static final iconFgColor = Colors.blueGrey[50]!;

  const LauncherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var game = ref.watch(gameProvider).model;
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Container(
            padding: const EdgeInsets.all(100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Padding(
                        padding:
                            const EdgeInsets.all(iconSize - borderWidth / 2),
                        child: Container(
                          width: 1000,
                          height: 1000,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: iconBgColor.shade200,
                            width: borderWidth,
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
                SizedBox(
                  width: 850,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AdjusterView(
                          label: "Board Size",
                          value: game.board.W,
                          onMinusButtonPressed: () => decreaseBoardSize(ref),
                          onPlusButtonPressed: () => increaseBoardSize(ref),
                        ),
                        const Divider(thickness: 3),
                        Row(
                          children: [
                            for (var player in game.players) ZooView(player),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
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
