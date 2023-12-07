import 'dart:math';

import 'package:growing_cell/utils/utils.dart';

class AnimalModel {
  final List<(int, int)> points;
  final int height;
  final int width;

  const AnimalModel._(this.points, this.height, this.width);

  factory AnimalModel(List<(int, int)> points) {
    var I = [for (var (i, j) in points) i];
    var J = [for (var (i, j) in points) j];
    int iMin = I.reduce((value, element) => min(value, element));
    int iMax = I.reduce((value, element) => max(value, element));
    int jMin = J.reduce((value, element) => min(value, element));
    int jMax = J.reduce((value, element) => max(value, element));
    var offset = [
      for (var (i, j) in points) (i - iMin, j - jMin),
    ];
    return AnimalModel._(offset, iMax - iMin + 1, jMax - jMin + 1);
  }

  /// 1-cell
  static AnimalModel elam = AnimalModel([(0, 0)]);

  /// 2-cell
  static AnimalModel domino = AnimalModel([(0, 0), (0, 1)]);

  /// 3-cell
  static AnimalModel tic = AnimalModel([(0, 0), (0, 1), (0, 2)]);
  static AnimalModel el = AnimalModel([(0, 0), (0, 1), (1, 0)]);

  /// 4-cell
  static AnimalModel skinny = AnimalModel([(0, 0), (0, 1), (0, 2), (0, 3)]);
  static AnimalModel knobby = AnimalModel([(1, 0), (1, 1), (1, 2), (0, 1)]);
  static AnimalModel elly = AnimalModel([(1, 0), (1, 1), (1, 2), (0, 2)]);
  static AnimalModel tippy = AnimalModel([(0, 0), (0, 1), (1, 1), (1, 2)]);
  static AnimalModel fatty = AnimalModel([(0, 0), (0, 1), (1, 0), (1, 1)]);

  /// 5-cell
  static AnimalModel I = AnimalModel([(0, 0), (0, 1), (0, 2), (0, 3), (0, 4)]);
  static AnimalModel L = AnimalModel([(1, 0), (1, 1), (1, 2), (1, 3), (0, 3)]);
  static AnimalModel Y = AnimalModel([(1, 0), (1, 1), (1, 2), (1, 3), (0, 2)]);
  static AnimalModel Z = AnimalModel([(0, 0), (0, 1), (1, 1), (1, 2), (1, 3)]);
  static AnimalModel S = AnimalModel([(0, 0), (0, 1), (1, 1), (2, 1), (2, 2)]);
  static AnimalModel T = AnimalModel([(0, 0), (0, 1), (0, 2), (1, 1), (2, 1)]);
  static AnimalModel R = AnimalModel([(1, 0), (0, 1), (1, 1), (2, 1), (0, 2)]);
  static AnimalModel V = AnimalModel([(0, 0), (1, 0), (2, 0), (2, 1), (2, 2)]);
  static AnimalModel W = AnimalModel([(0, 0), (1, 0), (1, 1), (2, 1), (2, 2)]);
  static AnimalModel P = AnimalModel([(0, 0), (0, 1), (1, 0), (1, 1), (1, 2)]);
  static AnimalModel X = AnimalModel([(0, 1), (1, 0), (1, 1), (1, 2), (2, 1)]);
  static AnimalModel U = AnimalModel([(0, 0), (0, 2), (1, 0), (1, 1), (1, 2)]);

  static List<AnimalModel> primaries = [
    elam,
    domino,
    tic,
    el,
    skinny,
    knobby,
    elly,
    tippy,
    fatty,
    I,
    L,
    Y,
    Z,
    S,
    T,
    R,
    V,
    W,
    P,
    X,
    U,
  ];

  AnimalModel get rotate90 {
    var newPoints = [for (var (i, j) in points) (j, -i)];
    return AnimalModel(newPoints);
  }

  AnimalModel get flip {
    var newPoints = [for (var (i, j) in points) (i, -j)];
    return AnimalModel(newPoints);
  }

  Iterable<AnimalModel> get allShapes sync* {
    var model = clone();
    for (int i in range(2)) {
      for (int j in range(4)) {
        yield model;
        model = model.rotate90;
      }
      model = model.flip;
    }
  }

  AnimalModel clone() {
    return AnimalModel._([...points], height, width);
  }

  @override
  String toString() {
    var set = points.toSet();
    var lines = <String>[""];
    for (int i in range(height)) {
      var line = "";
      for (int j in range(width)) {
        line += set.contains((i, j)) ? "□" : " ";
      }
      lines.add(line);
    }
    return lines.join("\n");
  }
}
