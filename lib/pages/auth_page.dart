import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/controllers/auth_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../widgets/main_app_bar.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  @override
  void initState(){
    super.initState();
    Get.find<AuthController>().initialLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
          titleText: "Auth",
          showAccountIcon: false
      ),
      body: GetBuilder<AuthController>(builder: (controller) {
        var _isValid = controller.isValidPassword && controller.isValidLogin;
        return Center(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(Dimensions.widthPadding15*2),
            child: AbsorbPointer(
              absorbing: controller.inProgress == true,
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start,
                children: [
                  TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        Get.find<AuthController>().setLogin(value);
                      },
                    style: const TextStyle(fontSize: 18.0),
                    decoration: controller.isValidLogin ? InputDecoration(
                      hintText: 'Login',
                    ) : InputDecoration(
                        hintText: 'Login',
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
                      decoration: controller.isValidPassword ? InputDecoration(
                        hintText: 'Password'
                      ) : InputDecoration(
                          hintText: 'Password',
                          errorText: AppErrorsString.FIELD_IS_EMPTY
                      ),
                      validator: (val) => (val == null) ? AppErrorsString.INVALID_LOGIN_OR_PASSWORD : null,
                      onFieldSubmitted: (password) => context

                  ),
                  SizedBox(height: Dimensions.height20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isValid ? AppColors.primaryColor : Colors.grey, // This is what you need!
                    ),
                    onPressed: (){
                      if (_isValid) Get.find<AuthController>().login();
                    },
                    child: Container(
                        padding: EdgeInsets.all(Dimensions.widthPadding10),
                        child: SmallText(text: "Sign in", color: Colors.white),
                      )
                  ),
                  SizedBox(height: Dimensions.height20),
                  controller.inProgress ? const Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
                      : Container()
                ],
              ),
            ),
          ),
        );
      })
    );
  }
}
