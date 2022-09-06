import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import '../grpc/grpc_service.dart';

class UploadRepo extends GetxService {
  final _grpcService = Get.find<MainService>();

  Future<dynamic> getUserPhoto() async {
    return await _grpcService.getUserAvatar();
  }

  Future<dynamic> uploadDocs(List<PlatformFile> docs) async{
    return await _grpcService.uploadDocs(docs);
  }

  Future<dynamic> getFileFolders(int userId) async{
    return await _grpcService.getFolders(userId.toString());
  }

  Future<dynamic> getFolderFiles(int userId, String folderId) async{
    return await _grpcService.getFolderFiles(userId.toString(), folderId);
  }

  Stream<FileData> downloadFile(int userId, String fileId) {
    return _grpcService.downloadFile(userId.toString(), fileId);
  }
}