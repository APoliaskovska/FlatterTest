import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proto_sample/generated/sample.pb.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/files/folders/folders_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../../../widgets/main_app_bar.dart';

class FoldersPage extends GetView<FoldersController> {
  Color currentColor = AppFolderColors.folderColor1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: "Folders",
        showAccountIcon: false,
        showMenuIcon: true,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await controller.reloadData();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
              top: 0,
              bottom: 0,
              width: Dimensions.screenWidth,
              child: Obx(() {
                return GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  //  crossAxisCount: 2,
                  children: <Widget>[
                    for (int i = 0; i < controller.selectedFolders.length; i++)
                      folderWidget(controller.selectedFolders[i])
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget folderWidget(FileFolder folder) {
    return  InkWell(
      onTap: () async {
        await controller.didTapFolder(folder);
      },
      child: Container(
        padding: EdgeInsets.only(
            top: Dimensions.widthPadding15,
            left: Dimensions.widthPadding10,
            right: Dimensions.widthPadding10
        ),
        child: Column(
          children: [
            Icon(Icons.folder,
                size: Dimensions.iconSize24 * 4,
                color: folderColor()),
            SizedBox(height: 2),
            SmallText(text: folder.name)
          ],
        ),
      ),
    );
  }

  Color folderColor() {
    int _index = AppFolderColors.colors.indexOf(currentColor);
    if (_index == AppFolderColors.colors.length - 1) {
      currentColor = AppFolderColors.colors.first;
    } else {
      currentColor = AppFolderColors.colors[_index + 1];
    }
    return currentColor;
  }
}