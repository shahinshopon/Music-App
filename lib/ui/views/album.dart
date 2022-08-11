// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/albums.dart';
import 'package:music_app/ui/widget/text_field_widget.dart';

class AlbumScreen extends StatelessWidget {
  AlbumScreen({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        title: Text(
          AppString.albums,
          style: AppStyles.BlackTextStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 25.w, right: 25.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchFromField(_searchController, AppString.search),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppString.topAlbums,
                    style: AppStyles.mySmallTextStyle,
                  ),
                  Text(AppString.seeAll, style: AppStyles.smallTextStyle),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 240.h,
                    width: 150.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/alamgir_1.jpg",
                          height: 160.h,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          AppString.lanaBornDie,
                          style: AppStyles.mySmallTextStyle,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 240.h,
                    width: 150.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/alamgir_1.jpg",
                          height: 160.h,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          AppString.theWeeknd,
                          style: AppStyles.mySmallTextStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 240.h,
                    width: 150.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/alamgir_1.jpg",
                          height: 160.h,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          AppString.selenaGomezRare,
                          style: AppStyles.mySmallTextStyle,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 240.h,
                    width: 150.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "assets/images/alamgir_1.jpg",
                          height: 160.h,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          AppString.taylorSwift22,
                          style: AppStyles.mySmallTextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                AppString.recentlyAlbums,
                style: AppStyles.BlackTextStyle,
              ),
              SizedBox(
                height: 15.h,
              ),
              Albums(""),
            ],
          ),
        ),
      ),
    );
  }
}
