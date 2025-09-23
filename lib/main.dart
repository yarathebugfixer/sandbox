import 'package:flutter/material.dart';
import 'package:sandbox/theme/app.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/extension.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/types/chatbox_menu_item.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox.dart';

class Page extends StatefulWidget {
  Page({Key? key}) : super(key: key);

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
        icon: Icons.photo,
        label: 'Photo',
        onClick: () => debugPrint('📸 Photo tapped'),
        priority: 1,
      ),
    ),
    ChatboxMenuItemButton(
      chatboxMenuItem: ChatboxMenuItem(
        icon: Icons.file_present,
        label: 'File',
        onClick: () =>
            () => debugPrint('📎 File tapped'),
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final layoutSize = width < Sizes.mobileBreakpoint
            ? LayoutSize.compact
            : width < Sizes.tabletBreakpoint
            ? LayoutSize.medium
            : LayoutSize.expanded;

        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(title: Text('Chatbox Sandbox')),
          bottomNavigationBar: Padding(
            padding: layoutSize == LayoutSize.expanded
                ? EdgeInsetsGeometry.all(Gaps.def.sm)
                : EdgeInsetsGeometry.zero,
            child: Chatbox(
              controller: state.textController,
              isComposerOpen: state.isComposerOpen,
              layoutSize: layoutSize,
              menuItems: state.menuItems,
              openComposer: state.toggleComposer,
              actionButtons: [
                IconButton(
                  icon: Icon(Icons.attach_file),
                  onPressed: () {
                    print('Attach tapped');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.emoji_emotions),
                  onPressed: () {
                    print('Emoji tapped');
                  },
                ),
              ],
              keyboardVisible: true,
            ),
          ),
          body: Center(child: Text('Place any content here')),
        );
      },
    );
  }
}

void main() => runApp(MaterialApp(home: Page(), theme: AppTheme.light));
