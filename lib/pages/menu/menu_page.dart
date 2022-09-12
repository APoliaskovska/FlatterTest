import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/menu/menu_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../../routes/routes.dart';

class MenuPage extends GetView<MenuController> {
  late GlobalObjectKey _navigatorKey;

  @override
  Widget build(BuildContext context) {
    _navigatorKey = GlobalObjectKey<NavigatorState>(context);
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
                SizedBox(height: Dimensions.height15),
                for (int i = 0; i < ItemData.allItems.length; i++)
                  _menuItem(ItemData.allItems[i])
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
              key: _navigatorKey,
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

  Widget _menuItem(MenuItems item) {
    return GestureDetector(
      onTap: () async {
        await controller.didTapItem(item);
      },
      child: Column(
        children:[
          Row(
            children: [
              Icon(item.icon(), color: Colors.white),
              SizedBox(width: 10),
              SmallText(
                text: item.title(),
                color: Colors.white
              ),
            ],
          ),
          SizedBox(height: Dimensions.height10)
        ]
      ),
    );
  }
}
