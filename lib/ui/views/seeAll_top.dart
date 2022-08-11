import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_app/const/app_string.dart';
import 'package:music_app/ui/styles/styles.dart';
import 'package:music_app/ui/views/details_screen.dart';

class SeeAllTop extends StatelessWidget {
  const SeeAllTop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title:Text(
                AppString.top,
                style: AppStyles.mySmallTextStyle,
              ) ,centerTitle: true,
              
        ),
        body: Padding(
          padding: EdgeInsets.all(12.h),
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
                    return GridView.builder(
                        scrollDirection: Axis.vertical,
                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     mainAxisSpacing: 20,crossAxisSpacing: 20
                     ),
                        itemCount: docs.length,
                        itemBuilder: (_, i) {
                          final data = docs[i].data();
                          return InkWell(
                             onTap: () {
                                Get.to(DetailsScreen(data));
                              },
                            child: Container(
                              width: 200.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                              ),
                             
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(data['song-thumbnail'],fit: BoxFit.fill,)),
                            ),
                          );
                        });
                  }
          
                  return Center(child: CircularProgressIndicator());
                },
              ),
        ),
      ),
    );
  }
}
