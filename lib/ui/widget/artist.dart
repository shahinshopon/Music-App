import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Artist extends StatelessWidget {

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
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    "assets/images/alamgir_1.jpg",
                  ),
                ),
                ),
            );
          }),
    );
  }
}

