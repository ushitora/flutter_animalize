import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/game/game_view.dart';
import 'package:growing_cell/history/history_view.dart';
import 'package:growing_cell/home/home_view_model.dart';
import 'package:growing_cell/settings/settings_view.dart';
import 'package:split_view/split_view.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final idx = ref.watch(homeProvider).selectedIndex;
    const navigation = [
      (icon: Icons.history, label: "History", view: HistoryView()),
      (icon: Icons.settings, label: "Settings", view: SettingsView()),
    ];
    return Scaffold(
      // appBar: AppBar(title: const Text("Dot-And-Box")),
      body: Row(
        children: [
          NavigationRail(
              labelType: NavigationRailLabelType.all,
              elevation: 2,
              selectedIndex: idx,
              trailing: Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: IconButton(
                      tooltip: "go home",
                      icon: const Icon(Icons.home),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
              ),
              destinations: [
                for (var nav in navigation)
                  NavigationRailDestination(
                    icon: Icon(nav.icon),
                    label: Text(nav.label),
                  ),
              ],
              onDestinationSelected: (selectedIdx) {
                if (selectedIdx == idx) {
                  ref.read(homeProvider).selectedIndex = null;
                } else {
                  ref.read(homeProvider).selectedIndex = selectedIdx;
                }
              }),
          Expanded(
            child: SplitView(
              viewMode: SplitViewMode.Horizontal,
              controller:
                  SplitViewController(weights: idx == null ? null : [.2, .8]),
              children: [
                if (idx != null) navigation[idx].view,
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: GameView(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
