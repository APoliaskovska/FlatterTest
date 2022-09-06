import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:grpc/grpc.dart';

import '../../../service/repository/upload_repo.dart';
import '../../../utils/get_utils.dart';

class FilesController extends GetxController with StateMixin {
  static FilesController get() => Get.find();

  final UploadRepo uploadRepo;

  FilesController({required this.uploadRepo});

  final RxList _filesList = [].obs;
  final _folder = FileFolder().obs;
  final _isLoaded = false.obs;
  final _isLoading = false.obs;

  bool get isLoaded => _isLoaded();
  bool get isLoading => _isLoading();

  FileFolder get folder => _folder();
  List<FileObject> get files  => _filesList.cast();

  @override
  void onInit() {
    super.onInit();

    var data = Get.arguments;
    if (data[0] != null){
      _folder(data[0]);
    }

    reloadData();
  }

  //MARK: - Public
  
  Future<void> reloadData() async{
    await _loadFiles();
  }

  Future<FileData?> downloadFile(FileObject file) async {
    AppUtils.showPreloader();
    try {
      AppUtils.hidePreloader();
      print("start downloading...");
      Stream<FileData> stream = await uploadRepo.downloadFile(2, file.id);
      FileData? fileData = await stream.first;
      //_showFilePicker(fileData, file);
      _shareFile(fileData, file);
      print("Return file empty = " + (fileData == null ? "yes" : "no"));
      return fileData;
    } on GrpcError catch(e) {
      AppUtils.hidePreloader();
      final eMessage = e.message;
      if (eMessage != null) {
        AppUtils.showError(eMessage);
      }
    } catch (error) {
      AppUtils.showError(error.toString());
    }
    return null;
  }

  //MARK: - Private

  Future<void> _loadFiles() async {
    _isLoaded(false);
    _isLoading(true);

    try {
      final result = await uploadRepo.getFolderFiles(2, folder.id);

      if (result != null && result.files.length > 0) {
        final resData = result.files;
        _filesList.clear();
        for (int i=0; i < resData.length; i++) {
          _filesList.add(resData[i]);
        }
        _isLoaded(true);
      } else {
        _isLoaded(false);
      }
      _isLoading(false);
      update();
      AppUtils.hidePreloader();
    } catch (error) {
      print(error.toString());
      _isLoading(false);
      update();
      AppUtils.hidePreloader();
      AppUtils.showError(error.toString());
    }
  }

  Future<dynamic> _shareFile(FileData fileData, FileObject fileObject) async {
    String fileName = fileObject.name + "." + fileObject.format;
    AppUtils.showPreloader();

    try {
      late String tempPath;

      await FilePicker.platform.clearTemporaryFiles();

      if (Platform.isIOS) {
        Directory dir = await getTemporaryDirectory();
        tempPath = dir.path;
      } else {
        Directory? dir = await getExternalStorageDirectory();
        tempPath = dir?.path ?? Directory.systemTemp.path;
      }

      String filePath = "$tempPath/$fileName";

      File docFile = await File("$tempPath/$fileName");

      await docFile.writeAsBytes(fileData.data, mode: FileMode.write);
      print("file size = " + docFile.lengthSync().toString());
      print("doc size = " + fileData.data.length.toString());
      print("file path = " + filePath);

      AppUtils.hidePreloader();

      await FlutterShare.shareFile(
        title: 'Share $fileName to ',
        filePath: filePath,
      );

    } catch (error) {
      AppUtils.hidePreloader();
      AppUtils.showError(error.toString());
      print(error.toString());
    }
  }

  Directory findRoot(FileSystemEntity entity) {
    final Directory parent = entity.parent;
    if (parent.path == entity.path) return parent;
    return findRoot(parent);
  }
}