import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/top_up/top_up_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/big_text.dart';
import 'package:sample/widgets/small_text.dart';

import '../../widgets/main_app_bar.dart';

class TopUpPage extends GetView<TopUpController> {
  final _buttonsSize = Dimensions.width50/1.5;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MainAppBar(
        showMenuIcon: true,
        titleText: "Top Up",
        showAccountIcon: false,
        rightItem: infoWidget(),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: AppColors.mainBackgroundColor,
          margin: EdgeInsets.only(top: Dimensions.widthPadding10*2),
          padding: EdgeInsets.only(
              top: Dimensions.widthPadding10,
              bottom: Dimensions.widthPadding10,
              left: Dimensions.widthPadding10,
              right: Dimensions.widthPadding10
          ),
          child: Column(
            children: [
              //TOP VIEW
              Container(
                width: Dimensions.screenWidth,
                height: Dimensions.screenWidth/2,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    accessoryButton("Top up",
                        Icon(Icons.add, color: Colors.black), () {
                    }),
                    Expanded(
                      //width: double.infinity,
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(Dimensions.widthPadding10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            style: BorderStyle.solid,
                              color: AppColors.primaryColor
                          ),
                            shape: BoxShape.circle,
                            color: Colors.white
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.account_balance_wallet),
                            SmallText(text: "Total available"),
                            SizedBox(height: Dimensions.height10/2),
                            BigText(text: "0.00"),
                            SmallText(text: "CHF")
                          ],
                        ),
                      ),
                    ),
                    accessoryButton("Exchange", Icon(Icons.currency_exchange,
                      color: Colors.black,), () {
                    }),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height10),

              //SHOW INACTIVE ACCOUNT
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmallText(text: "  Show inactive account"),
                  Switch(
                      activeColor: AppColors.primaryColor,
                      value: true,
                      onChanged: (value){

                      })
                ],
              ),
              SizedBox(height: Dimensions.height10),

              //TOP UP ACCOUNT

              Padding(
                padding: EdgeInsets.all(Dimensions.heightPadding10),
                child: ElevatedButton(
                  style:  ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 15.0,
                    fixedSize: Size(Dimensions.screenWidth*.7, 40)
                  ),
                    onPressed: (){},
                    child: SmallText(text: "Top Up This Account", color: Colors.white)
                ),
              ),
              SizedBox(height: Dimensions.height10),

              //ACCOUNT ORDERS

              Column(
                children: [
                  itemWidget("EUR", "0.00", Colors.red),
                  itemWidget("CHF", "0.00", Colors.blue),
                  itemWidget("UAH", "0.00", Colors.yellow)
                ],
              )
              
            ],
          ),
        ),
      ),
    );
  }

  Widget accessoryButton(String title, Icon icon, void Function() onPressed){
    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.primaryColor,
                shape: CircleBorder(),
                shadowColor: Colors.transparent,
                backgroundColor: Colors.transparent
            ),
            onPressed: onPressed,
            child:  Container(
              height: _buttonsSize,
              width: _buttonsSize,
              alignment: Alignment.center,
              child: icon,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(
                    color: AppColors.primaryColor
                ),
                shape: BoxShape.circle,
              ),
            ),
        ),
        SizedBox(height: 2),
        SmallText(text: title, size: 12.0, color: Colors.black)
      ],
    );
  }

  Widget itemWidget(String currency, String amount, Color color) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 6.0,
              offset: Offset(0,0),
              blurStyle: BlurStyle.outer
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20/2))
      ),
      margin: EdgeInsets.all(Dimensions.widthPadding10),
      padding: EdgeInsets.only(
          top: Dimensions.widthPadding10,
          right: Dimensions.widthPadding10,
          bottom: Dimensions.widthPadding10
      ),//all(Dimensions.widthPadding10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2),
                        bottomLeft: Radius.circular(2)
                    ),
                    color: color
                ),
              ),
              Column(
                  children: [
                    SmallText(text: currency),
                    BigText(text: amount, size: 18,),
                  ]
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  Widget infoWidget() {
    return Container(
        child: IconButton(
          icon: const Icon(Icons.info_outline),
          onPressed: () {
            controller.infoPressed();
          },
        )
    );
  }
}
