import 'package:flutter/material.dart';
import 'package:sample/constants/constant.dart';
import 'package:sample/utils/dimensions.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? size;
  final double? height;

  const SmallText({ Key? key,
    this.color = AppColors.mainBlackColor,
    required this.text,
    this.size = 0,
    this.height = 1.2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Text(
     text!,
     style: TextStyle(fontFamily: 'Roboto',
       color: color,
       fontSize: size == 0 ? Dimensions.font14 : size,
       height: height,
       overflow: TextOverflow.ellipsis,
      ),
    );
  }
}