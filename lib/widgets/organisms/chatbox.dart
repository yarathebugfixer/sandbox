import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/theme/radius.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';

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
    required this.keyboardVisible,
  });

  final String? placeholder;
  final ValueChanged<String>? onChange;
  final TextEditingController controller;
  final bool disabled;
  final bool isComposerOpen;
  final bool? keyboardVisible;
  final LayoutSize layoutSize;
  final List<ChatboxMenuItemButton> menuItems;
  final List<IconButton> actionButtons;
  final void Function() openComposer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: layoutSize == LayoutSize.compact
          ? _CompactView(
              controller: controller,
              layoutSize: layoutSize,
              menuItems: menuItems,
              actionButtons: actionButtons,
              isComposerOpen: isComposerOpen,
              openComposer: openComposer,
              keyboardVisible: keyboardVisible,
            )
          : null,
      bottomNavigationBar: layoutSize != LayoutSize.compact
          ? _ExpandedView(
              controller: controller,
              layoutSize: layoutSize,
              menuItems: menuItems,
              isComposerOpen: isComposerOpen,
              openComposer: openComposer,
              actionButtons: actionButtons,
              keyboardVisible: keyboardVisible,
            )
          : SizedBox.shrink(),
    );
  }
}

class _CompactView extends Chatbox {
  _CompactView({
    required super.controller,
    required super.layoutSize,
    required super.menuItems,
    required super.actionButtons,
    required super.isComposerOpen,
    required super.openComposer,
    required super.keyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: AnimatedSlide(
        offset: keyboardVisible! ? Offset.zero : Offset(0, 1),
        duration: Duration(milliseconds: 600),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: Sizes.chatBoxMaxWidth,
            maxHeight: Sizes.chatBoxMaxHeight,
          ),
          child: isComposerOpen
              ? ValueListenableBuilder<TextEditingValue>(
                  valueListenable: controller,
                  builder: (_, value, __) {
                    final isMultiLine =
                        value.text.length > Sizes.compactMultiLineThreshHold ||
                        controller.text.contains('\n');
                    return Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextField(
                                  textInputAction: isMultiLine
                                      ? TextInputAction.newline
                                      : TextInputAction.send,
                                  maxLines: null,
                                  scrollPadding: EdgeInsets.only(
                                    bottom: Sizes.chatBoxScrollPadding,
                                  ), 
                                  controller: controller,
                                  onChanged: !disabled ? onChange : null,
                                  enabled: !disabled,
                                  decoration: InputDecoration(
                                    hintText: placeholder,
                                    prefixIcon: isMultiLine
                                        ? null
                                        : Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: Gaps.def.xxs,
                                            ),
                                            child: Icon(Icons.menu),
                                          ),
                                    suffixIcon: isMultiLine
                                        ? null
                                        : SizedBox(
                                            width: Sizes.trailingIconsBoxWidth,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: actionButtons,
                                            ),
                                          ),
                                    filled: true,
                                    fillColor:
                                        theme.inputDecorationTheme.fillColor,
                                    border: OutlineInputBorder(
                                      borderRadius: isMultiLine
                                          ? AppRadius.def.lg
                                          : AppRadius.def.pill,
                                      borderSide: BorderSide(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: isMultiLine
                                          ? AppRadius.def.lg
                                          : AppRadius.def.pill,
                                      borderSide: BorderSide(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: isMultiLine
                                          ? AppRadius.def.lg
                                          : AppRadius.def.pill,
                                      borderSide: BorderSide(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.all(Gaps.def.xs),
                                  ),
                                ),
                              ),
                              _ComposerButton(
                                isComposerOpen: isComposerOpen,
                                openComposer: openComposer,
                                controller: controller,
                                layoutSize: layoutSize,
                              ),
                            ],
                          ),
                          if (isMultiLine)
                            _ActionsWrap(
                              actionButtons: [...actionButtons],
                              menuTrigger: _MenuTrigger(menuItems: menuItems, layoutSize: layoutSize,),
                            )
                          else
                            SizedBox.shrink(),
                        ],
                      ),
                    );
                  },
                )
              : _ComposerButton(
                  isComposerOpen: isComposerOpen,
                  openComposer: openComposer,
                  controller: controller,
                  layoutSize: layoutSize,
                ),
        ),
      ),
    );
  }
}

