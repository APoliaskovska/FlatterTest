import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/constants/localization_keys.dart';
import 'package:sample/pages/card_details/widgets/transaction_item.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';
import '../../constants/constants.dart';
import '../../widgets/main_app_bar.dart';
import '../cards/widgets/card_body.dart';
import 'card_details_controller.dart';

class CardDetailsPage extends GetView<CardDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: Strings.cards.translate(),
        showAccountIcon: false,
        rightItem: Row(
          children: [
            _searchWidget()
          ],
        ),
      ),
      body: controller.obx((state) {
        return SingleChildScrollView(
          child: Column(
            children: [

              //CARD VIEW
              Container(
                  padding: EdgeInsets.all(Dimensions.widthPadding10),
                  width: Dimensions.screenWidth,
                  child: _buildFlipAnimation(
                      controller.paymentCard) //CardBody(controller.paymentCard)
              ),
              SmallText(text: Strings.transactions.translate(), size: 18, fontType: FontType.medium,),

              //TRANSACTIONS
              controller.transactions.length > 0 ? Container(
                padding: EdgeInsets.all(Dimensions.widthPadding15 * 2),
                child: Column(
                    children: [
                      for(int i = 0; i < controller.transactions.length; i++)
                        Column(
                          children: [
                            TransactionItem(controller.transactions[i]),
                            SizedBox(height: Dimensions.height10)
                          ],
                        )
                    ]
                ),
              ) :

              //NO TRANSACTIONS
              Container(
                height: Dimensions.height200,
                child: Center(
                    child: SmallText(text: Strings.no_transactions_text.translate())),
              )
            ],
          ),
        );
      },
        onLoading: Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildFlipAnimation(PaymentCard card) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          controller.didTapCard();
        },
        child: AnimatedSwitcher(
          transitionBuilder: _transitionBuilder,
          duration: Duration(milliseconds: 400),
          child: controller.displayFront ? _buildFront(card) : _buildRear(card),
        ),
      );
    });
  }

  Widget _buildFront(PaymentCard card) {
    return CardBody(card);
  }

  Widget _buildRear(PaymentCard card) {
    return Container(
      width: Dimensions.screenWidth,
      height: (Dimensions.screenWidth - Dimensions.widthPadding15*2)/1.88,
      margin: EdgeInsets.all(Dimensions.widthPadding15),
      //padding: EdgeInsets.all(Dimensions.widthPadding10*2),
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
      child: Column(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Dimensions.height15*2),
          Container(
              color: Colors.black.withAlpha(190),
              height: Dimensions.height15*2.4
          ),
          SizedBox(height: Dimensions.height15*2),
          SmallText(text: "Test User Name")
        ],
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnim,
      child: widget,
      builder: (context, widget) {
        final isUnder = (ValueKey(controller.displayFront) != widget?.key);
        var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
        tilt *= isUnder ? -1.0 : 1.0;
        final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
        return Transform(
          transform: (Matrix4.rotationY(value)..setEntry(3, 0, tilt)),
          child: widget,
          alignment: Alignment.center,
        );
      },
    );
  }

  Widget _searchWidget(){
    return  Container(
        child: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            controller.openSearch();
          },
        )
    );
  }
}