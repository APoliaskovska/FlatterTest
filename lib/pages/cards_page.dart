import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/controllers/cards_controller.dart';
import 'package:sample/models/card.dart';
import 'package:sample/pages/components/card_body.dart';
import 'package:sample/utils/dimensions.dart';

class CardsPage extends StatefulWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  _CardsPageState createState() => _CardsPageState();
}

class _CardsPageState extends StateMVC {
  CardsController? _controller;

  _CardsPageState() : super(CardsController()) {
    _controller = CardsController.controller;
  }

  //scale factor
  double _scaleFactor = 0.8;
  //view page height
  double _height = (Dimensions.screenWidth - Dimensions.widthPadding15*2)/1.88;

  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState(){
    super.initState();
    pageController.addListener(() {
      setState(() {
        _controller!.currPageValue =  pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor,
          title: Text("Cards")
      ),
      backgroundColor: AppColors.mainBackgroundColor,
      body: Container(
        child: PageView.builder(
          controller: pageController,
          physics: BouncingScrollPhysics(),
          itemCount: cardsList.length,
          itemBuilder: (context, position) {
            return _buildPageItem(position);},
        ),
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

    if(index==_controller!.currPageValue.floor()){
      var currScale = 1-(_controller!.currPageValue-index)*(1- _scaleFactor );
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    }else if(index ==_controller!.currPageValue.floor()+1){
      var currScale = _scaleFactor+(_controller!.currPageValue-index+1)*(1- _scaleFactor );
      var currTrans = _height*(1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1.0, currScale, 1.0)
        ..setTranslationRaw(0, currTrans, 0);
    }else if(index ==_controller!.currPageValue.floor()-1){
      var currScale = 1-(_controller!.currPageValue-index)*(1- _scaleFactor );
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child:   GestureDetector(
          child: Align(
            alignment: Alignment.topCenter,
            child: CardBody(cardsList[index]),
          ),
          onTap: (){
            Get.snackbar(
              "Test",
              "Did tap on card " + cardsList[index].holderName,
              backgroundColor: AppColors.primaryColor,
              colorText: Colors.white,
              duration: Duration(seconds: 3),
            );
            _controller!.onCardTapped(cardsList[index].id);
          },
        ),
      ),
    );
  }
}
