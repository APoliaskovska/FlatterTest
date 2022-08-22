import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/pages/main/widgets/bottom_navbar.dart';
import 'main_controller.dart';

class MainPage extends GetView<MainController> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.canPop,
      child: Scaffold(
        body: Obx(
              () => IndexedStack(
            index: controller.selectedNav(),
            children: controller.getPages(),
          ),
        ),
        bottomNavigationBar: BottomNavBar(),
      ),
    );
  }
}

