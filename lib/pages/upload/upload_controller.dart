import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:sample/service/repository/upload_repo.dart';
import 'package:grpc/grpc.dart';

import '../../utils/get_utils.dart';

class UploadController extends GetxController with StateMixin {
  static UploadController get() => Get.find();

  final UploadRepo uploadRepo;

  UploadController({required this.uploadRepo});

  final RxList _selectedFiles = [].obs;
  final RxList _selectedFileNames = [].obs;
  final _inProgress = false.obs;

  List<PlatformFile> get selectedFiles  => _selectedFiles.cast();
  List<String> get selectedFileNames => _selectedFileNames.cast();
  bool get inProgress => _inProgress();

  @override
  void onInit() async {
    super.onInit();
  }

  Future<dynamic> onAddPressed() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return null;
    final files = result.files;
    List<String> fileNames = [];
    for (final file in files) {
      fileNames.add(file.name);
    }
    _selectedFiles.addAll(files);
    _selectedFileNames.addAll(fileNames);
  }

  void onPressDelete(PlatformFile document) {
    List<PlatformFile> files = selectedFiles.where((element) => element != document).toList();
    List<String> names = files.map((e) => e.name).toList();

    _selectedFiles(files);
    _selectedFileNames(names);
  }

  Future<dynamic> onUploadPressed() async {
    _inProgress(true);

    try {
      dynamic result = await uploadRepo.uploadDocs(selectedFiles);
      _inProgress(false);
      print("onUploadPressed TRY");
      if (result == true) {
        AppUtils.showSuccess("Success", "Your documents did success upload!");
        _selectedFiles.clear();
        _selectedFileNames.clear();
      } else if (result is Error) {
        final Error error = result;
        AppUtils.showError(error.toString());
      }
    } on GrpcError catch(e) {
      print("onUploadPressed GRPC ERROR");

      _inProgress(false);
      print("error " + e.toString());
      final eMessage = e.message;
      if (eMessage != null) {
        AppUtils.showError(eMessage);
      }
    } catch (e) {
      print("onUploadPressed ERROR " + e.toString());
      _inProgress(false);
      AppUtils.showError(e.toString());
    }
  }
}