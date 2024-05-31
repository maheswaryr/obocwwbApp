///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_application_details_1_form.dart';

import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_payment_details_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

class ApplicantDeclarationForm extends StatefulWidget {
  const ApplicantDeclarationForm({Key? key}) : super(key: key);

  @override
  ApplicantDeclarationFormState createState() =>
      ApplicantDeclarationFormState();
}

class ApplicantDeclarationFormState extends State<ApplicantDeclarationForm> {
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
                  child: MyWidget().card10ApplicationDetails()),
            ),
            //Save, Submit, Preview- Button
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //Save- Button
                  MyCustomButton()
                      .getButton(StringsEn().save, Colors.white, Colors.blue),
                  //Submit- Button
                  MyCustomButton().getButton(
                      StringsEn().submit, Colors.white, Colors.green),
                  //Preview- Button
                  MyCustomButton().getButton(
                      StringsEn().preview, Colors.white, Colors.orange),
                ],
              ),
            ),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantPaymentsDetailsForm(),
              ApplicantApplicationDetails1Form(),
              "10",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Declarations
  card10ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().declarations),
            SizedBox(height: 10.0),
            //declaration 1
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: MyCustomText().textWithoutFontWeight(
                    "I hereby declare that I have not been enrolled my name in any other district/state as beneficiary under Building & Other Construction Worker Worker [RE & CS] Rule 2002.",
                    Colors.black)),
            //declaration 2
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: MyCustomText().textWithoutFontWeight(
                    "I hereby declare that I am not an registered number of EPFO & ESIC.",
                    Colors.black)),
            //declaration 3
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: MyCustomText().textWithoutFontWeight(
                    "I hereby declare that I am not a member of any of the welfare fund established under any law for the time being in force [U/S 264 of OB&OCW (RE & CS)] Rule 2002.",
                    Colors.black)),
            ////declaration 4
            Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: MyCustomText().textWithoutFontWeight(
                    "I hereby declare that the particular given above are true to the best of my knowledge & belief.",
                    Colors.black)),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
