import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';

import '../grpc/grpc_service.dart';

class AuthRepo extends GetxService {
  final _grpcService = Get.find<MainService>();

  //auth requests

  Future<User> auth(String login, String password) async {
    return await _grpcService.loginWith(login, password);
  }
}
