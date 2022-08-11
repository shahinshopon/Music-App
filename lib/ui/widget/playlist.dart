import 'package:flutter/material.dart';
import 'package:music_app/ui/styles/styles.dart';

class Playlist extends StatelessWidget {
  String title;
  String titles;
  Playlist(this.title,this.titles);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(""),
        ),
        title: Text(
         title,
          style: AppStyles.mySmallTextStyle,
        ),
        subtitle: Text(
         titles,
          style: AppStyles.mySmallTextStyle,
        ),
      ),
    );
  }
}
