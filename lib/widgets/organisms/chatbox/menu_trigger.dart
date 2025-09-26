import 'package:flutter/material.dart';
import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/sizes.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';

class MenuTrigger extends StatelessWidget {
  final LayoutSize layoutSize;
  final List<ChatboxMenuItemButton> menuItems;

  const MenuTrigger({
    required this.layoutSize,
    required this.menuItems,

    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (layoutSize == LayoutSize.compact) {
      // 📱 Mobile: use IconButton + showModalBottomSheet
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Wrap(
                children: [
                  ...menuItems.where(
                    (item) => item.chatboxMenuItem.priority == 0,
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return MenuAnchor(
        style: MenuStyle(
          backgroundColor: WidgetStateProperty.all(theme.colorScheme.surface),
          maximumSize: WidgetStatePropertyAll(Size.square(Sizes.chatBoxMenuWidth)),
        ),
        // All your menu items go here
        menuChildren: menuItems
            .where((item) => item.chatboxMenuItem.priority == 0)
            .map(
              (item) => MenuItemButton(
                onPressed: item.chatboxMenuItem.onClick,
                child: Row(
                  children: [
                    Icon(item.chatboxMenuItem.icon, size: 20),
                    const SizedBox(width: 8),
                    Text(item.chatboxMenuItem.label),
                  ],
                ),
              ),
            )
            .toList(),
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () =>
                    controller.isOpen ? controller.close() : controller.open(),
              );
            },
      );
    }
  }
}
