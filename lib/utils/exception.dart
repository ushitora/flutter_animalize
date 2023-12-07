import 'package:growing_cell/board/board_model.dart';

class InvalidPointException implements Exception {
  final BoardModel board;
  final (int, int) point;
  const InvalidPointException(this.board, this.point);

  @override
  String toString() {
    return "InvalidPointException: $point is not a valid coordinate in $board";
  }
}

class StoneAlreadyExistsException implements Exception {
  final BoardModel board;
  final (int, int) point;
  const StoneAlreadyExistsException(this.board, this.point);

  @override
  String toString() {
    return "StoneAlreadyExistsException: A stone already exists at $point in $board";
  }
}
