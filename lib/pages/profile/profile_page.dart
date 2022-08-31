import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/profile/profile_contoller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/big_text.dart';
import 'package:sample/widgets/main_app_bar.dart';
import 'package:sample/widgets/small_text.dart';

import '../../widgets/error_container.dart';

class ProfilePage extends GetView<ProfileController> {
  final _imageSize = Dimensions.height200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
            showMenuIcon: true,
            titleText: "Profile",
            rightItem:
            LogoutWidget(onPressed: () {
              controller.logout(context);
            })
        ),
        body: Stack(
          children:[
            Positioned(
                top: 0,
                bottom: 0,
                width: Dimensions.screenWidth,
                child: Obx(() {
                  return controller.userDetails != null ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              border: Border.all(
                                  strokeAlign: StrokeAlign.outside,
                                  width: 1.0,
                                  color: AppColors.primaryColor
                              ),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(_imageSize / 2))
                          ),
                          height: _imageSize,
                          width: _imageSize,
                          child: controller.avatar == null ?
                          BigText(text: "${controller.userDetails!.name[0]}${controller
                              .userDetails!.surname[0]}".toUpperCase())
                              : controller.avatar!, //Image.asset("images/profile.jpg")
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
            )
          ],
        )
    );
  }
}


class LogoutWidget extends StatelessWidget {
  final Function() onPressed;
  const LogoutWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
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
                      this.onPressed();
                    },
                  ),
                ],
              );
            },
          );
        },
      )
    );
  }
}
