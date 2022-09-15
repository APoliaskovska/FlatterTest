import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/localization_keys.dart';
import 'package:sample/pages/card_details/cards_transactions/search_transaction_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../widgets/main_app_bar.dart';
import '../widgets/transaction_item.dart';

class SearchTransactionPage extends GetView<SearchTransactionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: Strings.search_transaction.translate(),
        showAccountIcon: false,
        rightItem: _calendarWidget(context),
      ),
      body: Obx(() {
        return Padding(
          padding: EdgeInsets.only(right: Dimensions.widthPadding15 * 2,
              left: Dimensions.widthPadding15 * 2),
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10),
              TextField(
                decoration: InputDecoration(
                    labelText: Strings.search.translate(),
                    suffixIcon: Icon(Icons.search),
                    labelStyle: TextStyle()
                ),
                onChanged: (text) {
                  controller.runFilter(text);
                },
              ),
              Expanded(
                child: controller.filterTransactions.length > 0 ? ListView
                    .builder(
                    itemCount: controller.filterTransactions.length,
                    itemBuilder: (context, index) =>
                        Column(
                          children: [
                            SizedBox(height: Dimensions.height10),
                            TransactionItem(controller
                                .filterTransactions[index]),
                          ],
                        )
                ) : Center(child: SmallText(
                    text: Strings.transactions_not_found_error.translate())),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _calendarWidget(BuildContext context) {
    return Container(
        child: IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Dimensions.radius20),
                  ),
                ),
                builder: (context) {
                  return Container(
                    margin: EdgeInsets.all(Dimensions.widthPadding10),
                    child: Column(
                      children: [
                        Obx(() {
                          return TableCalendar(
                            selectedDayPredicate: (date) {
                              return controller.isDaySelected(date);
                            },
                            firstDay: DateTime.utc(2010, 10, 16),
                            lastDay: DateTime.utc(2030, 3, 14),
                            focusedDay: controller.focusDate(),
                            eventLoader: (day) {
                              return controller.getEventsForDay(day);
                            },
                            onDaySelected: (date, date1) {
                              controller.didTapDay(date);
                            },
                          );
                        }),
                      ],
                    ),
                  );
                }
            );
          },
        )
    );
  }
}