class _ExpandedView extends Chatbox {
  _ExpandedView({
    required super.controller,
    required super.layoutSize,
    required super.menuItems,
    required super.actionButtons,
    required super.isComposerOpen,
    required super.openComposer,
    required super.keyboardVisible,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Sizes.chatBoxMaxWidth,
              maxHeight: Sizes.chatBoxMaxHeight,
            ),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: controller,
              builder: (_, value, __) {
                final isMultiLine =
                    value.text.length > Sizes.expandedMultiLineThreshHold ||
                    controller.text.contains('\n');
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: TextField(
                              textInputAction: isMultiLine
                                  ? TextInputAction.newline
                                  : TextInputAction.send,
                              maxLines: null,
                              scrollPadding: EdgeInsets.only(
                                bottom: Sizes.chatBoxScrollPadding,
                              ), 
                              controller: controller,
                              onChanged: !disabled ? onChange : null,
                              enabled: !disabled,
                              decoration: InputDecoration(
                                hintText: placeholder,
                                prefixIcon: isMultiLine
                                    ? null
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Gaps.def.xxs,
                                        ),
                                        child: Icon(Icons.menu),
                                      ),
                                suffixIcon: isMultiLine
                                    ? null
                                    : SizedBox(
                                        width: Sizes.trailingIconsBoxWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: actionButtons,
                                        ),
                                      ),
                                filled: true,
                                fillColor: theme.inputDecorationTheme.fillColor,
                                border: OutlineInputBorder(
                                  borderRadius: isMultiLine
                                      ? AppRadius.def.lg
                                      : AppRadius.def.pill,
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: isMultiLine
                                      ? AppRadius.def.lg
                                      : AppRadius.def.pill,
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: isMultiLine
                                      ? AppRadius.def.lg
                                      : AppRadius.def.pill,
                                  borderSide: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(Gaps.def.xs),
                              ),
                            ),
                          ),
                          _ComposerButton(
                            isComposerOpen: isComposerOpen,
                            openComposer: openComposer,
                            controller: controller,
                            layoutSize: layoutSize,
                          ),
                        ],
                      ),
                      if (isMultiLine)
                        _ActionsWrap(
                          actionButtons: [...actionButtons],
                          menuTrigger: _MenuTrigger(menuItems: menuItems, layoutSize: layoutSize,),
                        )
                      else
                        SizedBox.shrink(),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ComposerButton extends StatelessWidget {
  final bool isComposerOpen;
  final void Function() openComposer;
  final TextEditingController controller;
  final LayoutSize layoutSize;

  _ComposerButton({
    required this.isComposerOpen,
    required this.openComposer,
    required this.controller,
    required this.layoutSize,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void onSubmit(String text) {}
    void onVoiceCapture() {}

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (_, v, __) {
        final hasText = v.text.trim().isNotEmpty;

        IconData chooseIcon() {
          if (layoutSize == LayoutSize.compact && !isComposerOpen) {
            return Icons.add;
          } else {
            if (hasText) return Icons.arrow_upward;
            return Icons.graphic_eq;
          }
        }

        return Padding(
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
                    openComposer();
                  }
                  if (hasText) {
                    onSubmit(controller.text);
                    controller.clear();
                  } else {
                    onVoiceCapture();
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ActionsWrap extends StatelessWidget {
  final List<IconButton> actionButtons;
  final _MenuTrigger menuTrigger;
  _ActionsWrap({required this.actionButtons, required this.menuTrigger});
  @override
  Widget build(BuildContext context) {
    return Row(children: [menuTrigger, Spacer(), ...actionButtons]);
  }
}

class _MenuTrigger extends StatelessWidget {
  final List<ChatboxMenuItemButton> menuItems;
  final LayoutSize layoutSize;
  _MenuTrigger({required this.menuItems, required this.layoutSize});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        layoutSize == LayoutSize.compact? showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Gaps.def.sm),
            ),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Gaps.def.xxs),
              child: Wrap(children: menuItems),
            );
          },
        ): SizedBox() //Mat3 popover
        ;
      },
    );
  }
}
