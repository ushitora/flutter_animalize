Iterable<int> range(int startOrStop, [int? stop]) sync* {
  int l = stop == null ? 0 : startOrStop;
  int r = stop == null ? startOrStop : stop;
  for (int i = l; i < r; i++) {
    yield i;
  }
}

Iterable<(int, T)> enumerate<T>(List<T> list) sync* {
  for (int i in range(list.length)) {
    yield (i, list[i]);
  }
}
