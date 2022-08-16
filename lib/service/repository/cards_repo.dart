import 'package:get/get.dart';

import 'package:proto_sample/generated/sample.pb.dart';
import '../grpc/grpc_service.dart';

class CardsRepo extends GetxService {
  final _grpcService = Get.find<MainService>();

  Future<dynamic> getCards() async{
    return await _grpcService.getUserCards(User(id: 2, login: "Test"));
  }

  Future<TransactionsList?> getTransactionList(int cardId) async{
    return await _grpcService.getTransactions(cardId);
  }
}


