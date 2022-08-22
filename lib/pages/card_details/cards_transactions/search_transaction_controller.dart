import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';

import '../../../service/repository/cards_repo.dart';

class SearchTransactionController extends GetxController with StateMixin {
  static SearchTransactionController get() => Get.find();

  final CardsRepo cardsRepo;

  SearchTransactionController({required this.cardsRepo});

  final RxList _transactions = [].obs;
  final RxList _filterTransactions = [].obs;

  RxList get transactions => _transactions;
  RxList get filterTransactions => _filterTransactions;

  @override
  void onInit() async {
    super.onInit();
    var data = Get.arguments;
    print("DATA TRANSACTIONS" + data.toString());
    if (data != null){
      _transactions.clear();
      _transactions.addAll(data);

      _filterTransactions.clear();
      _filterTransactions.addAll(data);
    }
  }

  void runFilter(String enteredKey) {
    List<dynamic>? result = [];
    if (enteredKey.isEmpty) {
      result = transactions.toList();
    } else {
      result = transactions.where((tr) {
        return (tr as Transaction).referenceNumber.toLowerCase().contains(enteredKey.toLowerCase());
      }).toList();
    }
    _filterTransactions(result);
  }
}