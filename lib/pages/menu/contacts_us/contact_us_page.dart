import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/menu/contacts_us/contact_us_controller.dart';
import 'package:get/get.dart';
import 'package:sample/widgets/small_text.dart';

import '../../../constants/localization_keys.dart';
import '../../../utils/dimensions.dart';
import '../../../widgets/main_app_bar.dart';

class ContactUsPage extends GetView<ContactUsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
          showMenuIcon: false,
          titleText: Strings.contact_us_title.translate()
      ),
      body: Container(
        width: Dimensions.screenWidth,
        padding: EdgeInsets.all(Dimensions.widthPadding15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
                "assets/images/logo.png",
                width: Dimensions.width50*2,),
            SizedBox(height: Dimensions.height15),
            SmallText(
              text: Strings.contact_us_text.translate(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Dimensions.height20),
            _contactButton("Email", Icons.email_outlined, () async {
              await controller.didTapSendEmail();
            }),
            SizedBox(height: Dimensions.height20),
            _contactButton("Website", Icons.web_sharp, () async {
              await controller.didTapWebsite();
            }),
            SizedBox(height: Dimensions.height20),
            _contactButton("+41 123 4333 123", Icons.phone, () async{
               controller.didTapCall();
            }),
            SizedBox(height: Dimensions.height20),
          ],
        ),
      ),
    );
  }

  Widget _contactButton(String title, IconData icon, void Function() didTap){
    return InkWell(
      onTap: (){
        didTap();
      },
      child: Container(
        padding: EdgeInsets.all(Dimensions.widthPadding15),
        height: Dimensions.height80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.height80/2),
          color: AppColors.secondaryTextColor
        ),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: Dimensions.widthPadding15),
                Icon(icon, color: Colors.white,),
                Spacer(),
                //SizedBox(width: Dimensions.widthPadding15,),
                SmallText(
                  text: title,
                  color: Colors.white
                ),
                SizedBox(width: Dimensions.widthPadding15*2),
                Spacer(),
              ],
            ),
        ),
      ),
    );
  }
}