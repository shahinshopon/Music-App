// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/albums.dart';
import 'package:music_app/ui/widget/text_field_widget.dart';

class ArtistScreen extends StatelessWidget {
  ArtistScreen({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 40.h,left: 30.w,right: 30.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text(AppString.artists,style:AppStyles.BlackTextStyle,),
              SizedBox(height: 20.h,),
              SearchFromField(_searchController,AppString.search),
              SizedBox(height: 30.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text(AppString.worldwide,style:AppStyles.BlackTextStyle,),
                Text(AppString.seeAll,style:AppStyles.smallTextStyle,),
              ],),
              SizedBox(height: 15.h,),
              Albums(""),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.ukText,style:AppStyles.BlackTextStyle,),
                  Text(AppString.seeAll,style:AppStyles.smallTextStyle,),
                ],),
              SizedBox(height: 15.h,),
              Albums(AppString.taylorSwift),
              SizedBox(height: 15.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppString.singapore,style:AppStyles.BlackTextStyle,),
                  Text(AppString.seeAll,style:AppStyles.smallTextStyle,),
                ],),
              SizedBox(height: 15.h,),
              Albums(AppString.blackPink),
            ],
          ),
        ),
      ),
    );
  }
}
