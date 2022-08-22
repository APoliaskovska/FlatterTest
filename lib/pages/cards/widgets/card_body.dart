import 'package:flutter/material.dart';
import 'package:proto_sample/generated/sample.pbgrpc.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/models/card.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

class CardBody extends StatelessWidget {
  final PaymentCard card;

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
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                SmallText(text: card.bankName, fontType: FontType.medium, size: 16,),
                SizedBox(
                  width: Dimensions.iconSize16*4,
                  height: Dimensions.iconSize16*2,
                  child: card.cardImage(),
                )
              ],
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
                SmallText(text: card.cardNumber, fontType: FontType.medium, size: 18,)
              ],
            ),
            SizedBox(height: Dimensions.height20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmallText(text: card.holderName, fontType: FontType.medium, size: 16,),
                SmallText(text:"Expires ${card.expires}"),
              ],
              )
            ],
          ),
      ),
    );
  }
}
