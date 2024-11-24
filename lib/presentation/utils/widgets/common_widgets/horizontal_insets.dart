import 'package:flutter/material.dart';

final class HorizontalInsets extends StatelessWidget {
  final Widget child;

  const HorizontalInsets({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
