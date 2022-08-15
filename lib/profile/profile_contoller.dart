import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/main/widgets/main_tabbar.dart';
import 'package:sample/service/repository/client_repo.dart';
import '../routes/routes.dart';

class ProfileController extends MainTabController {
  static ProfileController get() => Get.find();

  bool canPop() => false;

  ClientRepo clientRepo;

  final _avatar = Image.asset("assets/images/avatar-placeholder.jpg").obs;

  final _userDetails = UserDetails(id: 0, name: "", surname: "", dateBirth: "").obs;

  final _isLoading = false.obs;

  Image? get avatar => _avatar();
  UserDetails? get userDetails => _userDetails();
  bool get isLoading => _isLoading();

  ProfileController({required this.clientRepo});

  // overrides

  @override
  void onTabOpen() {
    reloadData();
  }

  @override
  void onInit() {
    super.onInit();
    reloadData();
  }

  void reloadData() {
    _isLoading(true);
    update();
    _getUserDetails();
    _getUserPhoto();
  }

  void _getUserPhoto() async {
    try {
      final result = await clientRepo.getUserPhoto() as AvatarImage;
      _avatar(Image.memory(Uint8List.fromList(result.image)));
      update();
    } catch (error) {
      update();
    }
  }


  void logout(BuildContext context) async {
    if (_isLoading == true) return;

    _isLoading(true);
    update();
    await clientRepo.logout();
    _isLoading(false);
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      Get.offAllNamed(Routes.LOGIN);
    });
  }

  void _getUserDetails() async {
    _isLoading(true);
    try {
      final result = await clientRepo.getUserDetails();
      if (result != null) {
        _userDetails(result);
        _isLoading(false);
        update();
      }
    } catch (error) {
      _userDetails(UserDetails(id: 0, name: "", surname: "", dateBirth: ""));
      _isLoading(false);
      update();
    }
  }
}