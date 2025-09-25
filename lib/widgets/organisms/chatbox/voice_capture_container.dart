import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/voice_capture_bloc.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/action_box.dart';
import 'package:sandbox/widgets/organisms/chatbox/menu_trigger.dart';
import 'package:sandbox/widgets/organisms/chatbox/waveform_container.dart';

class VoiceCaptureContainer extends StatelessWidget {
  const VoiceCaptureContainer({
    super.key,
    required this.isMultiLine,
    required this.layoutSize,
    required this.liveAudioState,
    required this.menuItems,
    required this.actionButtons,
    required this.voiceCaptureStream,
    required this.voiceCaptureBuffer,
  });

  final bool isMultiLine;
  final LayoutSize layoutSize;
  final LiveAudioState liveAudioState;
  final List<ChatboxMenuItemButton> menuItems;
  final List<IconButton> actionButtons;
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
            label: "Pause audio recording",
            child: IconButton(
              onPressed: () =>
                  context.read<LiveAudioBloc>().add(PauseRecording()),
              icon: const Icon(Icons.pause),
            ),
          ),

          Semantics(
            label: "Cancel audio recording",
            child: IconButton(
              onPressed: () =>
                  context.read<LiveAudioBloc>().add(CancelRecording()),
              icon: const Icon(Icons.close),
            ),
          ),
          if (isMultiLine)
            ActionsBox(
              actionButtons: [...actionButtons],
              menuTrigger: MenuTrigger(
                menuItems: menuItems,
                layoutSize: layoutSize,
              ),
            ),
        ],
      ),
    );
  }
}
