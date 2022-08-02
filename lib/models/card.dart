import 'package:flutter/material.dart';

class CardModel {
  final int id;
  final String bankName;
  final String cardType;
  final String cardNumber;
  final String expires;
  final String holderName;
  final int cvv;

  CardModel(this.id, this.bankName, this.cardType, this.cardNumber, this.expires, this.holderName, this.cvv);
}

final List<CardModel> cardsList = [
  CardModel(
      0,
      "First Bank",
      "VISA",
      "1234 1234 1234 1234",
      "12/26",
      "Credit card",
      123
  ),
  CardModel(
      1,
      "Second Bank",
      "MASTERCARD",
      "1234 1234 1234 1234",
      "10/22",
      "Payment card",
      123
  ),
  CardModel(
      2,
      "Third Bank",
      "VISA",
      "2342 1234 3214 5679",
      "02/23",
      "Credit card",
      123
  ),
];

