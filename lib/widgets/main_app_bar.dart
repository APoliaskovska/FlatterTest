import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/menu/menu_controller.dart';
import 'package:sample/widgets/small_text.dart';
import 'package:get/get.dart';

// implements PreferredSizeWidget

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String? titleText;
  final bool? showAccountIcon;
  final bool? showMenuIcon;
  final bool? showBackButton;
  final Widget? rightItem;

  bool _isCollapsed = true;

  MainAppBar({ Key? key,
    this.preferredSize = const Size.fromHeight(kToolbarHeight),
    this.titleText = "",
    this.showAccountIcon = false,
    this.showMenuIcon = false,
    this.showBackButton = true,
    this.rightItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget leftWidget = Icon(Icons.add, color: Colors.transparent);
    Widget rightWidget = Icon(Icons.add, color: Colors.transparent);

    if (showMenuIcon == true) {

      leftWidget = MenuItem(didTapAction: (){
        setCollapsed(!_isCollapsed);
      });
      // leftWidget = InkWell(
      //   child: AnimatedIcon(
      //       progress: _animationController,
      //       icon: AnimatedIcons.menu_arrow
      //   ),
      //   onTap: (){
      //     _isCollapsed = !_isCollapsed;
      //     Get.find<MenuController>().setCollapsed(_isCollapsed);
      //   },
      // );
    }

    if (showAccountIcon! == true){
      rightWidget = IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            //TODO
          },
        );
    } else if (rightItem != null){
      rightWidget = rightItem!;
    }

    SmallText title = SmallText(
        text:titleText,
        color: AppColors.navTextColor,
        size: 16);

    return showMenuIcon == true ? AppBar(
      centerTitle: true,
      title: title,
      backgroundColor: AppColors.navBgColor,
      foregroundColor: AppColors.primaryColor,
      leading: leftWidget ,
      actions: [rightWidget],
    ) : AppBar(
      centerTitle: true,
      title: title,
      backgroundColor: AppColors.navBgColor,
      foregroundColor: AppColors.primaryColor,
      actions: [rightWidget],
    );
  }

  Future<void> setCollapsed(bool collapsed) async {
    _isCollapsed = collapsed;
    Get.find<MenuController>().setCollapsed(collapsed);
  }
}

class MenuItem extends StatefulWidget {
  final void Function()? didTapAction;

  const MenuItem({Key? key, this.didTapAction}) : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with TickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 450));

    return Container(
      child: InkWell(
        child: AnimatedIcon(
            progress: _animationController,
            icon: AnimatedIcons.menu_close
        ),
        onTap: (){
          _isPlaying = !_isPlaying;
          if (widget.didTapAction != null) {
            widget.didTapAction!();
          }
          _isPlaying
              ? _animationController.forward()
              : _animationController.reverse();

        },
      ),
    );
  }
}
