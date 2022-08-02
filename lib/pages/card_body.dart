import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sample/constants/constant.dart';
import 'package:sample/models/card.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

class CardBody extends StatelessWidget {
  final CardModel card;

  CardBody(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(
          color: AppColors.secondaryColor,
          blurRadius: 8.0,
          offset: Offset(1,3),
          blurStyle: BlurStyle.outer
        )]
      ),
      child: GestureDetector(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(children: [
                SmallText(text: this.card.bankName, fontType: FontType.medium, size: 16,),
                SmallText(text: this.card.cardType),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SizedBox(height: 20),
            Row(children: [
                SmallText(text: "Chip")
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                SmallText(text: this.card.cardNumber, fontType: FontType.medium, size: 18,)
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SmallText(text: this.card.holderName, fontType: FontType.medium, size: 16,),
                SmallText(text:"Expires " + this.card.expires),
              ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            ],
          ),
        onTap: (){
          print("did tap card");
        },
      ),
    );
  }
}
