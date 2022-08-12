import 'package:get/get.dart';
import '../grpc/grpc_service.dart';

class ClientRepo extends GetxService {
  final _grpcService = Get.find<MainService>();

  Future<dynamic> getUserDetails() async{
    return await _grpcService.getUserDetails();
  }

  Future<dynamic> getUserPhoto() async{
    return await _grpcService.getUserAvatar();
  }

}