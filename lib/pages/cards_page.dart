import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/controllers/cards_controller.dart';
import 'package:sample/pages/components/card_body.dart';
import 'package:sample/utils/dimensions.dart';
import 'package:sample/widgets/main_app_bar.dart';
import 'package:sample/widgets/small_text.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  State<CardsPage> createState() => _CardsPageState();
}

class _CardsPageState extends State<CardsPage> {
  //scale factor
  final double _scaleFactor = 0.8;
  //view page height
  final double _height = Dimensions.screenWidth/1.88;
  var _currPageValue = 0.0;

  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
          titleText: "Cards",
          showAccountIcon: true
      ),
      backgroundColor: AppColors.mainBackgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: Dimensions.heightPadding10),
        child: GetBuilder<CardsController>(builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: _height,
              child: controller.isLoading ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(color: AppColors.primaryColor,)
              )
              : controller.isLoaded ? PageView.builder(
                controller: pageController,
                physics: BouncingScrollPhysics(),
                itemCount: controller.cardsList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(position);},
              ) : _errorWidget(),
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
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.shadowColor,
                                    blurRadius: 6.0,
                                    offset: const Offset(0,0),
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
            )
           ],
          );
        })
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();

    if(index==_currPageValue.floor()){
      var currScale = 1-(_currPageValue-index)*(1- _scaleFactor );
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    }else if(index ==_currPageValue.floor()+1){
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1- _scaleFactor );
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    }else if(index ==_currPageValue.floor()-1){
      var currScale = 1-(_currPageValue-index)*(1- _scaleFactor );
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    }else{
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }

    return Transform(
      transform: matrix,
      child: GetBuilder<CardsController>(builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child:   GestureDetector(
              child: Align(
                alignment: Alignment.topCenter,
                child: CardBody(controller.cardsList[index]),
              ),
              onTap: (){
                Get.snackbar(
                  "Test",
                  "Did tap on card " + controller.cardsList[index].holderName!,
                  backgroundColor: AppColors.primaryColor,
                  colorText: Colors.white,
                  duration: Duration(seconds: 3),
                );
                controller.onCardTapped(controller.cardsList[index].id!);
              },
            ),
          );
        }
      ),
    );
  }

  Widget _errorWidget (){
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SmallText(
              text: "Error loading cards...\nTry again later",
              color: Colors.red,
              textAlign: TextAlign.center),
          IconButton(icon: const Icon(Icons.update),
            color: AppColors.primaryColor,
            onPressed: () {
              CardsController controller = Get.find<CardsController>();
              controller.getCardModelList();
              controller.update();
            },
          )
        ],
      ),
    );
  }
}
