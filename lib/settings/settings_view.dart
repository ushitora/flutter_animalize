import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/settings/settings_view_model.dart';

class SettingsView extends ConsumerWidget {
  static const titleStyle = TextStyle(fontSize: 25, color: Colors.black54);
  static const divider = Divider(thickness: 2, color: Colors.black12);

  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lineWidth = ref.watch(settingsProvider).lineWidth;
    final borderRadius = ref.watch(settingsProvider).borderRadius;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Text("Line Width", style: titleStyle),
          SizedBox(
            height: 60,
            child: Slider(
                min: 0,
                max: 10,
                divisions: 10,
                value: lineWidth,
                label: lineWidth.round().toString(),
                onChanged: (value) {
                  ref
                      .read(settingsProvider)
                      .setLineWidth(value.roundToDouble());
                }),
          ),
          divider,
          const SizedBox(height: 10),
          const Text("Border Radius", style: titleStyle),
          SizedBox(
            height: 60,
            child: Slider(
                min: 0,
                max: 50,
                divisions: 10,
                value: borderRadius,
                label: borderRadius.toString(),
                onChanged: (value) {
                  ref.read(settingsProvider).setBorderRadius(value);
                }),
          ),
        ],
      ),
    );
  }
}
