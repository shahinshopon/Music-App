// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/const/app_colors.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/widget/playlist.dart';
import 'package:music_app/ui/widget/text_field_widget.dart';

class PlaylistScreen extends StatelessWidget {
  PlaylistScreen({Key? key}) : super(key: key);
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 
      appBar: AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    automaticallyImplyLeading: true,
    elevation: 0,
    title: Text(
      AppString.myPlaylist,
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
            height: 15.h,
          ),
          Text(
            AppString.tracklist,
            style: AppStyles.BlackTextStyle,
          ),
          Playlist(AppString.bornToDie, AppString.lanaDelRey),
          Playlist(AppString.happy, AppString.selenaGomez),
          Playlist(AppString.america, AppString.xylo),
          Playlist(AppString.doYouRemember,AppString.james),
          Playlist(AppString.twentyTwo,AppString.taylorSwift),
          Playlist(AppString.yello,AppString.coldPlay),
          Playlist(AppString.hotCold,AppString.perry)
        ],
      ),
    ),
      ),
    );
  }
}
