import 'package:flutter/material.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:sandbox/theme/radius.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/action_box.dart';
import 'package:sandbox/widgets/organisms/chatbox/menu_trigger.dart';

class TextComposer extends StatelessWidget {
  TextComposer({
    required this.controller,
    required this.actionButtons,
    this.placeholder,
    this.onText,
    required this.disabled,
    required this.layoutSize,
    required this.isMultiLine,
    required this.menuItems,
  });

  final String? placeholder;
  final ValueChanged<String>? onText;
  final TextEditingController controller;
  final bool disabled;
  final LayoutSize layoutSize;
  final List<ChatboxMenuItemButton> actionButtons;
  final bool isMultiLine;
  final List<ChatboxMenuItemButton> menuItems;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxSize = layoutSize == LayoutSize.compact
        ? Sizes.inputMaxWidth
        : Sizes.expandedInputMaxWidth;
    return SizedBox(
      width: maxSize,
      height: Sizes.chatBoxMaxHeight,
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (_, value, __) {
          final isMultiLine =
              value.text.length > Sizes.multiLineThreshHold ||
              controller.text.contains('\n');
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: TextField(
                      minLines: 1,
                      maxLines: null,
                      textInputAction: isMultiLine
                          ? TextInputAction.newline
                          : TextInputAction.send,
                      scrollPadding: EdgeInsets.only(
                        bottom: Sizes.chatBoxScrollPadding,
                      ),
                      controller: controller,
                      onChanged: !disabled ? onText : null,
                      enabled: !disabled,
                      decoration: InputDecoration(
                        hintText: placeholder,
                        prefixIcon: isMultiLine
                            ? null
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Gaps.def.xxs,
                                ),
                                child: MenuTrigger(
                                  menuItems: menuItems,
                                  layoutSize: layoutSize,
                                ),
                              ),
                        suffixIcon: isMultiLine
                            ? null
                            : SizedBox(
                                width: Sizes.trailingIconsBoxWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: actionButtons.map((button) {
                                    return IconButton(
                                      icon: Icon(button.chatboxMenuItem.icon),
                                      onPressed: button.chatboxMenuItem.onClick,
                                    );
                                  }).toList(),
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
                ],
              ),
              isMultiLine
                  ? ActionsBox(
                      actionButtons: [...actionButtons],
                      menuTrigger: MenuTrigger(
                        menuItems: menuItems,
                        layoutSize: layoutSize,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
