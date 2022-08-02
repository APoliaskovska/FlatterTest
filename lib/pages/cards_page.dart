import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constant.dart';
import 'package:sample/models/card.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child:
              PageView(
                scrollDirection: Axis.horizontal,
                children: [
                  for(int i=0; i<cardsList.length; i++)
                    CardBody(cardsList[i]),
                ],
                onPageChanged: (index){
                  print("page changed to" + index.toString());
                  },
              ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
