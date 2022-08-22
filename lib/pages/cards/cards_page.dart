import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/cards/widgets/card_body.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/main_app_bar.dart';
import 'package:sample/widgets/small_text.dart';

import '../../widgets/error_container.dart';
import 'cards_controller.dart';

class CardsPage extends GetView<CardsController> {
  //scale factor
  //final double _scaleFactor = 0.8;
  //view page height
  final double _height = Dimensions.screenWidth/1.88;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
          titleText: "Cards",
          showAccountIcon: true
      ),
      backgroundColor: AppColors.mainBackgroundColor,
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
          await controller.reloadData();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: Dimensions.heightPadding10),
          child: Obx(() {
            return Column(
              children: [
                SizedBox(
                    height: _height,
                    child:  controller.isLoading ? Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
                        : controller.isLoaded ? PageView.builder(
                      controller: controller.pageController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.cardsList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position);
                        },
                    ) : controller.isLoaded == false && controller.isLoading == false ? ErrorContainer("Error loading cards...\nTry again later", () {
                      controller.reloadData();
                    }) : PageView.builder(
                      controller: controller.pageController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.cardsList.length,
                      itemBuilder: (context, position) {
                        return _buildPageItem(position);
                      },
                    )
                ),
                const SizedBox(height: 20,),
                // ***** Add Menu Items *****
                Column(
                    children: [
                      for (int i=0; i<controller.cardsMenuItems.length; i++)
                        GestureDetector(
                          onTap: (){
                            controller.onMenuItemTapped(i, context);
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: Dimensions.widthPadding10*4,
                                  right: Dimensions.widthPadding10*4,
                                  bottom: Dimensions.widthPadding10),
                              padding: EdgeInsets.only(left: Dimensions.widthPadding15*2),
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                        color: AppColors.shadowColor,
                                        blurRadius: 6.0,
                                        offset: Offset(0,0),
                                        blurStyle: BlurStyle.outer
                                    )
                                  ],
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.radius20/2))
                              ),
                              alignment: Alignment.centerLeft,
                              height: Dimensions.height80,
                              child: SmallText(
                                  text: controller.cardsMenuItems[i].title(),
                                  size: 16)
                          ),
                        )
                    ]
                ),
                TextButton(
                  onPressed: () => throw Exception(),
                  child: const Text("Throw Test Exception"),
                )
              ],
            );
          })
        ),
      ),
    );
  }

  _buildPageItem(int index) {
    // Matrix4 matrix = new Matrix4.identity();
    //
    // final page = controller.currPageValue.floor();
    //
    // if(index==page){
    //   var currScale = 1-(page-index)*(1- _scaleFactor);
    //   var currTrans = _height*(1-currScale)/2;
    //   matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
    //     ..setTranslationRaw(0, currTrans, 0);
    // }else if(index ==page+1){
    //   var currScale = _scaleFactor+(page-index+1)*(1- _scaleFactor);
    //   var currTrans = _height*(1-currScale)/2;
    //   matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
    //     ..setTranslationRaw(0, currTrans, 0);
    // }else if(index ==page-1){
    //   var currScale = 1-(page-index)*(1- _scaleFactor);
    //   var currTrans = _height*(1-currScale)/2;
    //   matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
    //     ..setTranslationRaw(0, currTrans, 0);
    // }else{
    //   var currScale = 0.8;
    //   matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
    //     ..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    // }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child:   GestureDetector(
        child: Align(
          alignment: Alignment.topCenter,
          child: CardBody(controller.cardsList[index]),
        ),
        onTap: (){
          controller.onCardTapped(index);
        },
      ),
    );

    // return Transform(
    //   transform: matrix,
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(horizontal: 0),
    //     child:   GestureDetector(
    //       child: Align(
    //         alignment: Alignment.topCenter,
    //         child: CardBody(controller.cardsList[index]),
    //       ),
    //       onTap: (){
    //         Get.snackbar(
    //           "Test",
    //           "Did tap on card ${controller.cardsList[index].holderName}",
    //           backgroundColor: AppColors.primaryColor,
    //           colorText: Colors.white,
    //           duration: Duration(seconds: 3),
    //         );
    //         controller.onCardTapped(controller.cardsList[index].id);
    //       },
    //     ),
    //   ),
    // );
  }
}
