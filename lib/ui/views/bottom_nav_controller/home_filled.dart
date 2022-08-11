// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/route/route.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/views/auth/auth_helper.dart';
import 'package:music_app/ui/views/details_screen.dart';
import 'package:music_app/ui/widget/albums.dart';
import 'package:music_app/ui/widget/artist.dart';
import 'package:music_app/ui/widget/drawer_item.dart';

class HomeFilledScreen extends StatelessWidget {
  HomeFilledScreen({Key? key}) : super(key: key);
  final box = GetStorage();

  List _allSongs = [];

  Future logOut(context) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Are you sure want to logout?"),
              content: Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut().then(
                            (value) => Fluttertoast.showToast(
                                msg: "Logout Successfull."),
                          );
                      await box.remove('uid');
                      Get.toNamed(splash);
                    },
                    child: const Text("Yes"),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text("No"),
                  ),
                ],
              ),
            ));
  }

  TextEditingController numberController = TextEditingController();
  String countryDial = "+880";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(
            AppString.welcomeSky,
            style: AppStyles.BlackTextStyle,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.h, left: 20.w, right: 20.w),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///////
                SizedBox(height: 30),
                TextField(
                  controller: numberController,
                ),
                ElevatedButton(
                    onPressed: () {
                      AuthHelper().phoneAuth(countryDial+numberController.text, context);
                    },
                    child: Text("Continue")),

                ////////////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.recentlyPlayed,
                      style: AppStyles.mySmallTextStyle,
                    ),
                    InkWell(
                        onTap: () {
                          Get.toNamed(seeAllRecent);
                        },
                        child: Text(AppString.seeAll,
                            style: AppStyles.smallTextStyle)),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('all-songs')
                        .where('recent', isEqualTo: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return Container(
                          height: 250.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(DetailsScreen(data));
                                    },
                                    child: Container(
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          data['song-thumbnail'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.top,
                      style: AppStyles.mySmallTextStyle,
                    ),
                    InkWell(
                        onTap: () {
                          Get.toNamed(seeAllTop);
                        },
                        child: Text(AppString.seeAll,
                            style: AppStyles.smallTextStyle)),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection('all-songs')
                        .where('top', isEqualTo: true)
                        .snapshots(),
                    builder: (_, snapshot) {
                      if (snapshot.hasError)
                        return Text('Error = ${snapshot.error}');

                      if (snapshot.hasData) {
                        final docs = snapshot.data!.docs;
                        return Container(
                          height: 250.h,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: docs.length,
                              itemBuilder: (_, i) {
                                final data = docs[i].data();
                                return Padding(
                                  padding: EdgeInsets.only(right: 10.w),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(DetailsScreen(data));
                                    },
                                    child: Container(
                                      width: 200.w,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          data['song-thumbnail'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }

                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.recommanded,
                      style: AppStyles.mySmallTextStyle,
                    ),
                    InkWell(
                        onTap: () {
                          Get.toNamed(seeAllRecommanded);
                        },
                        child: Text(AppString.seeAll,
                            style: AppStyles.smallTextStyle)),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('all-songs')
                      .where('recommanded', isEqualTo: true)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasError)
                      return Text('Error = ${snapshot.error}');

                    if (snapshot.hasData) {
                      final docs = snapshot.data!.docs;
                      return Container(
                        height: 250.h,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: docs.length,
                            itemBuilder: (_, i) {
                              final data = docs[i].data();
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(DetailsScreen(data));
                                  },
                                  child: Container(
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        data['song-thumbnail'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          backgroundColor: AppColors.blueAccent,
          child: Padding(
            padding: EdgeInsets.only(
                top: 100.h, left: 30.w, right: 30.w, bottom: 100.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // InkWell(
                    //   onTap: () => Get.toNamed(playlist),
                    //   child: Text(
                    //     AppString.playlist,
                    //     style: AppStyles.myTextStyle,
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () => Get.toNamed(album),
                    //   child: Text(
                    //     AppString.album,
                    //     style: AppStyles.myTextStyle,
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () => Get.toNamed(artist),
                    //   child: Text(
                    //     AppString.artist,
                    //     style: AppStyles.myTextStyle,
                    //   ),
                    // ),
                  ],
                )),
                Expanded(child: Container()),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 30.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      drawerItem(Icons.settings, AppString.setting,
                          () => Get.toNamed(setting)),
                      drawerItem(
                        Icons.logout_outlined,
                        AppString.logout,
                        () => logOut(context),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
