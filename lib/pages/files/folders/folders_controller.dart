import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/pages/files/files/files_page.dart';
import 'package:sample/routes/routes.dart';
import 'package:sample/utils/get_utils.dart';

import '../../../service/repository/upload_repo.dart';
import '../../main/widgets/main_tabbar.dart';
import '../files/files_controller.dart';

class FoldersController extends MainTabController {
  static FoldersController get() => Get.find();

  final UploadRepo uploadRepo;

  FoldersController({required this.uploadRepo});

  final RxList _foldersList = [].obs;
  final _isLoaded = false.obs;
  final _isLoading = false.obs;

  List<FileFolder> get selectedFolders  => _foldersList.cast();
  bool get isLoaded => _isLoaded();
  bool get isLoading => _isLoading();

  @override
  Future<void> onInit() async {
    super.onInit();

    await reloadData();
  }

  //MARK: - Public

  Future<dynamic> reloadData() async {
    print("reloadData");
    await _getFoldersList();
  }

  Future<void> didTapFolder(FileFolder folder) async {
    await Get.to(
        FilesPage(),
        arguments: [folder],
        transition: Transition.rightToLeft,
        binding: BindingsBuilder.put(() {
          Get.lazyPut(() => UploadRepo());
          return FilesController(uploadRepo: Get.find());
        })
    );
  }

  //MARK: - Private

  Future<dynamic> _getFoldersList() async {
    _isLoaded(false);
    _isLoading(true);

    try {
      final result = await uploadRepo.getFileFolders(2);

      if (result != null && result.folders.length > 0) {
        final resData = result.folders;
        _foldersList.clear();
        for (int i=0; i < resData.length; i++) {
          _foldersList.add(resData[i]);
        }
        _isLoaded(true);
      } else {
        _isLoaded(false);
      }
      _isLoading(false);
      update();
    } catch (error) {
      _isLoading(false);
      update();
      AppUtils.showError(error.toString());
    }
  }

}