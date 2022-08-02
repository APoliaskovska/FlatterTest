import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/constants/constant.dart';
import 'package:sample/utils/dimensions.dart';

class CardBody extends StatefulWidget {
  const CardBody({Key? key}) : super(key: key);

  @override
  State<CardBody> createState() => _CardBodyState();
}

class _CardBodyState extends State<CardBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(children: [
              Text("Bank name"),
              Text("VISA"),
            ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          Row(children: [
              Text("Chip")
            ],),
          SizedBox(height: 10),
          Row(children: [
              Text("Card number", textAlign: TextAlign.center,)
            ],
          ),
          Row(children: [
              Text("Cardholder name"),
              Text("Expires 12/22"),
            ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            )
          ],
        ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.blueSecondaryColor
      ),
    );
  }
}
