import 'package:flutter/material.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';
import 'package:sandbox/widgets/organisms/chatbox/menu_trigger.dart';

class ActionsBox extends StatelessWidget {
  final List<ChatboxMenuItemButton> actionButtons;
  final MenuTrigger menuTrigger;
  ActionsBox({required this.actionButtons, required this.menuTrigger});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          menuTrigger,
          Spacer(),
          ...actionButtons.map((button) {
            return IconButton(
              icon: Icon(button.chatboxMenuItem.icon),
              onPressed: button.chatboxMenuItem.onClick,
            );
          }),
        ],
      ),
    );
  }
}
