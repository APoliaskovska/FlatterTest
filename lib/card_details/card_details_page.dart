import 'package:flutter/material.dart';
import 'package:sample/widgets/small_text.dart';

import '../widgets/main_app_bar.dart';

class CardDetailsPage extends StatefulWidget {
  const CardDetailsPage({Key? key}) : super(key: key);

  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends  State<CardDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  const MainAppBar(
          titleText: "Card Limits"
      ),
        body: Container(
          alignment: Alignment.center,
          child: SmallText(text: "Card Details Screen"),
        )
    );
  }
}
