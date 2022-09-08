import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';

import 'package:sample/pages/onboarding/onboarding_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/big_text.dart';
import 'package:sample/widgets/small_text.dart';

class OnboardingPage extends GetView<OnboardingController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: controller.items.length,
                    onPageChanged: (index) {
                      controller.indexChanged(index);
                    },
                    itemBuilder: (context, index) =>
                        OnboardingContent(
                            image: controller.items[index].image,
                            title: controller.items[index].title,
                            description: controller.items[index].description
                        )
                ),
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Row(
                children: [
                  ...List.generate(controller.items.length, (index) =>
                      Padding(
                        padding: EdgeInsets.only(right: 4),
                        child: Obx(() {
                          return DotIndicator(
                              isActive: index == controller.pageIndex);
                        }),
                      )),
                  const Spacer(),
                  Obx(() {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      child: SizedBox(
                        width: controller.lastPage ? 100 : Dimensions.width50,
                        height: Dimensions.width50,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.onTapNextButton();
                          },
                          style: ElevatedButton.styleFrom(
                              shape: controller.lastPage ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.width50/2)) : CircleBorder(),
                              backgroundColor: AppColors.primaryColor
                          ),
                          child: controller.lastPage ? SmallText(
                            text: "Start",
                            color: Colors.white) : Icon(Icons.navigate_next),
                          //child: Svg,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
          color: isActive ? AppColors.primaryColor : AppColors.primaryColor
              .withOpacity(0.4),
          borderRadius: BorderRadius.all(Radius.circular(13))
      ),
    );
  }

}

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Image.asset(image),
          BigText(
            text: title,
            textAlign: TextAlign.center,
            lineCount: 3,
          ),
          const Spacer(),
          SmallText(
            text: description,
            textAlign: TextAlign.center,
            lineCount: 3,
          ),
          const Spacer()
        ]
    );
  }
}

