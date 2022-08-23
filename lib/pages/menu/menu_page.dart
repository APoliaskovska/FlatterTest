import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/menu/menu_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../../routes/routes.dart';

class MenuPage extends GetView<MenuController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.menuBgColor,
      body: Stack(
        children: <Widget>[
          menu(context),
          main(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(Dimensions.widthPadding15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ClipOval(
              child: SizedBox.fromSize(
                  size: Size.fromRadius(Dimensions.width50), // Image radius
                  child: Image.asset("assets/images/avatar-placeholder.jpg")
              ),
            ),
            SizedBox(height: Dimensions.height20),
            SmallText(text: "Dashboard", color: Colors.white),
            SizedBox(height: Dimensions.height10),
            SmallText(text:"Messages",
                color: Colors.white),
            SizedBox(height: Dimensions.height10),
            SmallText(text:"Utility Bills",
                color: Colors.white),
            SizedBox(height: Dimensions.height10),
            SmallText(text:"Funds Transfer",
                color: Colors.white),
            SizedBox(height: Dimensions.height10),
            SmallText(text:"Settings", color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget main(context) {
    return Obx(() {
      final navigatorKey = GlobalObjectKey<NavigatorState>(context);
      return AnimatedPositioned(
        duration: controller.duration,
        top: controller.isCollapsed ? 0 : 0.1 * Dimensions.screenWidth,
        bottom: controller.isCollapsed ? 0 : 0.1 * Dimensions.screenWidth,
        left: controller.isCollapsed ? 0 : 0.6 * Dimensions.screenWidth,
        right: controller.isCollapsed ? 0 : -0.2 * Dimensions.screenWidth,
        child: ScaleTransition(
          scale: controller.scaleAnimation,
          child: Material(
            clipBehavior: Clip.hardEdge,
            elevation: 8,
            borderRadius: BorderRadius.all(Radius.circular(controller.isCollapsed ? 0 : Dimensions.radius20)),
            child: Navigator(
              key: navigatorKey,
              pages: [
                AppPages.routes.firstWhere((element) =>
                element.name == Routes.MAIN)
              ],
            ),
          ),
        ),
      );
    });
  }

}
