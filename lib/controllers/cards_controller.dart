import 'package:mvc_pattern/mvc_pattern.dart';

enum CardsMenuItems { cardLimits, changePIN, freezeCard, closeCard }

extension CardsMenuItemsTitle on CardsMenuItems {
  String title() {
    switch (this) {
      case CardsMenuItems.cardLimits:
        return "Card Limits";
      case CardsMenuItems.changePIN:
        return "Change PIN";
      case CardsMenuItems.freezeCard:
        return "Freeze card";
      case CardsMenuItems.closeCard:
        return "Close card";
    }
  }
}

class CardsController extends ControllerMVC{
  static CardsController? _this;
  static CardsController? get controller => _this;

  var cardsMenuItems = CardsMenuItems.values;
  var currPageValue = 0.0;

  factory CardsController() {
    if (_this == null) _this = CardsController._();
    return _this!;
  }

  CardsController._();

  void onCardTapped(int id) {
    print("did tap card id " + id.toString());
  }

  void onMenuItemTapped(CardsMenuItems item) {
    print(item.title());
  }
}
