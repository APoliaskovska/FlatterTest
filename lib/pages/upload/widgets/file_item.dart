import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

class FileItem extends StatelessWidget {
  final String fileName;
  final int fileSize;
  final void Function()? didPressDelete;

  const FileItem({Key? key,
    required this.fileName,
    required this.fileSize,
    required this.didPressDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Dimensions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
               // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                child: Row(
                  children: [
                    Center(
                      child: Icon(
                        Icons.file_present_outlined,
                        color: AppColors.primaryColor,
                        size:   Dimensions.iconSize24,
                      ),
                    ),
                    SizedBox(width: 10),
                    Flexible(
                      child: SmallText(
                        text: fileName,
                        lineCount: 3,
                        overflow: TextOverflow.ellipsis,),
                    ),
                  ],
                )
              ),
              SizedBox(width: Dimensions.height10),
              Row(
                children: [
                  SmallText(
                    text: formatBytes(fileSize, 2),
                    lineCount: 3,
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: (){
                      if (didPressDelete != null) {
                        didPressDelete!();
                      }
                    },
                    child: Icon(
                      Icons.delete_outline_sharp,
                      color: Colors.red,
                      size:   Dimensions.iconSize24,
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: Dimensions.height10)
        ],
      ),
    );
  }

  static String formatBytes(int bytes, int decimals) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }
}
