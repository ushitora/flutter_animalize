import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/animal/animal_model.dart';
import 'package:growing_cell/utils/exception.dart';
import 'package:growing_cell/utils/utils.dart';

class BoardModel {
  final int W;
  final int H;
  final List<List<Agent?>> tiles;

  const BoardModel(this.W, this.H, this.tiles);

  factory BoardModel.from(int w, int h) {
    List<List<Agent?>> tiles = [
      for (int i in range(h))
        [
          for (int j in range(w)) null,
        ]
    ];
    return BoardModel(w, h, tiles);
  }

  int get numStone {
    int cnt = 0;
    for (int i in range(H)) {
      for (int j in range(W)) {
        if (tiles[i][j] != null) {
          cnt += 1;
        }
      }
    }
    return cnt;
  }

  bool _isValidPoint((int, int) point) {
    var (i, j) = point;
    return 0 <= i && i < H && 0 <= j && j < W;
  }

  void putStone(Agent player, (int, int) point) {
    var (i, j) = point;
    if (!_isValidPoint(point)) throw InvalidPointException(this, point);
    if (tiles[i][j] != null) throw StoneAlreadyExistsException(this, point);
    tiles[i][j] = player;
  }

  bool checkAnimalExists(Agent agent, AnimalModel animal) {
    for (var shape in animal.allShapes) {
      for (int ri in range(H - shape.H)) {
        for (int rj in range(W - shape.W)) {
          bool equiv = true;
          for (var (i, j) in shape.points) {
            if (tiles[ri + i][rj + j] != agent) {
              equiv = false;
              break;
            }
          }
          if (equiv) {
            return true;
          }
        }
      }
    }
    return false;
  }
}
