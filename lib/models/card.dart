import 'package:flutter/material.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';

extension CardImage on PaymentCard{
  Image cardImage(){
    return Image.asset(this.cardType.type == "VISA"?
    "assets/images/mastercard.png" : "assets/images/visa.png");
  }
}