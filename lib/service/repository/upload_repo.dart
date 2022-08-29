import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import '../grpc/grpc_service.dart';

class UploadRepo extends GetxService {
  final _grpcService = Get.find<MainService>();

  Future<dynamic> getUserPhoto() async {
    return await _grpcService.getUserAvatar();
  }

  Future<dynamic> uploadDocs(List<PlatformFile> docs) async{
    return await _grpcService.uploadDocs(docs);
  }
}