import 'dart:ui';

import 'package:flutter/material.dart';

class WavePainter extends CustomPainter {
  final List<double> currentWaves;
  final BuildContext context;
  WavePainter(this.currentWaves, this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final theme = Theme.of(context);
    print(currentWaves);
    final paint = Paint()
      ..color = theme.colorScheme.primary
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final barWidth = size.width / currentWaves.length;

    for (int i = 0; i < currentWaves.length; i++) {
      final x = i * barWidth;
      final y = currentWaves[i] * size.height; // normalized 0..1
      canvas.drawLine(
        Offset(x, size.height / 2 - y / 2),
        Offset(x, size.height / 2 + y / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) {
    return oldDelegate.currentWaves != currentWaves;
  }
}
