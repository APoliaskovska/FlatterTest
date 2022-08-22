import 'package:flutter/material.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

extension TransactionStatus on Transaction {
  Color statusColor() {
    return this.status == "Fail" ? Colors.red : AppColors.mediumGrayColor;
  }
}

class TransactionItem extends StatelessWidget {
  final Transaction transaction;

  TransactionItem(this.transaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.screenWidth,
      padding: EdgeInsets.all(Dimensions.widthPadding10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(text: transaction.referenceNumber, fontType: FontType.medium,),
              const SizedBox(width: 8, height: 10),
              SmallText(text: transaction.amount.toStringAsFixed(2) + " " + transaction.currency),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(text: "Fee:"),
              SmallText(text: transaction.fee.toStringAsFixed(2) + " " + transaction.currency),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmallText(text: "Status: " +  transaction.status),
              SmallText(text: transaction.date),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20/2)),
        border: Border.all(color: transaction.statusColor()),
      ),
    );
  }
}
