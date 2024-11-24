import 'package:flutter/material.dart';

final class TransitionedBody extends StatefulWidget {
  final Widget? child;

  const TransitionedBody({this.child, super.key});

  @override
  State<TransitionedBody> createState() => _TransitionedBodyState();
}

class _TransitionedBodyState extends State<TransitionedBody>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
      child: widget.child,
    );
  }
}
