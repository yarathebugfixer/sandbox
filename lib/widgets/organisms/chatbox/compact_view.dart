import 'package:flutter/material.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/voice_capture_bloc.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/index.dart';
import 'package:sandbox/widgets/organisms/chatbox/voice_capture_container.dart';

class CompactView extends StatelessWidget {
  const CompactView({
    super.key,
    this.placeholder,
    this.onChange,
    required this.controller,
    required this.disabled,
    required this.isComposerOpen,
    required this.layoutSize,
    required this.liveAudioState,
    required this.menuItems,
    required this.actionButtons,
    required this.openComposer,
    required this.voiceCaptureStream,
    required this.voiceCaptureBuffer,
  });

  final String? placeholder;
  final ValueChanged<String>? onChange;
  final TextEditingController controller;
  final bool disabled;
  final bool isComposerOpen;
  final LayoutSize layoutSize;
  final LiveAudioState liveAudioState;
  final List<ChatboxMenuItemButton> menuItems;
  final List<IconButton> actionButtons;
  final VoidCallback openComposer;
  final Stream<double> voiceCaptureStream;
  final RingBuffer<double> voiceCaptureBuffer;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: Sizes.chatBoxMaxWidth),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isComposerOpen
                ? ConstrainedBox(
                    key: const ValueKey('composer-area'),
                    constraints: BoxConstraints(
                      maxWidth: Sizes.inputMaxWidth,
                      maxHeight: Sizes.chatBoxMaxHeight,
                    ),
                    child: ValueListenableBuilder<TextEditingValue>(
                      valueListenable: controller,
                      builder: (_, value, __) =>
                          _buildComposerChild(context, textValue: value),
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          ComposerButton(
            isComposerOpen: isComposerOpen,
            openComposer: openComposer,
            controller: controller,
            layoutSize: layoutSize,
            liveAudioState: liveAudioState,
          ),
        ],
      ),
    );
  }

  Widget _buildComposerChild(
    BuildContext context, {
    required TextEditingValue textValue,
  }) {
    final isMultiLine =
        textValue.text.length > Sizes.compactMultiLineThreshHold ||
        textValue.text.contains('\n');

    if (liveAudioState == LiveAudioState.idle) {
      return TextComposer(
        controller: controller,
        actionButtons: actionButtons,
        disabled: disabled,
        layoutSize: layoutSize,
        menuItems: menuItems,
      );
    }

     return VoiceCaptureContainer(
      isMultiLine: isMultiLine,
      layoutSize: layoutSize,
      liveAudioState: liveAudioState,
      menuItems: menuItems,
      actionButtons: actionButtons,
      voiceCaptureStream: voiceCaptureStream,
      voiceCaptureBuffer: voiceCaptureBuffer,
    );
  }
}
