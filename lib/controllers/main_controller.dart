import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:flutter/material.dart';

import '../pages/cards_page.dart';

class MainController extends ControllerMVC {

  static MainController? _this;
  static MainController? get controller => _this;

  factory MainController() {
    if (_this == null) _this = MainController._();
    return _this!;
  }

  MainController._();

  var currentIndex = 0;

  List pages = [
    const CardsPage(),
    const Center(
      child: Text("Page 2"),
    ),
    const Center(
      child: Text("Page 3"),
    ),
    const Center(
      child: Text("Page 4"),
    ),
  ];

   void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget currentPage() {
    return pages[currentIndex];
  }
}