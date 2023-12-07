import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/animal/animal_model.dart';
import 'package:growing_cell/animal/animal_view.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/launcher/adjuster_view.dart';

class ZooView extends ConsumerWidget {
  static const animalSize = 225.0;

  final int playerId;

  const ZooView(this.playerId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var player = ref.watch(gameProvider).model.players[playerId];

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${player.name}'s target", style: AdjusterView.textStyle),
        Listener(
          onPointerSignal: (signal) {
            if (signal is PointerScrollEvent) {
              double dy = signal.scrollDelta.dy;
              if (dy > 1) {
                setNextAnimal(ref, player);
              }
              if (dy < -1) {
                setPrevAnimal(ref, player);
              }
            }
          },
          child: DropdownButton(
            itemHeight: animalSize,
            value: player.targetAnimal,
            items: items,
            onChanged: (animal) {
              if (animal != null) {
                ref.read(gameProvider).setTargetAnimal(animal, player);
              }
            },
          ),
        ),
      ],
    );
  }

  void setNextAnimal(WidgetRef ref, Agent player) {
    int idx = AnimalModel.primaries.indexOf(player.targetAnimal);
    if (idx == -1) return;
    idx = min(idx + 1, AnimalModel.primaries.length - 1);
    var animal = AnimalModel.primaries[idx];
    ref.read(gameProvider).setTargetAnimal(animal, player);
  }

  void setPrevAnimal(WidgetRef ref, Agent player) {
    int idx = AnimalModel.primaries.indexOf(player.targetAnimal);
    if (idx == -1) return;
    idx = max(idx - 1, 0);
    var animal = AnimalModel.primaries[idx];
    ref.read(gameProvider).setTargetAnimal(animal, player);
  }
}
