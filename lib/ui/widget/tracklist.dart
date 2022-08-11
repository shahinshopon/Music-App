import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/styles/styles.dart';

class TrackList extends StatelessWidget {
String title;
String titles;
TrackList(this.title,this.titles);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(15.w),
      elevation: 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: AppStyles.mySmallTextStyle,),
          Text(titles,style: AppStyles.mySmallTextStyle,),
        ],
      ),
    );
  }
}
