import 'package:flutter/material.dart';
import 'package:growing_cell/animal/animal_model.dart';
import 'package:growing_cell/utils/utils.dart';

class Agent {
  static final colors = [
    for (int i in range(Colors.primaries.length))
      Colors.primaries[(i * 5) % Colors.primaries.length]
  ];

  final AnimalModel targetAnimal;
  final String name;
  final Color color;

  Agent(this.targetAnimal, this.name, this.color);
}
