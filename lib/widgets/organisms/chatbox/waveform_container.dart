import 'package:flutter/material.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/util/wave_painter.dart' show WavePainter;

class WaveformContainer extends StatelessWidget {
  final RingBuffer<double> buffer;
  final Stream<double> stream;
  final LayoutSize layoutSize;
  WaveformContainer({
    super.key,
    required this.buffer,
    required this.stream,
    required this.layoutSize,
  });

  @override
  Widget build(BuildContext context) {
    final maxSize = layoutSize == LayoutSize.compact
        ? Sizes.waveformWidth
        : Sizes.expandedWaveformMaxWidth;
    return StreamBuilder<double>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) buffer.push(snapshot.data!);
        return RepaintBoundary(
          child: CustomPaint(
            size: Size(maxSize, Sizes.waveformHeight),
            painter: WavePainter(buffer.snapshot(), context),
          ),
        );
      },
    );
  }
}
