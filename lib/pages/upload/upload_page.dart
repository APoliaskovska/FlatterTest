import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/upload/upload_controller.dart';
import 'package:sample/pages/upload/widgets/file_item.dart';
import 'package:sample/utils/dimensions.dart';

import '../../widgets/main_app_bar.dart';

class UploadPage extends GetView<UploadController> {
  @override
  Widget build(BuildContext context) {
    double _buttonSize = Dimensions.screenWidth / 4;

    return Scaffold(
      appBar: MainAppBar(
        titleText: "Upload",
        showAccountIcon: false,
        showMenuIcon: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.mainBackgroundColor
        ),
        child: Center(
          child: Obx(() {
            return NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                        floating: false,
                        backgroundColor: AppColors.mainBackgroundColor,
                        surfaceTintColor: AppColors.primaryColor,
                        expandedHeight: _buttonSize + Dimensions.height80,
                        collapsedHeight: _buttonSize,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: Dimensions.heightPadding10),
                              Visibility(
                                visible: !controller.inProgress,
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.white),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(_buttonSize / 2),
                                          )
                                      ),
                                      fixedSize: MaterialStateProperty.all(
                                          Size(_buttonSize, _buttonSize))
                                  ),
                                  onPressed: () async {
                                    await controller.onAddPressed();
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.primaryColor,
                                    size: Dimensions.iconSize50 * 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(width: Dimensions.height20),
                              controller.selectedFileNames.isNotEmpty ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  Visibility(
                                    visible: controller.inProgress,
                                    child: SizedBox(
                                      height: _buttonSize+3,
                                      width: _buttonSize+3,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 10,
                                        backgroundColor: AppColors.primaryColor,
                                        valueColor: new AlwaysStoppedAnimation<Color>(AppColors.secondaryTextColor),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(Colors.white),
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(_buttonSize / 2),
                                            )
                                        ),
                                        fixedSize: MaterialStateProperty.all(
                                            Size(_buttonSize, _buttonSize))
                                    ),
                                    onPressed: () async {
                                      await controller.onUploadPressed();
                                    },
                                    child: Icon(
                                      Icons.upload_outlined,
                                      color: AppColors.primaryColor,
                                      size: Dimensions.iconSize50 * 1.5,
                                    ),
                                  ),
                                ],
                              ) : SizedBox()
                            ],
                          ),
                        )
                    )
                  ];},
                body: ListView.builder(
                  padding: EdgeInsets.all(Dimensions.widthPadding15),
                  itemCount: controller.selectedFiles.length,
                    itemBuilder:  (BuildContext context, int index) {
                    return FileItem(
                        fileName: controller.selectedFileNames[index],
                        fileSize: controller.selectedFiles[index].size,
                        didPressDelete: (){
                          controller.onPressDelete(controller.selectedFiles[index]);
                        });
                    }
                  )
            );
          }),
        ),
      ),
    );
  }
}
