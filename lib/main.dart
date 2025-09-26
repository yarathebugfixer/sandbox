import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sandbox/theme/app.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/types/chatbox_menu_item.dart';
import 'package:sandbox/util/ring_buffer.dart';
import 'package:sandbox/voice_capture_bloc.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/index.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => LiveAudioBloc(),
      child: MaterialApp(theme: AppTheme.light, home: Page()),
    ),
  );
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  PageController createState() => PageController();
}

class PageController extends State<Page> {
  final TextEditingController textController = TextEditingController();
  bool isComposerOpen = false;

  // Demo menu items
  late final List<ChatboxMenuItemButton> menuItems = [
    ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.photo_camera,
        label: 'Camera',
        onClick: () => debugPrint('📷 Camera tapped'),
        priority: 3,
      ),
    ),
    ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.photo,
        label: 'Gallery',
        onClick: () => debugPrint('🖼️ Gallery tapped'),
        priority: 2,
      ),
    ),
    ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.file_present,
        label: 'File',
        onClick: () => debugPrint('📎 File tapped'),
        priority: 1,
      ),
    ),
    ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.mic,
        label: 'Voice',
        onClick: () => debugPrint('🎤 Voice tapped'),
        priority: 2,
      ),
    ),
    ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.insert_chart,
        label: 'Stats',
        onClick: () => debugPrint('📊 Stats tapped'),
        priority: 0,
      ),
    ),
     ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.insert_chart,
        label: 'Stats',
        onClick: () => debugPrint('📊 Stats tapped'),
        priority: 0,
      ),
    ),
     ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.insert_chart,
        label: 'Stats',
        onClick: () => debugPrint('📊 Stats tapped'),
        priority: 0,
      ),
    ),
  ];

  void toggleComposer() {
    setState(() => isComposerOpen = !isComposerOpen);
  }

  @override
  Widget build(BuildContext context) => PageView(this);
}

class PageView extends StatelessWidget {
  final PageController state;
  PageView(this.state, {Key? key}) : super(key: key);
  final RingBuffer<double> buffer = RingBuffer<double>(length: 64);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (state.isComposerOpen) {
          // Close composer only if it’s open
          state.setState(() => state.isComposerOpen = false);
        }
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final layoutSize = width < Sizes.mobileBreakpoint
              ? LayoutSize.compact
              : LayoutSize.expanded;
          return BlocBuilder<LiveAudioBloc, LiveAudioBlocState>(
            builder: (context, audioState) {
              final audioBloc = context.read<LiveAudioBloc>();
              return Scaffold(
                floatingActionButton: layoutSize == LayoutSize.compact
                    ? SizedBox(
                        height: Sizes.chatBoxMaxHeight,
                        width: MediaQuery.of(context).size.width,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 100),
                              transitionBuilder: (child, animation) {
                                final offsetAnimation = Tween<Offset>(
                                  begin: const Offset(-1.0, 0),
                                  end: Offset(-0.13, 0),
                                ).animate(animation);
                                return SlideTransition(
                                  position: offsetAnimation,
                                  child: FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  ),
                                );
                              },
                              child: state.isComposerOpen
                                  ? SizedBox(
                                      key: const ValueKey('chatbox'),
                                      width: MediaQuery.of(context).size.width,
                                      height: Sizes.chatBoxMaxHeight,
                                      child: Chatbox(
                                        menuItems: state.menuItems,
                                        onText: (String text) {},
                                        controller: state.textController,
                                        isComposerOpen: state.isComposerOpen,
                                        layoutSize: layoutSize,
                                        liveAudioState: audioState.state,
                                        openComposer: state.toggleComposer,
                                        voiceCaptureStream:
                                            audioBloc.amplitudeStream ??
                                            const Stream.empty(),
                                        voiceCaptureBuffer: buffer,
                                        actionButtons: [
                                          ...state.menuItems.where(
                                            (item) =>
                                                item.chatboxMenuItem.priority >=
                                                1,
                                          ),
                                        ].take(2).toList(),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                            SizedBox(width: Sizes.composerButtonSize),
                            // Always visible FAB
                            ComposerButton(
                              onVoice: () {},
                              isComposerOpen: state.isComposerOpen,
                              openComposer: state.toggleComposer,
                              controller: state.textController,
                              layoutSize: layoutSize,
                              liveAudioState: audioState.state,
                            ),
                          ],
                        ),
                      )
                    : null,

                bottomNavigationBar: layoutSize != LayoutSize.compact
                    ? Padding(
                        padding: EdgeInsets.only(bottom: Gaps.def.lg),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Chatbox(
                              onText: (String text) {},
                              controller: state.textController,
                              isComposerOpen: true,
                              menuItems: state.menuItems,
                              layoutSize: layoutSize,
                              liveAudioState: audioState.state,
                              openComposer: state.toggleComposer,
                              voiceCaptureStream:
                                  audioBloc.amplitudeStream ??
                                  const Stream.empty(),
                              voiceCaptureBuffer: buffer,
                              actionButtons: [
                                ...state.menuItems.where(
                                  (item) => item.chatboxMenuItem.priority >= 1,
                                ),
                              ].take(2).toList(),
                            ),
                            SizedBox(width: 5),
                            ComposerButton(
                              onVoice: () {},
                              isComposerOpen: state.isComposerOpen,
                              openComposer: state.toggleComposer,
                              controller: state.textController,
                              layoutSize: layoutSize,
                              liveAudioState: audioState.state,
                            ),
                          ],
                        ),
                      )
                    : null,
              );
            },
          );
        },
      ),
    );
  }
}
