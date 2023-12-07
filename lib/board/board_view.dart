import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/board/gadgets/tile_view.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/settings/settings_view_model.dart';
import 'package:growing_cell/utils/utils.dart';

class BoardView extends ConsumerWidget {
  static const lineColor = Colors.black87;
  static const indexStyle = TextStyle(fontSize: 30, color: Colors.black87);
  static const indexSize = 60.0;

  const BoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tileSize =
        ref.watch(settingsProvider.select((value) => value.tileSize));
    final lineWidth =
        ref.watch(settingsProvider.select((value) => value.lineWidth));
    final borderRadius =
        ref.watch(settingsProvider.select((value) => value.borderRadius));

    var board = ref.watch(gameProvider).model.board;

    double W = board.W * (tileSize + lineWidth) + lineWidth + 2 * indexSize;
    double H = board.H * (tileSize + lineWidth) + lineWidth + 2 * indexSize;
    var gadgets = <Widget>[];
    gadgets.add(Positioned(
      top: indexSize,
      left: indexSize,
      width: W - 2 * indexSize,
      height: H - 2 * indexSize,
      child: Container(color: lineColor),
    ));
    for (int i in range(board.H)) {
      gadgets.add(
        Positioned(
          top: i * (tileSize + lineWidth) + lineWidth + indexSize,
          left: 0,
          width: indexSize - 10,
          height: tileSize,
          child: Align(
            alignment: Alignment.centerRight,
            child: Text("${i + 1}", style: indexStyle),
          ),
        ),
      );
    }
    for (int j in range(board.W)) {
      var char = String.fromCharCode(j + 65);
      gadgets.add(
        Positioned(
          left: j * (tileSize + lineWidth) + lineWidth + indexSize,
          top: 0,
          height: indexSize,
          width: tileSize,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(char, style: indexStyle),
          ),
        ),
      );
    }
    for (int i in range(board.H)) {
      for (int j in range(board.W)) {
        gadgets.add(Positioned(
            top: i * (tileSize + lineWidth) + lineWidth + indexSize,
            left: j * (tileSize + lineWidth) + lineWidth + indexSize,
            width: tileSize,
            height: tileSize,
            child: Material(
              elevation: 10,
              child: TileView(
                borderRadius: borderRadius,
                owner: board.tiles[i][j],
                onTap: () {
                  ref.read(gameProvider).putStone((i, j));
                },
              ),
            )));
      }
    }
    return SizedBox(
      width: W,
      height: H,
      child: Material(
        elevation: 10,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: gadgets,
        ),
      ),
    );
  }
}
