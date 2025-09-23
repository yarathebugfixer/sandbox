import 'package:flutter/material.dart';
import 'package:sandbox/types/chatbox_menu_item.dart';

class ChatboxMenuItemButton extends StatelessWidget {
  final ChatboxMenuItem chatboxMenuItem;

  const ChatboxMenuItemButton({super.key, required this.chatboxMenuItem});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: chatboxMenuItem.onClick,
      leadingIcon: Icon(chatboxMenuItem.icon),
      child: Text(chatboxMenuItem.label),
    );
  }
}
