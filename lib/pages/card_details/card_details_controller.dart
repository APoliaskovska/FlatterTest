import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/routes/routes.dart';
import '../../service/repository/cards_repo.dart';

class CardDetailsController extends GetxController with StateMixin {
  static CardDetailsController get() => Get.find();

  final CardsRepo cardsRepo;

  final _card = PaymentCard().obs;
  final List<Transaction> _transactions = [];
  final _displayFront = true.obs;

  PaymentCard get paymentCard => _card();
  List<Transaction> get transactions => _transactions;
  bool get displayFront => _displayFront();

  CardDetailsController({required this.cardsRepo});

  @override
  void onInit() async {
    super.onInit();
    var data = Get.arguments;
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

  void openSearch(){
    Get.toNamed(Routes.SEARCH_TRANSACTION, arguments: transactions);
  }

  void didTapCard() {
    _displayFront(!displayFront);
  }
}
