import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HoverUnsaturate extends StatefulWidget {
  final Widget child;

  const HoverUnsaturate({super.key, required this.child});

  @override
  State<HoverUnsaturate> createState() => HoverUnsaturateState();
}

class HoverUnsaturateState extends State<HoverUnsaturate> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    debugPrint("building");
    return MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: widget.child
            .animate(target: _isHovering ? 1 : 0)
            .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2))
        // .saturate(),
        );
  }
}
