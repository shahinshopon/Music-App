// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:music_app/ui/views/album.dart';
import 'package:music_app/ui/views/artist_screen.dart';
import 'package:music_app/ui/views/auth/forget_password.dart';
import 'package:music_app/ui/views/auth/login_screen.dart';
import 'package:music_app/ui/views/auth/sign_up.dart';
import 'package:music_app/ui/views/home_screen.dart';
import 'package:music_app/ui/views/playlists.dart';
import 'package:music_app/ui/views/seeAll_recent.dart';
import 'package:music_app/ui/views/seeAll_recommanded.dart';
import 'package:music_app/ui/views/seeAll_top.dart';
import 'package:music_app/ui/views/setting_screen.dart';
import 'package:music_app/ui/views/splash_screen.dart';

const String splash = '/splash-screen';
const String login = '/login-screen';
const String forgetPassword = '/forgetPassword-screen';
const String signUp = '/signUp-screen';
const String home = '/home-screen';
const String artist = '/artist-screen';
const String setting = '/setting-screen';
const String playlist = '/playlist-screen';
const String album = '/album-screen';
const String seeAllRecent = '/seeAll-recent-screen';
const String seeAllRecommanded = '/seeAll-top-screen';
const String seeAllTop = '/seeAll-recommanded-screen';

List<GetPage> getPages = [
  GetPage(
    name: splash,
    page:()=>SplashScreen(),
  ),
  GetPage(
    name: login,
    page:()=>LoginScreen(),
  ),
  GetPage(
    name: forgetPassword,
    page:()=>ForgetPasswordScreen(),
  ),
  GetPage(
    name: signUp,
    page:()=>SignUpScreen(),
  ),
  GetPage(
    name: home,
    page:()=>HomeScreen(),
  ),
  GetPage(
    name: artist,
    page:()=>ArtistScreen(),
  ),
  GetPage(
    name: setting,
    page:()=>SettingScreen(),
  ),
  GetPage(
    name: playlist,
    page:()=>PlaylistScreen(),
  ),
  GetPage(
    name: album,
    page:()=>AlbumScreen(),
  ),
  GetPage(
    name: seeAllRecent,
    page:()=>SeeAllRecent(),
  ),
  GetPage(
    name: seeAllRecommanded,
    page:()=>SeeAllRecommanded(),
  ),
  GetPage(
    name: seeAllTop,
    page:()=>SeeAllTop(),
  ),
 
];