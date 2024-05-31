///Updated on 19/12/2022 by Arsha

import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';

import 'package:obocwwb/obocwwb_ui/application_for_registration/application_details.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';

import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness:
      Platform.isAndroid && !kIsWeb ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringsEn().appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  Scaffold(
          body: SafeArea(
            top: false,
            bottom: false,
            child: SplashScreen(),
          )),
      builder: EasyLoading.init(),
    );
  }
}
class SplashScreen extends StatefulWidget {

   SplashScreen({Key? key,}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {





  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Center(
       child: Image.asset(
         'assets/images/app_logo.png',
       ),
     ),
   );
  }
  startTime() async {
    var _duration = new Duration(seconds: 3);

    return Timer(_duration, _navigateToHome);
  }
  late AnimationController animationController;

  void initState() {
    super.initState();
    startTime();
    animationController =  AnimationController(
      duration: new Duration(seconds: 2), vsync: this,
    );
    animationController.repeat();
  }

  @override
  dispose() {
    animationController.dispose(); // you need this
    super.dispose();
  }


  void _navigateToHome() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    String? status = preferences.getString("status");

    if (token != null) {
      if(status == "I") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => /*HomePage*/ ApplicationDetails()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignInScreen()));

    }
  }
}
