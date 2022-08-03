import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/controllers/main_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}



class _MainPageState extends StateMVC {
  MainController? _controller;

  _MainPageState() : super(MainController()) {
    _controller = MainController.controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _controller!.currentPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Page 3',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Page 4',
          ),
        ],
        currentIndex: _controller!.currentIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.lightGrayColor,
        backgroundColor: AppColors.secondaryColor,
        onTap: (index){
          setState(() {
            _controller!.currentIndex = index;
          });
        },
      ),
    );
  }
}
