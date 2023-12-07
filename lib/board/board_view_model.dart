import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/board/board_model.dart';

final boardProvider = ChangeNotifierProvider((ref) => BoardViewModel());

class BoardViewModel extends ChangeNotifier {
  BoardModel board = BoardModel.from(3, 3);

  BoardViewModel();
}
