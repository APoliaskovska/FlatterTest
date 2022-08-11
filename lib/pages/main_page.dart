import 'package:flutter/material.dart';
import 'package:sample/constants/constants.dart';
import 'package:sample/pages/profile_page.dart';

import 'cards_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var currentIndex = 0;

  void _onItemTapped(int index) {
    currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _currentPage(currentIndex)
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
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.lightGrayColor,
        backgroundColor: AppColors.secondaryColor,
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _currentPage(int currentIndex) {
    return pages[currentIndex];
  }

  List pages = [
    const CardsPage(),
    const Center(
      child: Text("Page 2"),
    ),
    const Center(
      child: Text("Page 3"),
    ),
    const ProfilePage(),
  ];
}
