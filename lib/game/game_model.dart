import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/board/board_model.dart';
import 'package:growing_cell/history/history_view.dart';
import 'package:growing_cell/history/play_model.dart';
import 'package:growing_cell/utils/utils.dart';

class GameModel {
  final List<Agent> players;
  final BoardModel board;
  List<PlayModel> playHistory;
  Agent currentPlayer;

  int get numStep => board.numStone;

  GameModel(this.players, this.currentPlayer, this.board, this.playHistory);

  factory GameModel.from(List<Agent> players, BoardModel board) {
    return GameModel(players, players.first, board, []);
  }

  void play((int, int) point, {bool changeHistory = false}) {
    var player = currentPlayer;
    try {
      board.putStone(player, point);
      int idx = players.indexOf(player);
      currentPlayer = players[(idx + 1) % players.length];

      if (changeHistory) {
        if (board.numStone - 1 != playHistory.length) {
          playHistory.removeRange(board.numStone - 1, playHistory.length);
        }
        playHistory.add(PlayModel(player, point));
        lastSelectedState = playHistory.length;
      }
    } catch (e) {
      rethrow;
    }
  }

  Agent? winner() {
    for (var p in players) {
      if (board.checkAnimalExists(p, p.targetAnimal)) {
        return p;
      }
    }
    return null;
  }

  GameModel load(int historyIdx, {required bool changeHistory}) {
    var model = GameModel.from(players, BoardModel.from(board.W, board.H));
    for (int i in range(historyIdx)) {
      model.play(playHistory[i].point, changeHistory: changeHistory);
    }
    model.playHistory = playHistory;
    return model;
  }
}
