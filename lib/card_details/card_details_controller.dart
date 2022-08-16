import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';

import '../service/repository/cards_repo.dart';

class CardDetailsController extends GetxController {
  static CardDetailsController get() => Get.find();

  final CardsRepo cardsRepo;

  final _card = PaymentCard().obs;

  PaymentCard get paymentCard => _card();

  CardDetailsController({required this.cardsRepo});

  dynamic _argumentData = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var data = _argumentData;
    if (data[0] != null){
      _card(data[0]);
    }
  }
}
