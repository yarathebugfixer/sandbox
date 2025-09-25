import 'package:sandbox/theme/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/voice_capture_bloc.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/compact_view.dart';
import 'package:sandbox/widgets/organisms/chatbox/expanded_view.dart';

class Chatbox extends StatelessWidget {
  Chatbox({
    super.key,
    this.placeholder,
    this.onChange,
    required this.controller,
    this.disabled = false,
    required this.layoutSize,
    required this.menuItems,
    required this.actionButtons,
    required this.isComposerOpen,
    required this.openComposer,
    required this.liveAudioState,
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
  final void Function() openComposer;
  final Stream<double> voiceCaptureStream;
  final RingBuffer<double> voiceCaptureBuffer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: layoutSize == LayoutSize.compact
          ? CompactView(
              controller: controller,
              layoutSize: layoutSize,
              menuItems: menuItems,
              actionButtons: actionButtons,
              isComposerOpen: isComposerOpen,
              openComposer: openComposer,
              liveAudioState: liveAudioState,
              voiceCaptureStream: voiceCaptureStream,
              voiceCaptureBuffer: voiceCaptureBuffer,
              disabled: disabled,
            )
          : null,
      bottomNavigationBar: layoutSize != LayoutSize.compact
          ? ExpandedView(
              controller: controller,
              layoutSize: layoutSize,
              menuItems: menuItems,
              isComposerOpen: isComposerOpen,
              openComposer: openComposer,
              actionButtons: actionButtons,
              liveAudioState: liveAudioState,
              voiceCaptureStream: voiceCaptureStream,
              voiceCaptureBuffer: voiceCaptureBuffer,
              disabled: disabled,
            )
          : SizedBox.shrink(),
    );
  }
}
