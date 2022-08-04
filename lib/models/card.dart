import 'package:flutter/material.dart';

class CardModel {
  int? id;
  String? bankName;
  String? cardType;
  String? cardNumber;
  String? expires;
  String? holderName;
  int? cvv;

  CardModel({
      this.id,
      this.bankName,
      this.cardType,
      this.cardNumber,
      this.expires,
      this.holderName,
      this.cvv
  });

  factory CardModel.fromJson(Map<String, dynamic> responseData) {
    return CardModel(
      id: responseData['id'],
      bankName: responseData['bank_name'],
      cardType: responseData['card_type'],
      cardNumber: responseData['card_number'],
      expires: responseData['expires'],
      holderName: responseData['holder_name'],
      cvv: responseData['cvv']
    );
  }
}

extension CardImage on CardModel{
  Image cardImage(){
    return Image.asset(this.cardType == "VISA"?
    "assets/images/mastercard.png" : "assets/images/visa.png");
  }
}

class CardModelList {
  List<CardModel>? cardList;

  CardModelList({
    this.cardList
  });

  factory CardModelList.fromJson(Map<String, dynamic> responseData) {
    print("json = " + responseData.toString());

    if (responseData['cards_list'] != null) {
      List<CardModel> cardsList = [];
      cardsList.clear();
      responseData['cards_list']
          .forEach((e) => {
            cardsList.add(CardModel.fromJson(e))}
      );
      return CardModelList(
        cardList: cardsList,
      );
    } else {
      return CardModelList(
        cardList: [],
      );
    }
  }
}

abstract class CardModelListResult {}

// указывает на успешный запрос
class CardModelListResultSuccess extends CardModelListResult {
  final CardModelList cardList;
  CardModelListResultSuccess(this.cardList);
}

// произошла ошибка
class CardModelListResultFailure extends CardModelListResult {
  final String error;
  CardModelListResultFailure(this.error);
}

// загрузка данных
class CardModelListResultLoading extends CardModelListResult {
  CardModelListResultLoading();
}
//
// final List<CardModel> cardsList = [
//   CardModel(
//       0,
//       "First Bank",
//       "VISA",
//       "1234 1234 1234 1234",
//       "12/26",
//       "Credit card",
//       123
//   ),
//   CardModel(
//       1,
//       "Second Bank",
//       "MASTERCARD",
//       "1234 1234 1234 1234",
//       "10/22",
//       "Payment card",
//       123
//   ),
//   CardModel(
//       2,
//       "Third Bank",
//       "VISA",
//       "2342 1234 3214 5679",
//       "02/23",
//       "Credit card",
//       123
//   ),
// ];
//
