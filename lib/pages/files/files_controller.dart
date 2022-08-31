import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../../service/repository/upload_repo.dart';

class FilesController extends GetxController with StateMixin {
  static FilesController get() => Get.find();

  final UploadRepo uploadRepo;

  FilesController({required this.uploadRepo});

  final RxList _filesList = [].obs;

  List<PlatformFile> get selectedFiles  => _filesList.cast();

}