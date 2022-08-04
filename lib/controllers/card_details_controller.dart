import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardDetailsController extends GetxController {

  static CardDetailsController? _this;
  static CardDetailsController? get controller => _this;

  factory CardDetailsController() {
    if (_this == null) _this = CardDetailsController._();
    return _this!;
  }

  CardDetailsController._();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
