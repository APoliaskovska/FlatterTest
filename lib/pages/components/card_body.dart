import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/controllers/cards_controller.dart';
import 'package:sample/models/card.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

class CardBody extends StatelessWidget {
  final CardModel card;

  CardBody(this.card);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Dimensions.screenWidth - Dimensions.widthPadding15*2)/1.88,
      margin: EdgeInsets.all(Dimensions.widthPadding15),
      padding: EdgeInsets.all(Dimensions.widthPadding10*2),
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(Dimensions.radius20/2),
        boxShadow: [BoxShadow(
          color: AppColors.secondaryColor,
          blurRadius: 8.0,
          offset: Offset(0,0),
          blurStyle: BlurStyle.outer
        )]
      ),
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
                SmallText(text: this.card.bankName, fontType: FontType.medium, size: 16,),
                SizedBox(
                  width: Dimensions.iconSize16*4,
                  height: Dimensions.iconSize16*2,
                  child: this.card.cardImage(),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            SizedBox(height: Dimensions.height10),
            Row(children: [
              SizedBox(
                  width: Dimensions.iconSize16*2.3,
                  height: Dimensions.iconSize16*2.3,
                  child: Image.asset(
                      "assets/images/chip.png"
                  )
              )
              ],
            ),
            SizedBox(height: Dimensions.height15),
            Row(
              children: [
                SmallText(text: this.card.cardNumber, fontType: FontType.medium, size: 18,)
              ],
            ),
            SizedBox(height: Dimensions.height20),
            Row(
              children: [
                SmallText(text: this.card.holderName, fontType: FontType.medium, size: 16,),
                SmallText(text:"Expires " + this.card.expires),
              ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              )
            ],
          ),
      ),
    );
  }
}
