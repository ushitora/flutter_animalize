import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/animal/animal_model.dart';
import 'package:growing_cell/board/board_view.dart';
import 'package:growing_cell/board/gadgets/tile_view.dart';
import 'package:growing_cell/settings/settings_view_model.dart';
import 'package:growing_cell/utils/utils.dart';

class AnimalView extends ConsumerWidget {
  static const animalSize = 150.0;

  final AnimalModel model;
  final Agent player;

  const AnimalView(this.model, this.player, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius =
        ref.watch(settingsProvider.select((value) => value.borderRadius));

    final settings = ref.watch(settingsProvider);
    final ratio = settings.lineWidth / settings.tileSize;
    final num = 5; //max(model.W, model.H);
    final tileSize = animalSize / (num + num * ratio + ratio);
    final lineWidth = tileSize * ratio;

    var gadgets = <Widget>[];

    var tiles = <(int, int), Agent>{};
    var (oi, oj) = ((num - model.height) ~/ 2, (num - model.width) ~/ 2);
    for (var (i, j) in model.points) {
      tiles[(i + oi, j + oj)] = player;
    }
    for (int i in range(num)) {
      for (int j in range(num)) {
        gadgets.add(Positioned(
          top: i * (tileSize + lineWidth) + lineWidth,
          left: j * (tileSize + lineWidth) + lineWidth,
          width: tileSize,
          height: tileSize,
          child: TileView(borderRadius: borderRadius, owner: tiles[(i, j)]),
        ));
      }
    }

    return Container(
      width: animalSize,
      height: animalSize,
      color: BoardView.lineColor,
      child: Stack(children: gadgets),
    );
  }
}
