import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/main/main_controller.dart';
import 'package:sample/pages/main/main_page.dart';
import 'package:sample/pages/menu/menu_controller.dart';
import 'package:sample/pages/menu/menu_page.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String? titleText;
  final bool? showAccountIcon;
  final bool? showMenuIcon;
  final bool? showBackButton;
  final Widget? rightItem;

  bool _isCollapsed = true;

  MainAppBar({ Key? key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.titleText = "",
    this.showAccountIcon = false,
    this.showMenuIcon = false,
    this.showBackButton = true,
    this.rightItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget leftWidget = Icon(Icons.add, color: Colors.transparent);
    Widget rightWidget = Icon(Icons.add, color: Colors.transparent);

    if (showMenuIcon == true) {
      leftWidget = InkWell(child: Icon(Icons.menu, color: Colors.blue), onTap: (){
          _isCollapsed = !_isCollapsed;
          Get.find<MenuController>().setCollapsed(_isCollapsed);
        },);
    }

    if (showAccountIcon! == true){
      rightWidget = IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            //TODO
          },
        );
    } else if (rightItem != null){
      rightWidget = rightItem!;
    }

    SmallText title = SmallText(
        text:titleText,
        color: AppColors.navTextColor,
        size: 16);

    return showMenuIcon == true ? AppBar(
      centerTitle: true,
      title: title,
      backgroundColor: AppColors.navBgColor,
      foregroundColor: AppColors.primaryColor,
      leading: leftWidget ,
      actions: [rightWidget],
    ) : AppBar(
      centerTitle: true,
      title: title,
      backgroundColor: AppColors.navBgColor,
      foregroundColor: AppColors.primaryColor,
      actions: [rightWidget],
    );
  }
}
