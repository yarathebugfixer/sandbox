import 'package:sandbox/theme/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/voice_capture_bloc.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/text_composer.dart';
import 'package:sandbox/widgets/organisms/chatbox/voice_capture_container.dart';

class Chatbox extends StatelessWidget {
  Chatbox({
    super.key,
    this.placeholder,
    required this.onText,
    required this.controller,
    this.disabled = false,
    required this.layoutSize,
    required this.actionButtons,
    required this.isComposerOpen,
    required this.openComposer,
    required this.liveAudioState,
    required this.voiceCaptureStream,
    required this.voiceCaptureBuffer,
    required this.menuItems,
  });

  final String? placeholder;
  final ValueChanged<String> onText;
  final TextEditingController controller;
  final bool disabled;
  final bool isComposerOpen;
  final LayoutSize layoutSize;
  final LiveAudioState liveAudioState;
  final List<ChatboxMenuItemButton> actionButtons;
  final void Function() openComposer;
  final Stream<double> voiceCaptureStream;
  final RingBuffer<double> voiceCaptureBuffer;
  final List<ChatboxMenuItemButton> menuItems;
  @override
  Widget build(BuildContext context) {
    final maxWidth = layoutSize == LayoutSize.compact
        ? Sizes.chatBoxMaxWidth
        : Sizes.expandedChatBoxMaxWidth;
    return SizedBox(
      width: maxWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 20),
            child: isComposerOpen
                ? ConstrainedBox(
                    key: const ValueKey('composer-area'),
                    constraints: BoxConstraints(
                      maxWidth: Sizes.expandedChatBoxMaxWidth,
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
        ],
      ),
    );
  }

  Widget _buildComposerChild(
    BuildContext context, {
    required TextEditingValue textValue,
  }) {
    final isMultiLine =
        textValue.text.length > Sizes.multiLineThreshHold ||
        textValue.text.contains('\n');
    if (liveAudioState == LiveAudioState.idle) {
      return TextComposer(
        menuItems: menuItems,
        onText: onText,
        isMultiLine: isMultiLine,
        controller: controller,
        actionButtons: actionButtons,
        disabled: disabled,
        layoutSize: layoutSize,
      );
    }

    return VoiceCaptureContainer(
      layoutSize: layoutSize,
      liveAudioState: liveAudioState,
      voiceCaptureStream: voiceCaptureStream,
      voiceCaptureBuffer: voiceCaptureBuffer,
    );
  }
}
