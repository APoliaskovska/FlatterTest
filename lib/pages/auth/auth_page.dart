import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/constants/localization_keys.dart';
import 'package:sample/pages/auth/auth_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/buttons/main_button.dart';

import '../../widgets/main_app_bar.dart';

class AuthPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          titleText: Strings.auth_title.translate(),
          showAccountIcon: false
      ),
      body: Obx(() {
        var _isValid = controller.isValidLogin && controller.isValidPassword;
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            color: AppColors.mainBackgroundColor,
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                top: Dimensions.widthPadding15*2,
                left: Dimensions.widthPadding15*2,
                right: Dimensions.widthPadding15*2),
            child: AbsorbPointer(
              absorbing: controller.inProgress == true,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    width: Dimensions.iconSize50*2),
                  SizedBox(height: Dimensions.height20),
                  TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        Get.find<AuthController>().setLogin(value);
                      },
                      style: const TextStyle(fontSize: 18.0),
                      decoration: controller.isValidLogin || controller.isFirstLoad ? InputDecoration(
                        hintText: Strings.login_field.translate(),
                      ) : InputDecoration(
                          hintText: Strings.login_field.translate(),
                          errorText: AppErrorsString.FIELD_IS_EMPTY
                      ),
                      validator: (val) => (val == null) ? AppErrorsString.INVALID_LOGIN_OR_PASSWORD : null,
                      onFieldSubmitted: (password) => context

                  ),
                  TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (String? value) {
                        Get.find<AuthController>().setPassword(value);
                      },
                      style: const TextStyle(fontSize: 18.0),
                      decoration: controller.isValidPassword || controller.isFirstLoad ? InputDecoration(
                          hintText: Strings.password_field.translate()
                      ) : InputDecoration(
                          hintText: Strings.password_field.translate(),
                          errorText: AppErrorsString.FIELD_IS_EMPTY
                      ),
                      validator: (val) => (val == null) ? AppErrorsString.INVALID_LOGIN_OR_PASSWORD : null,
                      onFieldSubmitted: (password) => context

                  ),
                  SizedBox(height: Dimensions.height20),
                  MainButton(text: Strings.sign_in_button.translate(), onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_isValid) await controller.login();
                  }),
                  Spacer()
                  //   SizedBox(height: Dimensions.height20),
                  //Container()
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
