import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdjusterView extends ConsumerWidget {
  static const iconSize = 40.0;
  static const textStyle = TextStyle(fontSize: 40, color: Colors.black54);
  static const numberStyle =
      TextStyle(fontSize: iconSize * 1.2, color: Colors.black87);
  static const numberWidth = 40.0;
  static const adjusterWidth = 200.0;

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
    return Row(
      children: [
        Text(label, style: textStyle),
        const Spacer(),
        SizedBox(
          width: adjusterWidth,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: onMinusButtonPressed,
                icon: const Icon(Icons.remove, size: iconSize),
              ),
              SizedBox(
                width: numberWidth,
                child: Text(
                  "$value",
                  style: numberStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                onPressed: onPlusButtonPressed,
                icon: const Icon(Icons.add, size: iconSize),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
