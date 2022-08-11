// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/views/details_screen.dart';


class FavouriteScreen extends StatefulWidget {
  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List _allSongs = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          elevation: 0,
          title: Text(
            AppString.favourite,
            style: AppStyles.BlackTextStyle,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(15.w),
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('Users-Favourite')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .collection("items")
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasError) return Text('Error = ${snapshot.error}');

              if (snapshot.hasData) {
                final docs = snapshot.data!.docs;
                return Container(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: docs.length,
                      itemBuilder: (_, i) {
                        final data = docs[i].data();
                        return Stack(
                          clipBehavior: Clip.none,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(DetailsScreen(data));
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 20.h),
                                child: Container(
                                  height: 100.h,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        data['song-thumbnail'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              top: 25,
                              child: CircleAvatar(
                                child: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        FirebaseFirestore.instance
                                            .collection("Users-Favourite")
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.email)
                                            .collection("items")
                                            .doc(snapshot.data!.docs[i].id)
                                            .delete();
                                      });
                                    }),
                              ),
                            )
                          ],
                        );
                      }),
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}


// Text(
//                 AppString.tracklist,
//                 style: AppStyles.BlackTextStyle,
//               ),
//               TrackList(AppString.bornToDie, AppString.N330),
//               TrackList(AppString.love, AppString.N414),
//               TrackList(AppString.cherry, AppString.N348),
//               TrackList(AppString.summerTime, AppString.N342),
//               TrackList(AppString.young, AppString.N425),
//               TrackList(AppString.bel, AppString.N406),
//               TrackList(AppString.beaches, AppString.N358),
//               TrackList(AppString.bornToDie, AppString.N330),