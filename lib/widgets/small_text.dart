import 'package:flutter/material.dart';
import 'package:sample/constants/constant.dart';
import 'package:sample/utils/dimensions.dart';

enum FontType { regular, medium, bold, black }

extension FontTypeWeight on FontType {
  FontWeight weight() {
    switch (this) {
      case FontType.regular:
        return FontWeight.w400;
      case FontType.medium:
        return FontWeight.w500;
      case FontType.bold:
        return FontWeight.w700;
      case FontType.black:
        return FontWeight.w900;
    }
  }
}

class SmallText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? size;
  final double? height;
  final FontType? fontType;

  const SmallText({ Key? key,
    this.color = AppColors.mainBlackColor,
    required this.text,
    this.size = 0,
    this.height = 1.2,
    this.fontType = FontType.regular
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Text(
     text!,
     style: TextStyle(fontFamily: 'Roboto',
       color: color,
       fontSize: size == 0 ? 14 : size,
       height: height,
       overflow: TextOverflow.ellipsis,
       fontWeight: fontType!.weight()
      ),
    );
  }
}