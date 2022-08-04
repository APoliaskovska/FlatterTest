import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/models/card.dart';
import 'package:sample/pages/card_details_page.dart';

import '../service/repository/cards_repo.dart';

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

class CardsController extends GetxController  {
  final CardsRepo cardsRepo;
  CardsController({required this.cardsRepo});

  List<CardModel> cardsList = [];
  bool isLoaded = false;
  bool isLoading = false;

  var cardsMenuItems = CardsMenuItems.values;

  void onCardTapped(int id) {
    print("did tap card id " + id.toString());
  }

  void onMenuItemTapped(int index, BuildContext context) {
    switch (cardsMenuItems[index]){
      case CardsMenuItems.cardLimits:
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => CardDetailsPage()
            )
        );
        break;
        default:
          break;
    }
  }

  Future<void> getCardModelList() async {
    isLoading = true;
    await cardsRepo.getCardList().then((value) {
      if (value.statusCode == 200) {
        isLoading = false;
        Map<String, dynamic> resData = json.decode(value.body);
        if (resData["cards_list"]!=null) {
          cardsList.clear();
          CardModelList.fromJson(resData).cardList!.forEach((element) {
            cardsList.add(element);
          });

          isLoaded = true;
          update();
        }
      } else {
        isLoading = false;
        isLoaded = false;
        update();
      }
      return value;
    });
  }
}
