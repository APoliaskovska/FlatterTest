import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/pages/card_details/cards_transactions/search_transaction_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../../../widgets/main_app_bar.dart';
import '../widgets/transaction_item.dart';


class SearchTransactionPage extends  GetView<SearchTransactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        titleText: "Search Transaction",
        showAccountIcon: false,
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.only(right: Dimensions.widthPadding15*2, left: Dimensions.widthPadding15*2),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Search",
                  suffixIcon: Icon(Icons.search),
                  labelStyle: TextStyle()
                ),
                onChanged: (text) {
                  controller.runFilter(text);
                },
              ),
              Expanded(
                child: controller.filterTransactions.length > 0 ? ListView.builder(
                    itemCount: controller.filterTransactions.length,
                    itemBuilder: (context, index) => Column(
                      children: [
                        SizedBox(height: Dimensions.height10),
                        TransactionItem(controller.filterTransactions[index]),
                      ],
                    )
                ) : Center(child: SmallText(text: "Transactions not found")),
              )
            ],
          ),
        );
      }),
    );
  }
}
