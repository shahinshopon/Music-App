// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/ui/views/bottom_nav_controller/favourite.dart';
import 'package:music_app/ui/views/bottom_nav_controller/home_filled.dart';
import 'package:music_app/ui/views/bottom_nav_controller/profile.dart';
import 'package:music_app/ui/views/bottom_nav_controller/speaker.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final _pages = [
    HomeFilledScreen(),
    FavouriteScreen(),
    
    ProfileScreen()
  ];
  RxInt _currentIndex = 0.obs;
  // exit dialog
  Future _exitDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Close this app?"),
            content: Row(
              children: [
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: Text("No"),
                ),
                SizedBox(
                  width: 20.w,
                ),
                ElevatedButton(
                  onPressed: () => SystemNavigator.pop(),
                  child: Text("Yes"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _exitDialog(context);
        return Future.value(false);
      },
      child: Scaffold(
        bottomNavigationBar: Card(
          elevation: 4,
          child: BottomNavigationBar(
               
            showUnselectedLabels: false,
            showSelectedLabels: false,
            
            items: [
              BottomNavigationBarItem(
               
                  icon: Icon(
                    Icons.home_filled,
                    color: Get.isDarkMode == true ? Colors.white : Colors.black,
                  ),
                  label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.favorite_outline,
                    color: Get.isDarkMode == true ? Colors.white : Colors.black,
                  ),
                  label: ""),
             
              BottomNavigationBarItem(
                  icon: Icon(Icons.person,
                      color:
                          Get.isDarkMode == true ? Colors.white : Colors.black),
                  label: ""),
            ],
            currentIndex: _currentIndex.toInt(),
            onTap: (Index) {
              _currentIndex.value = Index;
            },
          ),
        ),
        body: Obx(() => _pages[_currentIndex.toInt()]),
      ),
    );
  }
}
