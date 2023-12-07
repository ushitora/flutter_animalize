import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/history/history_view.dart';
import 'package:growing_cell/history/play_model.dart';

class PlayView extends ConsumerWidget {
  static const radius = 12.0;
  static const scoreStyle = TextStyle(fontSize: 16, color: Colors.black);
  static const idxStyle = TextStyle(fontSize: 12, color: Colors.grey);
  final int idx;
  final PlayModel? model;

  const PlayView(this.idx, this.model, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int step = ref.watch(gameProvider.select((value) => value.model.numStep));
    Color? color;
    if (idx == lastSelectedState) {
      color = Colors.blueGrey[200];
    } else if (idx == step) {
      color = Colors.blueGrey[100];
    }
    return MouseRegion(
      onEnter: (event) {
        ref.read(gameProvider).loadHistory(idx);
      },
      onExit: (event) {
        ref.read(gameProvider).loadHistory(lastSelectedState);
      },
      child: ListTile(
        minVerticalPadding: 0,
        dense: true,
        tileColor: color,
        leading: Container(
          width: radius,
          height: radius,
          decoration: BoxDecoration(
            color: model?.player.color,
            shape: BoxShape.circle,
          ),
        ),
        trailing: Text("$idx", style: idxStyle),
        title: Text(model?.toString() ?? "init", style: scoreStyle),
        // visualDensity: VisualDensity(vertical: .1),
        onTap: () {
          ref.read(gameProvider).loadHistory(idx);
          lastSelectedState = idx;
        },
      ),
    );
  }
}
