import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/menu/settings/settings_controller.dart';
import 'package:sample/service/localization_service.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/main_app_bar.dart';

import '../../../constants/localization_keys.dart';
import '../../../widgets/small_text.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        titleText: Strings.settings.translate(),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.widthPadding15),
        child: Container(
          child: Column(
            children: [
              SizedBox(height: Dimensions.height10,),
              _buildLanguageList(),
              SizedBox(height: Dimensions.height15,),
              _settingsTitle(Strings.security_item.translate(), Icons.security),
              SizedBox(height: 20,),
              _settingsItem(Strings.show_passcode.translate(), Icons.password_outlined, true, true),
              _settingsItem(Strings.enable_face_id.translate(), Icons.tag_faces_outlined, true, true)
            ],
          ),
        ),
      ),
    );
  }

  Widget _settingsTitle(String text, IconData icon) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 15),
            Icon(icon, color: AppColors.primaryColor,),
            SizedBox(width: 30),
            SmallText(
              text: text,
              fontType: FontType.medium,
              size: 16,)
          ],
        ),
        SizedBox(height: Dimensions.height15),
        Container(
            color: Colors.black12,
            height: 1.0,
            margin: EdgeInsets.only(
                left: Dimensions.widthPadding15,
                right: Dimensions.widthPadding15
            )
        )
      ],
    );
  }

  Widget _settingsItem(String text, IconData icon, bool showSwitch, bool? state) {
    return GestureDetector(
      onTap: () {
        //onTapAction
      },
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 15),
              Icon(icon),
              SizedBox(width: 30),
              SmallText(
                text: text,
                size: 16,
              ),
              Spacer(),
              showSwitch ? Switch(value: state ?? false, onChanged: (value){

              }) : Container()
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageList() {
    List<Language> list = controller.appLanguages;
    return Obx(() {
      return ExpansionTile(
          leading: Icon(Icons.language, color: AppColors.primaryColor),
          title: SmallText(
            text: Strings.language.translate() + " " + controller.currentLanguage.langName,
            color: Colors.black,
            size: 16,
          ),
          children: [
            for (int i = 0; i < list.length; i++)
              GestureDetector(
                onTap: () {
                  controller.didChangeLanguage(list[i]);
                },
                child: Container(
                  padding: EdgeInsets.all(Dimensions.heightPadding10),
                  child: Row(
                    children: [
                      SizedBox(width: Dimensions.widthPadding10),
                      Text(list[i].flag),
                      SizedBox(width: Dimensions.widthPadding10,),
                      SmallText(
                        text: list[i].langName,
                        size: 16,
                        color: list[i] == controller.currentLanguage ? AppColors.primaryColor : Colors.black ),
                    ],
                  ),
                ),
              )
          ]
      );
    });
  }
}