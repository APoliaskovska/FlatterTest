import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/card_details/card_details_controller.dart';
import 'package:sample/card_details/widgets/transaction_item.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';
import '../cards/widgets/card_body.dart';
import '../widgets/main_app_bar.dart';

class CardDetailsPage extends  GetView<CardDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: "Cards",
        showAccountIcon: false,
        rightItem: SearchWidget(onPressed: (){
          controller.openSearch();
        }),
      ),
      body:  controller.obx((state) {
        return SingleChildScrollView(
          child: Column(
            children: [

              //CARD VIEW
              Container(
                padding: EdgeInsets.all(Dimensions.widthPadding10),
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

class SearchWidget extends StatelessWidget {
  final Function() onPressed;
  const SearchWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            onPressed();
          },
        )
    );
  }
}
