import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/constants/constants.dart';

import '../service/repository/cards_repo.dart';

extension TransactionStatus on Transaction {
  Color statusColor() {
    return this.status == "Fail" ? Colors.red : AppColors.mediumGrayColor;
  }
}

class CardDetailsController extends GetxController with StateMixin {
  static CardDetailsController get() => Get.find();

  final CardsRepo cardsRepo;

  final _card = PaymentCard().obs;
  final List<Transaction> _transactions = [];

  PaymentCard get paymentCard => _card();
  List<Transaction> get transactions => _transactions;

  CardDetailsController({required this.cardsRepo});

  dynamic _argumentData = Get.arguments;

  @override
  void onInit() async {
    super.onInit();
    var data = _argumentData;
    if (data[0] != null){
      _card(data[0]);
    }

    change(null, status: RxStatus.loading());
    await _getTransactions();
    change(null, status: RxStatus.success());
  }

  Future<dynamic> _getTransactions() async {
    try {
      final result = await cardsRepo.getTransactionList(this.paymentCard.id);
      if (result != null) {
        _transactions.clear();
        _transactions.addAll(result.transactionsList);
      }
    } catch (error) {
      print("Error: " + error.toString());
    }
  }
}
