import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdjusterView extends ConsumerWidget {
  static const textStyle = TextStyle(fontSize: 20, color: Colors.black54);
  static const numberStyle = TextStyle(fontSize: 24, color: Colors.black87);
  static const numberWidth = 40.0;
  static const adjusterWidth = 120.0;

  final String label;
  final int value;
  final void Function() onMinusButtonPressed;
  final void Function() onPlusButtonPressed;

  const AdjusterView({
    super.key,
    required this.label,
    required this.value,
    required this.onMinusButtonPressed,
    required this.onPlusButtonPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(label, style: textStyle),
      trailing: SizedBox(
        width: adjusterWidth,
        child: Row(
          children: [
            IconButton(
              onPressed: onMinusButtonPressed,
              icon: const Icon(Icons.remove),
            ),
            SizedBox(
              width: numberWidth,
              child: Center(
                child: Text("$value", style: numberStyle),
              ),
            ),
            IconButton(
              onPressed: onPlusButtonPressed,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
