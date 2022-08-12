import 'dart:math';

import 'package:get/get.dart';
import 'package:sample/service/repository/auth_repo.dart';
import 'package:sample/utils/get_utils.dart';

import '../routes/routes.dart';

class AuthController extends GetxController {
  static AuthController get() => Get.find();

  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  static AuthController? _this;
  static AuthController? get controller => _this;

  static String? _login;
  static String? _password;
  final _isValidLogin = false.obs;
  final _isValidPassword = false.obs;
  final _inProgress = false.obs;

  bool get isValidLogin => _isValidLogin();
  bool get isValidPassword => _isValidPassword();
  bool get inProgress => _inProgress();

  @override
  void onInit() {
    super.onInit();
    _initialLoad();
  }

  void _initialLoad(){

  }

  void setLogin(String? login){
    _login = login;
    _isValidLogin(_login != null && _login!.length > 0);
    update();
  }

  void setPassword(String? password) {
    _password = password;
    _isValidPassword(_password != null && _password!.length > 0);
    update();
  }

  Future<dynamic> login() async {
    if (_login == null || _password == null) return;

    _inProgress(true);
    AppUtils.showPreloader();

    try {
      final user = await authRepo.auth(_login!, _password!);
      AppUtils.hidePreloader();
      _inProgress(false);
      if (user.login.isEmpty) {
        AppUtils.showError("User not found...");
      } else {
        Get.offAllNamed(Routes.MAIN);
      }
    } catch (error) {
      _inProgress(false);
      AppUtils.showError(error.toString());
    }
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