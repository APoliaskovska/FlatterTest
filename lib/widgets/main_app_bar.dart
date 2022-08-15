import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/widgets/small_text.dart';

import '../auth/auth_controller.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String? titleText;
  final bool? showAccountIcon;
  final Widget? rightItem;

  const MainAppBar({ Key? key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.titleText = "",
    this.showAccountIcon = false, this.rightItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> actionWidgets = [];
    if (showAccountIcon! == true){
      actionWidgets.add(IconButton(
        icon: const Icon(Icons.person),
        onPressed: () {
         //TODO
        },
      ));
    } else if (rightItem != null){
      actionWidgets.add(rightItem!);
    }
    return AppBar(
        title: SmallText(
            text:titleText,
            color: AppColors.primaryColor,
          size: 16,
        ),
      backgroundColor: Colors.white,
      foregroundColor: AppColors.primaryColor,
      actions: actionWidgets,

    );
  }
}