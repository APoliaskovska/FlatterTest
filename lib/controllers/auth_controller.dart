import 'dart:math';

import 'package:get/get.dart';
import 'package:sample/pages/main_page.dart';
import 'package:sample/service/repository/auth_repo.dart';

class AuthController extends GetxController {
  static AuthController get() => Get.find();

  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  static AuthController? _this;
  static AuthController? get controller => _this;

  static String? _login;
  static String? _password;

  bool isValidLogin = false;
  bool isValidPassword = false;
  bool inProgress = false;

  void initialLoad(){

  }

  void setLogin(String? login){
    _login = login;
    isValidLogin = login != null && login.length > 0;
    update();
  }

  void setPassword(String? password) {
    _password = password;
    isValidPassword = password != null && password.length > 0;
    update();
  }

  Future<dynamic> login() async {
    if (inProgress == true) return;

    inProgress = true;
    update();
    Future.delayed(const Duration(milliseconds: 1000), () {
      inProgress = false;
      update();
      Get.off(MainPage());
    });
  }

  Future<bool> checkLogin() async {
    return await authRepo.getToken().then((token) {
      if (token != null && token.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    });
  }

  Future<void> performLogin() async {
    String newToken = generateRandomString(17);
    await authRepo.setToken(newToken);
  }

  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89));
  }
}