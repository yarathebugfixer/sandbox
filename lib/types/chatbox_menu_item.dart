import 'package:flutter/material.dart';


class ChatboxMenuItem {
  final IconData icon;
  final String label;
  final VoidCallback onClick;
  final int priority;

  ChatboxMenuItem({
    required this.icon,
    required this.label,
    required this.onClick,
    required this.priority,
  });
}
