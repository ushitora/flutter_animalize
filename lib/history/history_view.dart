import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/game/game_view_model.dart';
import 'package:growing_cell/history/play_view.dart';

int lastSelectedState = 0;

class HistoryView extends ConsumerWidget {
  static const historyTextStyle = TextStyle(fontSize: 20);

  const HistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var history = [
      null,
      ...ref.watch(gameProvider).model.playHistory,
    ];
    return Column(children: [
      Material(
        elevation: 1,
        child: ListTile(
          horizontalTitleGap: 0,
          // tileColor: Colors.blueGrey[200],
          leading: IconButton(
            // color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => loadPrev(ref),
          ),
          trailing: IconButton(
            // color: Colors.white,
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => loadNext(ref),
          ),
          title: const Center(
            child: Text("History", style: historyTextStyle),
          ),
        ),
      ),
      Expanded(
        child: ListView.builder(
          itemCount: history.length,
          itemExtent: 30,
          itemBuilder: (ctx, idx) => PlayView(idx, history[idx]),
        ),
      ),
    ]);
  }

  void loadPrev(WidgetRef ref) {
    lastSelectedState = max(0, lastSelectedState - 1);
    ref.read(gameProvider).loadHistory(lastSelectedState);
  }

  void loadNext(WidgetRef ref) {
    int latest = ref.read(gameProvider).model.playHistory.length;
    lastSelectedState = min(latest, lastSelectedState + 1);
    ref.read(gameProvider).loadHistory(lastSelectedState);
  }
}
