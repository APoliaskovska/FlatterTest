import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/files/files/files_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../../../widgets/main_app_bar.dart';

class FilesPage extends GetView<FilesController> {
  Color _currentColor = AppFolderColors.folderColor1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: "Files",
        showAccountIcon: false,
        showMenuIcon: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.reloadData();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Obx(() {
          return Stack(
            clipBehavior: Clip.antiAlias,
            children: [
              Positioned(
                top: 0,
                bottom: 0,
                width: Dimensions.screenWidth,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  //  crossAxisCount: 2,
                  children: <Widget>[
                    for (int i = 0; i < controller.files.length; i++)
                      fileWidget(controller.files[i])
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }

  Widget fileWidget(FileObject file) {
    return GestureDetector(
      onTap: () async {
        FileData? fileData = await controller.downloadFile(file);
        if (fileData != null) {
        } else {
          print("File download error");
        }
      },
      child: Container(
        padding: EdgeInsets.only(
            top: Dimensions.widthPadding15,
            left: Dimensions.widthPadding10,
            right: Dimensions.widthPadding10
        ),
        child: Column(
          children: [
            Icon(Icons.file_present_outlined,
                size: Dimensions.iconSize24 * 4,
                color: folderColor()),
            SizedBox(height: 2),
            SmallText(text: file.name + "." + file.format)
          ],
        ),
      ),
    );
  }

  Color folderColor() {
    int _index = AppFolderColors.colors.indexOf(_currentColor);
    if (_index == AppFolderColors.colors.length - 1) {
      _currentColor = AppFolderColors.colors.first;
    } else {
      _currentColor = AppFolderColors.colors[_index + 1];
    }
    return _currentColor;
  }
}