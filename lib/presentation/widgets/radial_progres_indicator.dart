import 'package:flutter/material.dart';

class RadialProgressIndicator extends StatelessWidget {
  const RadialProgressIndicator(
      {super.key, this.strokeWidth = 3, this.size = 80, required this.value});

  final double value;
  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
