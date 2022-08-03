import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sample/controllers/card_details_controller.dart';
import 'package:sample/widgets/small_text.dart';

import '../constants/constants.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({Key? key}) : super(key: key);

  @override
  _CardDetailsPageState createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends StateMVC {
  CardDetailsController? _controller;

  _CardDetailsPageState() : super(CardDetailsController()) {
    _controller = CardDetailsController.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
        title: Text("Card Details"),
      ),
        body: Container(
          alignment: Alignment.center,
          child: SmallText(text: "Card Details Screen"),
        )
    );
  }
}
