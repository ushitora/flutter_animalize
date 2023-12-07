import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_model.dart';
import 'package:growing_cell/animal/animal_model.dart';
import 'package:growing_cell/board/board_model.dart';
import 'package:growing_cell/game/game_model.dart';

final gameProvider = ChangeNotifierProvider((ref) => GameViewModel());

class GameViewModel extends ChangeNotifier {
  GameModel model = _initModel;
  Agent? winner;

  GameViewModel();

  void putStone((int, int) point) {
    if (winner != null) {
      return;
    }
    try {
      model.play(point, changeHistory: true);
      winner = model.winner();
      if (winner != null) {
        model.currentPlayer = winner!;
      }
      notifyListeners();
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());
    }
  }

  void loadHistory(int historyIdx) {
    model = model.load(historyIdx, changeHistory: false);
    winner = model.winner();
    notifyListeners();
  }

  void setBoardSize(int w, int h) {
    var newBoard = BoardModel.from(w, h);
    var newModel = GameModel.from(model.players, newBoard);
    winner = null;
    model = newModel;
    notifyListeners();
  }

  void setTargetAnimal(AnimalModel animal, Agent player) {
    int idx = model.players.indexOf(player);
    var players = [...model.players];
    players[idx] = Agent(animal, players[idx].name, players[idx].color);
    var newModel =
        GameModel.from(players, BoardModel.from(model.board.W, model.board.H));
    model = newModel;
    winner = null;
    notifyListeners();
  }
}

GameModel get _initModel {
  var players = [
    Agent(AnimalModel.tic, "Player1", Agent.colors[0]),
    Agent(AnimalModel.tic, "Player2", Agent.colors[1]),
  ];
  var board = BoardModel.from(5, 5);
  return GameModel.from(players, board);
}
