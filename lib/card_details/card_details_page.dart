import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/card_details/card_details_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';
import '../cards/widgets/card_body.dart';
import '../widgets/main_app_bar.dart';

class CardDetailsPage extends  GetView<CardDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
          titleText: "Cards",
          showAccountIcon: false
      ),
      body:  controller.obx((state) {
        return SingleChildScrollView(
          child: Column(
            children: [

              //CARD VIEW
              Container(
                padding: EdgeInsets.all(10),
                  width: Dimensions.screenWidth,
                  child: CardBody(controller.paymentCard)
              ),
              SmallText(text: "Transactions", size: 18, fontType: FontType.medium,),

              //TRANSACTIONS
              controller.transactions.length > 0 ? Container(
                padding: EdgeInsets.all(Dimensions.widthPadding15*2),
                child: Column(
                  children: [
                    for(int i=0; i<controller.transactions.length; i++)
                      Column(
                        children: [
                          Container(
                            width: Dimensions.screenWidth,
                            padding: EdgeInsets.all(Dimensions.widthPadding10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(text: controller.transactions[i].referenceNumber, fontType: FontType.medium,),
                                    const SizedBox(width: 8, height: 10),
                                    SmallText(text: controller.transactions[i].amount.toStringAsFixed(2) + " " + controller.transactions[i].currency),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(text: "Fee:"),
                                    SmallText(text: controller.transactions[i].fee.toStringAsFixed(2) + " " + controller.transactions[i].currency),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SmallText(text: "Status: " +  controller.transactions[i].status),
                                    SmallText(text: controller.transactions[i].date),
                                  ],
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20/2)),
                                border: Border.all(color: controller.transactions[i].statusColor()),
                            ),
                          ),
                          SizedBox(height: Dimensions.height10)
                        ],
                      )
                  ]
                ),
              ) :

              //NO TRANSACTIONS
              Container(
                height: Dimensions.height200,
                child: Center(child: SmallText(text: "You haven't transactions yet...")),
              )
            ],
          ),
        );
      },
        onLoading: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
