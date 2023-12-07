import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/animal/animal_view.dart';
import 'package:growing_cell/game/game_view_model.dart';

class AgentView extends ConsumerWidget {
  static const animalSize = 100.0;
  static const textStyle = TextStyle(fontSize: 20, color: Colors.black87);

  final Agent player;

  const AgentView(this.player, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool myTurn = ref.watch(gameProvider).model.currentPlayer == player;
    // bool win = ref.watch(gameProvider).winner == player;
    // final controller =
    //     win ? ConfettiController(duration: const Duration(seconds: 10)) : null;

    return Opacity(
      opacity: myTurn ? 1.0 : .4,
      child: Stack(
        children: [
          Column(
            children: [
              FittedBox(
                child: AnimalView(player.targetAnimal, player),
              ),
              Text(player.name, style: textStyle),
            ],
          ),
          // if (win)
          //   ConfettiWidget(
          //     confettiController: controller!,
          //   ),
        ],
      ),
    );
  }
}
