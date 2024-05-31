///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';

import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_application_details_2_form.dart';
import 'package:obocwwb/strings_en.dart';

import 'applicant_declaration_form.dart';

class ApplicantApplicationDetails1Form extends StatefulWidget {
  const ApplicantApplicationDetails1Form({Key? key}) : super(key: key);

  @override
  ApplicantApplicationDetails1FormState createState() =>
      ApplicantApplicationDetails1FormState();
}

class ApplicantApplicationDetails1FormState
    extends State<ApplicantApplicationDetails1Form> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsEn().applicantApplication),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: MyWidget().card1ApplicationDetails()),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantDeclarationForm(),
              ApplicantApplicationDetails2Form(),
              "1",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //application details
  card1ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().applicationDetails),
            SizedBox(height: 10.0),
            Row(
              children: [
                MyCustomText().textWithPadding(
                    StringsEn().areYouAaRegisteredMember, Colors.black),
                MyCustomText().textWithoutPadding("*", Colors.red),
              ],
            ),
            Row(
              children: [
                MyCustomButton()
                    .getButton(StringsEn().yes, Colors.white, Colors.green),
                MyCustomButton()
                    .getButton(StringsEn().no, Colors.white, Colors.red),
              ],
            ),
            SizedBox(height: 30.0),

            //Save, Update- Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Save- Button
                Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: MyCustomButton().getButton(
                        StringsEn().save, Colors.white, Colors.blue)),
              ],
            ),

            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
