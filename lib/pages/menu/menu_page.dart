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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: Dimensions.widthPadding10*2,
              top: Dimensions.widthPadding10*5
          ),
          alignment: Alignment.centerLeft,
          child: SmallText(
            text: "Version 1.0.0",
            color: Colors.white,
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(Dimensions.widthPadding10*2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                // PROFILE PHOTO
                Stack(
                  children: [
                    ClipOval(
                      child: SizedBox.fromSize(
                          size: Size.fromRadius(Dimensions.width50 / 1.5), // Image radius
                          child: Image.asset("assets/images/avatar-placeholder.jpg")
                      ),
                    ),

                    //STATUS

                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle
                      ),
                    )
                  ],
                ),
                SizedBox(height: Dimensions.height20),
                _menuItem("Dashboard", Icons.dashboard),
                SizedBox(height: Dimensions.height10),
                _menuItem("Messages", Icons.message),
                SizedBox(height: Dimensions.height10),
                _menuItem("Utility Bills", Icons.document_scanner_outlined),
                SizedBox(height: Dimensions.height10),
                _menuItem("Funds Transfer", Icons.currency_exchange),
                SizedBox(height: Dimensions.height10),
                _menuItem("Settings", Icons.settings),
              ],
            ),
          ),
        ),
        Container(
            padding: EdgeInsets.only(
                left: Dimensions.widthPadding10*2,
                bottom: Dimensions.widthPadding10*5
            ),
            alignment: Alignment.centerLeft,
            child:
            InkWell(
              child: SmallText(
                text: "Log out",
                color: AppColors.primaryColor,
              ),
              onTap: () {
                print("Log out!");
              },
            )
        )
      ],
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

  Widget _menuItem(String text, IconData icon) {
    return Container(
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 10),
          SmallText(
              text: text,
              color: Colors.white
          ),
        ],
      ),
    );
  }

}
