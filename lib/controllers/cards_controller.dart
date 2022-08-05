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

  List<dynamic> cardsList = [];
  bool isLoaded = false;
  bool isLoading = true;

  var cardsMenuItems = CardsMenuItems.values;

  void onCardTapped(int id) {
    print("did tap card id $id");
  }

  void onMenuItemTapped(int index, BuildContext context) {
    switch (cardsMenuItems[index]){
      case CardsMenuItems.cardLimits:
        Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => const CardDetailsPage()
            )
        );
        break;
        default:
          break;
    }
  }

  Future<dynamic> getCardModelList() async {
   isLoading = true;
   isLoaded = false;
   final result = await cardsRepo.getCardList();

   if (result.success) {
     final dynamic resData = result.response;
     if (resData["cards_list"]!=null) {
       cardsList.clear();
       for (var element in CardModelList.fromJson(resData).cardList!) {
         cardsList.add(element);
       }
     }
     isLoaded = true;
   } else {
     print("getCardModelList() failed with error: " + result.response);
     isLoaded = false;
   }
   isLoading = false;
   update();
  }
}
