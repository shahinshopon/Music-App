import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:music_app/ui/styles/styles.dart';

class Albums extends StatelessWidget {
  String title;
  Albums(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (_, index) {
            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: Container(
                height: 180.h,
                width: 100.w,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/images/alamgir_1.jpg",
                      height: 150.h,
                      fit: BoxFit.cover,
                    ),
                    Text(title,style:AppStyles.smallTextStyle,)
                  ],
                ),
              ),
            );
          }),
    );
  }
}

