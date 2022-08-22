import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';

class PreloaderCircular extends StatelessWidget {
  final double size;
  final EdgeInsets? padding;
  final Color preloaderColor;
  final Color? preloaderInactiveColor;
  final Color bgColor;

  const PreloaderCircular({
    this.size = 64,
    this.padding,
    this.bgColor = Colors.transparent,
    this.preloaderColor = AppColors.primaryColor,
    this.preloaderInactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: padding ?? const EdgeInsets.all(20),
        child: Theme(
          data: ThemeData(colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.red)),
          child: CircularProgressIndicator(
            strokeWidth: 2,
            backgroundColor: preloaderInactiveColor ?? Colors.grey.shade100,
          ),
        ),
      ),
    );
  }
}

class PreloaderWithMessage extends StatelessWidget {
  final String? label;
  final double? preloaderSize;
  final double? fontSize;

  const PreloaderWithMessage({
    this.label,
    this.preloaderSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PreloaderCircular(
          size: preloaderSize ?? 32,
          padding: const EdgeInsets.all(4),
        ),
        const SizedBox(height: 8),
        Text(
          label ?? 'LOADING',
          style: TextStyle(
            fontSize: fontSize ?? 11,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
