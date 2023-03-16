import 'package:flutter/material.dart';

class BouncingButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPress;

  const BouncingButton({super.key, required this.child, required this.onPress});

  @override
  State createState() => _BouncingButtonState();
}

class _BouncingButtonState extends State<BouncingButton>
    with SingleTickerProviderStateMixin {
  double _scale = 1;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    );
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
        widget.onPress();
      },
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}