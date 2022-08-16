import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/card_details/card_details_controller.dart';
import 'package:sample/utils/dimensions.dart';
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
      body:  Obx(() {
        return Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
                width: Dimensions.screenWidth,
                child: CardBody(controller.paymentCard)
            )],
        );
      }),
    );
  }
}
