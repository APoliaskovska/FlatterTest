import 'package:flutter/material.dart';
import 'package:sample/pages/card_body.dart';
import 'package:sample/utils/dimensions.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Cards")
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                child: CardBody(),
            ),
          ],
        ),
      ),
    );
  }
}
