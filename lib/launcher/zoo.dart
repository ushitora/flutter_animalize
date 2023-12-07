import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/animal/animal_model.dart';
import 'package:growing_cell/animal/animal_view.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/launcher/adjuster_view.dart';

class ZooView extends ConsumerWidget {
  static const animalSize = 200.0;

  final Agent player;

  const ZooView(this.player, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(gameProvider);

    var items = [
      for (var animal in AnimalModel.primaries)
        DropdownMenuItem(
          value: animal,
          child: Container(
            width: animalSize,
            height: animalSize,
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: AnimalView(animal, player),
            ),
          ),
        )
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("${player.name}'s target", style: AdjusterView.textStyle),
          DropdownButton(
            itemHeight: animalSize,
            value: player.targetAnimal,
            items: items,
            onChanged: (animal) {
              if (animal != null) {
                ref.read(gameProvider).setTargetAnimal(animal, player);
              }
            },
          ),
        ],
      ),
    );
  }
}
