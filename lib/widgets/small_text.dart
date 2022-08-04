import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';

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
  final TextAlign? textAlign;

  const SmallText({ Key? key,
    this.color = AppColors.mainBlackColor,
    required this.text,
    this.size = 0,
    this.height = 1.2,
    this.fontType = FontType.regular,
    this.textAlign = TextAlign.left
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Text(
     text!,
     textAlign: textAlign,
     style: TextStyle(fontFamily: 'Roboto',
       color: color,
       fontSize: size == 0 ? 14 : size,
       height: height,
       overflow: TextOverflow.ellipsis,
       fontWeight: fontType!.weight(),
      ),
    );
  }
}