import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_view.dart';
import 'package:growing_cell/game/game_view_model.dart';

class InfoView extends ConsumerWidget {
  static const textStyle = TextStyle(fontSize: 40);

  const InfoView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider).model;
    final winner = ref.watch(gameProvider).winner;
    var scores = <Widget>[];
    for (var p in game.players) {
      scores
          .add(Padding(padding: const EdgeInsets.all(10), child: AgentView(p)));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...scores,
        if (winner != null) Text("${winner.name} win!", style: textStyle),
      ],
    );
  }
}
