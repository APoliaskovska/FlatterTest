import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/constants/themes.dart';
import 'package:sample/main/widgets/main_tabbar.dart';
import 'package:sample/service/repository/client_repo.dart';
import '../routes/routes.dart';

class ProfileController extends MainTabController {
  static ProfileController get() => Get.find();
  bool canPop() => false;

  final ClientRepo clientRepo;

  Image? avatar;
  UserDetails? userDetails;
  bool isLoading = false;

  ProfileController({required this.clientRepo});

  @override
  void onInit() {
    super.onInit();
    reloadData();
  }

  void reloadData() {
    isLoading = true;
    update();
    _getUserDetails();
    _getUserPhoto();
  }

  void _getUserPhoto() async {
    try {
      final result = await clientRepo.getUserPhoto() as AvatarImage;
      avatar = Image.memory( Uint8List.fromList(result.image));

      update();
    } catch (error) {
      print("_getUserPhoto() failed with error: " + error.toString());
      update();
    }
  }


  Future<dynamic> logout() async {
    if (isLoading == true) return;

    isLoading = true;
    update();
    await Future.delayed(const Duration(milliseconds: 1000), () async {
      isLoading = false;
      Get.offAndToNamed(Routes.LOGIN);
    });
  }

  void _getUserDetails() async {
    isLoading = true;
    try {
      final result = await clientRepo.getUserDetails();
      if (result != null) {
        userDetails = result;
        isLoading = false;
        update();
      }
    } catch (error) {
      print("_getUserDetails() failed with error: " + error.toString());
      update();
      userDetails = null;
      isLoading = false;
    }
  }

  // overrides

  @override
  void onTabOpen() {
    reloadData();
  }
}