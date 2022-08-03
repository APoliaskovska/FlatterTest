import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CardDetailsController extends ControllerMVC {

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
