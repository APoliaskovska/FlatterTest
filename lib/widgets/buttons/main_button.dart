import 'package:flutter/cupertino.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';

class MainButton extends StatelessWidget {
  MainButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  final BorderRadius _radius = BorderRadius.all(Radius.circular(20));

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimensions.width200,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: _radius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 5,
            color: CupertinoColors.black.withOpacity(0.3),
          )
        ]
      ),
      child: CupertinoButton(
        color: AppColors.primaryColor,
        onPressed: onPressed,
        borderRadius: _radius,
        child: SmallText(text: text, color: CupertinoColors.white),
      ),
    );
  }
}

/*
ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(Dimensions.width150, Dimensions.height20*2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.width50/2)),
                      backgroundColor: _isValid ? AppColors.primaryColor : Colors.grey, // This is what you need!
                    ),
                    onPressed: () async {

                    },
                    child: Container(
                      padding: EdgeInsets.all(Dimensions.widthPadding10),
                      child: SmallText(text: "Sign in", color: Colors.white),
                    )
                )
 */
