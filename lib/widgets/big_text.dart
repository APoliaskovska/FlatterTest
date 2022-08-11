import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/widgets/small_text.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? size;
  final double? height;
  final FontType? fontType;
  final TextAlign? textAlign;

  const BigText({ Key? key,
    this.color = AppColors.mainBlackColor,
    required this.text,
    this.size = 0,
    this.height = 1.8,
    this.fontType = FontType.medium,
    this.textAlign = TextAlign.left
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: textAlign,
      style: TextStyle(fontFamily: 'Roboto',
        color: color,
        fontSize: size == 0 ? 24 : size,
        height: height,
        overflow: TextOverflow.ellipsis,
        fontWeight: fontType!.weight(),
      ),
    );
  }
}