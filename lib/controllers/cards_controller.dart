import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:sample/grpc/grpc_service.dart';
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

  List<PaymentCard> cardsList = [];
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

  void getCardModelList() async {
   isLoading = true;
   isLoaded = false;
   print("getCardModelList() started");

   try {
     final result = await cardsRepo.getCards();
     if (result != null && result.cards.length > 0) {
       final resData = result.cards;
       cardsList.clear();
       for (int i=0; i < resData.length; i++) {
         cardsList.add(resData[i]);
       }
       isLoaded = true;
       print("getCardModelList() loaded: " + resData.toString());
     } else {
       isLoaded = false;
       print("getCardModelList() loaded: " +  "false");
     }
     isLoading = false;
     update();
    } catch  (error) {
     print("getCardModelList() failed with error: " + error.toString());
     isLoading = false;
     update();
    }
  }

}
