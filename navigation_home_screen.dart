///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_drawer/drawer_user_controller.dart';
import 'package:obocwwb/home_drawer.dart';
import 'package:obocwwb/home_page.dart';

class NavigationHomeScreen extends StatefulWidget {
  const NavigationHomeScreen({Key? key}) : super(key: key);

  @override
  _NavigationHomeScreenState createState() => _NavigationHomeScreenState();
}

class _NavigationHomeScreenState extends State<NavigationHomeScreen> {
  Widget screenView = MyHomePage();
  DrawerIndex drawerIndex = DrawerIndex.home;

  @override
  Widget build(BuildContext context) {
    return DrawerUserController(
      screenIndex: drawerIndex,
      drawerWidth: MediaQuery.of(context).size.width * 0.75,
      onDrawerCall: (DrawerIndex drawerIndexdata) {
        changeIndex(drawerIndexdata);
        //callback from drawer for replace screen as user need with passing DrawerIndex(Enum index)
      },
      screenView: screenView,
      //we replace screen view as we need on navigate starting screens like MyHomePage, HelpScreen, FeedbackScreen, etc...
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      if (drawerIndex == DrawerIndex.home) {
        if (mounted) {
          setState(() {
            screenView = MyHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.help) {
        if (mounted) {
          setState(() {
            screenView = const MyHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.feedback) {
        if (mounted) {
          setState(() {
            screenView = const MyHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.invite) {
        if (mounted) {
          setState(() {
            screenView = const MyHomePage();
          });
        }
      } else if (drawerIndex == DrawerIndex.about) {
        if (mounted) {
          setState(() {
            // screenView = const AboutScreen();
          });
        }
      }
    }
  }
}