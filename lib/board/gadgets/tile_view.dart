import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:growing_cell/agent/agent_model.dart';

class TileView extends ConsumerWidget {
  static final color = Colors.white.withOpacity(.9);

  final Agent? owner;
  final void Function()? onTap;
  final double borderRadius;

  const TileView(
      {super.key, this.owner, this.onTap, required this.borderRadius});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: color,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
          disabledBackgroundColor: owner?.color,
        ),
        onPressed: owner == null ? onTap : null,
        child: Container(),
      ),
    );
  }
}
