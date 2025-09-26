import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/voice_capture_bloc.dart';
import 'package:sandbox/widgets/organisms/chatbox/waveform_container.dart';

class VoiceCaptureContainer extends StatelessWidget {
  const VoiceCaptureContainer({
    super.key,
    required this.layoutSize,
    required this.liveAudioState,
    required this.voiceCaptureStream,
    required this.voiceCaptureBuffer, 
  });

  final LayoutSize layoutSize;
  final LiveAudioState liveAudioState;
  final Stream<double> voiceCaptureStream;
  final RingBuffer<double> voiceCaptureBuffer;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: "Audio recording",
      child: Row(
        key: const ValueKey('waveform-row'),
        mainAxisSize: MainAxisSize.min,
        children: [
          WaveformContainer(
            buffer: voiceCaptureBuffer,
            stream: voiceCaptureStream,
            layoutSize: layoutSize,
          ),
          Semantics(
            label: "Cancel audio recording",
            child: IconButton(
              onPressed: () =>
                  context.read<LiveAudioBloc>().add(CancelRecording()),
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
