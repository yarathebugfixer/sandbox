import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/voice_capture_bloc.dart';

class ComposerButton extends StatelessWidget {
  final bool isComposerOpen;
  final void Function() openComposer;
  final TextEditingController controller;
  final LayoutSize layoutSize;
  final LiveAudioState liveAudioState;

  ComposerButton({
    required this.isComposerOpen,
    required this.openComposer,
    required this.controller,
    required this.layoutSize,
    required this.liveAudioState,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    void onSubmit(String text) {}

    void onVoiceCapture(BuildContext context) {
      context.read<LiveAudioBloc>().add(StartRecording());
    }

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, v, __) {
        final hasText = v.text.isNotEmpty;
        IconData chooseIcon() {
          if (layoutSize == LayoutSize.compact && !isComposerOpen) {
            return Icons.add;
          } else {
            if (hasText || liveAudioState == LiveAudioState.readyToSend) {
              return Icons.arrow_upward;
            }
            return Icons.graphic_eq;
          }
        }

        return Semantics(
          label: "Listening....",
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: Gaps.def.xxs),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 150),
              child: Material(
                key: ValueKey(hasText),
                color: theme.colorScheme.primary,
                shape: CircleBorder(),
                child: IconButton(
                  icon: Icon(chooseIcon(), color: theme.colorScheme.onPrimary),
                  onPressed: () {
                    if (layoutSize == LayoutSize.compact && !isComposerOpen) {
                      HapticFeedback.selectionClick();
                      openComposer();
                    } else if (hasText) {
                      HapticFeedback.lightImpact();
                      onSubmit(controller.text);
                      controller.clear();
                    } else {
                      HapticFeedback.mediumImpact();
                      onVoiceCapture(context);
                    }
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
