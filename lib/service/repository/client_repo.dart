import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import '../grpc/grpc_service.dart';

class ClientRepo extends GetxService {
  final _grpcService = Get.find<MainService>();
  final _storage = const FlutterSecureStorage();

  Future<dynamic> getUserDetails() async{
    return await _grpcService.getUserDetails();
  }

  Future<dynamic> getUserPhoto() async{
    return await _grpcService.getUserAvatar();
  }

  Future<void> logout() async {
    await _storage.delete(key: "token");
    await _storage.deleteAll();
  }
}