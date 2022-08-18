import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sample/passcode/passcode_controller.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/small_text.dart';
import 'package:get/get.dart';

class PasscodePage extends  GetView<PasscodeController> {
  static double buttonSize = Dimensions.width50;
  static const buttonColor = Colors.transparent;
  static const iconColor = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          color: Colors.black.withAlpha(70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() {
                return SmallText(text: controller.title, color: Colors.white, size: 18,);
              }),
              SizedBox(height: Dimensions.height20),
              Obx(() {
                return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < controller.inputCount; i++)
                          Container(
                            padding: EdgeInsets.all(Dimensions.widthPadding10),
                            child: Container(
                              height: Dimensions.height20,
                              width: Dimensions.height20,
                              decoration: BoxDecoration(
                                  color: controller.isNumberEntered(i) ? Colors.white : Colors.transparent,
                                  border: Border.all(color: Colors.white),
                                  shape: BoxShape.circle
                              ),
                            ),
                          )
                      ],
                    )
                );
              }),

              //NUMBER PAD

              Column(
                children: [
                  SizedBox(height: Dimensions.height20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // implement the number keys (from 0 to 9) with the NumberButton widget
                    // the NumberButton widget is defined in the bottom of this file
                    children: [
                      NumberButton(
                        number: 1,
                        color: buttonColor,
                        controller: controller,
                      ),
                      NumberButton(
                        number: 2,
                        color: buttonColor,
                        controller: controller,
                      ),
                      NumberButton(
                        number: 3,
                        color: buttonColor,
                        controller: controller,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberButton(
                        number: 4,
                        color: buttonColor,
                        controller: controller,
                      ),
                      NumberButton(
                        number: 5,
                        color: buttonColor,
                        controller: controller,
                      ),
                      NumberButton(
                        number: 6,
                        color: buttonColor,
                        controller: controller,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NumberButton(
                        number: 7,
                        color: buttonColor,
                        controller: controller,
                      ),
                      NumberButton(
                        number: 8,
                        color: buttonColor,
                        controller: controller,
                      ),
                      NumberButton(
                        number: 9,
                        color: buttonColor,
                        controller: controller,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () async {
                          await controller.checkBiometrics();
                        },
                        icon: Icon(
                          Icons.tag_faces,
                          color: iconColor,
                        ),
                        iconSize: Dimensions.width50,
                      ),
                      // this button is used to delete the last number
                      NumberButton(
                        number: 0,
                        color: buttonColor,
                        controller: controller,
                      ),
                      // this button is used to submit the entered value
                      IconButton(
                        onPressed: () => controller.deletePressed(),
                        icon: Icon(
                          Icons.backspace,
                          color: iconColor,
                          size: Dimensions.width50/2,
                        ),
                        iconSize: Dimensions.width50,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NumberButton extends StatelessWidget {
  final int number;
  final Color color;
  final PasscodeController controller;

  const NumberButton({
    Key? key,
    required this.number,
    required this.color,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonSize = Dimensions.width50;
    return Container(
      padding: EdgeInsets.all(Dimensions.widthPadding10*2),
      child: SizedBox(
        width: buttonSize,
        height: buttonSize,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(buttonSize / 2),
            ),
            shadowColor: Colors.transparent,
          ),
          onPressed: () {
            controller.didPassNumber(number.toString());
          },
          child: Center(
            child: Text(
              number.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}