import 'dart:math';

import 'package:get/get.dart';
import 'package:sample/service/repository/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  static AuthController? _this;
  static AuthController? get controller => _this;


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