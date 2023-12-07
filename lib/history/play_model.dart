import 'package:growing_cell/agent/agent_model.dart';

class PlayModel {
  final Agent player;
  final (int, int) point;

  const PlayModel(this.player, this.point);

  @override
  String toString() {
    var (i, j) = point;
    var char = String.fromCharCode(j + 65);
    return "$char${i + 1}";
  }
}
