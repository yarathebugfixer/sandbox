import 'package:flutter/material.dart';
import 'package:sandbox/widgets/organisms/chatbox/menu_trigger.dart';

class ActionsBox extends StatelessWidget {
  final List<IconButton> actionButtons;
  final MenuTrigger menuTrigger;
  ActionsBox({required this.actionButtons, required this.menuTrigger});
  @override
  Widget build(BuildContext context) {
    return Row(children: [menuTrigger, Spacer(), ...actionButtons]);
  }
}