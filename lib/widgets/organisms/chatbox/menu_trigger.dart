import 'package:sandbox/theme/breakpoints.dart';
import 'package:sandbox/theme/gaps.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/widgets/molecules/chatbox_menu_item.dart';

class MenuTrigger extends StatelessWidget {
  final List<ChatboxMenuItemButton> menuItems;
  final LayoutSize layoutSize;
  MenuTrigger({required this.menuItems, required this.layoutSize});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        layoutSize == LayoutSize.compact
            ? showModalBottomSheet(
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
              )
            : SizedBox() //Mat3 popover
              ;
      },
    );
  }
}
