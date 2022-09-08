import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sample/service/auth_service.dart';

import '../../routes/routes.dart';

class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description
  });

  static List<Onboard> dataItems = [
    Onboard(
        image: "assets/images/onboarding/onboarding_1.png",
        title: "SIMPLE ABROAD CALLS",
        description: "App converts international calls to local\ncalls without WiFi or data"
    ),
    Onboard(
        image: "assets/images/onboarding/onboarding_2.png",
        title: "FREE WONEP TO WONEP",
        description: "if the person you’re calling also has App\nthe call will be entirely free"
    ),
    Onboard(
        image: "assets/images/onboarding/onboarding_3.png",
        title: "NO HIDDEN CHARGES OR FEES",
        description: "We have a very small charge for non-Wonep\ncalls to mobiles or landlines"
    ),
  ];
}

class OnboardingController extends GetxController with StateMixin {
  static OnboardingController get() => Get.find();

  OnboardingController();

  late PageController pageController;

  final _pageIndex = 0.obs;
  final _lastPage = false.obs;

  List<Onboard> items = Onboard.dataItems;

  int get pageIndex => _pageIndex();
  bool get lastPage => _lastPage();

  @override
  Future<void> onInit() async {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //public

  void onTapNextButton() {
    if (lastPage == true) {
      Get.offAllNamed(Routes.LOGIN);
      AuthService().setFirstLoad(false);
    } else if (_currentPage == items.length) {
      _lastPage(true);
    } else {
      pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void indexChanged(int index) {
    _pageIndex(index);
    if (index + 1 == items.length) {
      _lastPage(true);
    } else {
      _lastPage(false);
    }
  }

  //privat

  int _currentPage() {
    int currentPage = pageController.page?.toInt() ?? 0;
    currentPage = currentPage + 1;
    print("current page = " + currentPage.toString());
    return currentPage;
  }
}