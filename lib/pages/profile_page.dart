import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/controllers/profile_contoller.dart';
import 'package:sample/pages/components/error_container.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/big_text.dart';
import 'package:sample/widgets/small_text.dart';

import '../widgets/main_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends  State<ProfilePage> {
  final _imageSize = Dimensions.height200;

  @override
  void initState() {
    super.initState();
    Get.find<ProfileController>().initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    final logoutItem = _logoutWidget();
    return Scaffold(
        appBar: MainAppBar(
            titleText: "Profile",
            rightItem: logoutItem
        ),
        body: GetBuilder<ProfileController>(builder: (controller) {
          return controller.userDetails != null ? Container(
            decoration: BoxDecoration(
                color: Colors.white
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      border: Border.all(
                          color: AppColors.blueSecondaryColor
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(_imageSize / 2))
                  ),
                  height: _imageSize,
                  width: _imageSize,
                  child: controller.avatar == null ?
                  BigText(text: "${controller.userDetails!.name[0]}${controller
                      .userDetails!.surname[0]}".toUpperCase())
                      : controller
                      .avatar! as Image, //Image.asset("images/profile.jpg")
                ),
                SizedBox(height: Dimensions.height15 * 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(text: "ID:"),
                    SmallText(text: " "),
                    SmallText(
                      text: controller.userDetails!.id.toString(), size: 16,)
                  ],
                ),
                SizedBox(height: Dimensions.height20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmallText(text: controller.userDetails!.name, size: 16,),
                    SmallText(text: " "),
                    SmallText(text: controller.userDetails!.surname, size: 16,)
                  ],
                ),
                SizedBox(height: Dimensions.height10,),
                SmallText(text: controller.userDetails!.dateBirth, size: 16,)
              ],
            ),
          )
              : ErrorContainer(
              "Error loading profile details...\nTry again later", () {
            controller.reloadData();
          });
        })
    );
  }

  Widget _logoutWidget() {
    return GetBuilder<ProfileController>(builder: (controller) {
      return IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Logout'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: const <Widget>[
                      Text('Are you sure want to log out?'),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('No'),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  TextButton(
                    child: const Text('Yes'),
                    onPressed: () async {
                      Get.back();
                      await controller.logout();
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    });
  }
}