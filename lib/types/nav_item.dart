import 'package:flutter/material.dart';

class NavItem {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onClick;

  const NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onClick,
  });
}
