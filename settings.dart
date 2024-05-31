///Created by Maheswary
///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/choose_language.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_card/custom_card.dart';
import 'package:obocwwb/obocwwb_ui/home/applied_benefits.dart';
import 'package:obocwwb/obocwwb_ui/profile_page/profile_page_form.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: AppColor.primaryColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
      children: [
        MyCustomCard().customCard(context,'Notification', 'Enabled',Icons.notifications_active,Colors.green, AppliedBenefits()),
        MyCustomCard().customCard(context,'Language', 'English',Icons.language_sharp,Colors.deepPurple, ChooseLanguage()),
        MyCustomCard().customCard(context,'Font Size', 'Normal',Icons.font_download_rounded,Colors.pink, ChooseLanguage()),
        MyCustomCard().customCard(context,'Account Settings', 'Manage your profile',Icons.person_sharp,Colors.yellow, ProfilePageForm()),
      ],),
    );
  }
}
