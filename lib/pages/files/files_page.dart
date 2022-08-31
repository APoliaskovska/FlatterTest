import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/files/files_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

import '../../widgets/main_app_bar.dart';

class FilesPage extends GetView<FilesController> {
  Color currentColor = AppFolderColors.folderColor1;

  @override
  Widget build(BuildContext context) {
    print("width = " + Dimensions.screenWidth.toString());
    return Scaffold(
      appBar: MainAppBar(
        titleText: "Files",
        showAccountIcon: false,
        showMenuIcon: true,
      ),
      body: Stack(
        clipBehavior: Clip.antiAlias,
        children: [
          Positioned(
            top: 0,
            child: Container(
              height: Dimensions.screenWidth,
              width: Dimensions.screenWidth,
              child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              //  crossAxisCount: 2,
              children: <Widget>[
                folderWidget("Customers"),
                folderWidget("Bank accounts"),
                folderWidget("Ensures Data"),
                folderWidget("Customers"),
                folderWidget("Business Data"),
                folderWidget("Members"),

              ],
            )
            ),
          )
        ],
      ),
    );
  }

  Widget folderWidget(String name) {
    return Container(
      padding: EdgeInsets.only(
          top: Dimensions.widthPadding15,
          left: Dimensions.widthPadding10,
          right: Dimensions.widthPadding10
      ),
      child: Column(
        children: [
          Icon(Icons.folder,
            size: Dimensions.iconSize24*4,
          color: folderColor()),
          SizedBox(height: 2),
          SmallText(text: name)
        ],
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