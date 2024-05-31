///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_bank_details_form.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_details_of_the_establishments_where_%20the_applicant_worked_durning_last_one_year_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

class ApplicantOtherDetails1Form extends StatefulWidget {
  const ApplicantOtherDetails1Form({Key? key}) : super(key: key);

  @override
  ApplicantOtherDetails1FormState createState() =>
      ApplicantOtherDetails1FormState();
}

class ApplicantOtherDetails1FormState
    extends State<ApplicantOtherDetails1Form> {
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
                  child: MyWidget().card6ApplicationDetails()),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearForm(),
              ApplicantBankDetailsForm(),
              "6",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Other details
  card6ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().otherDetails),
            SizedBox(height: 10.0),
            //Ration Card Details
            MyCustomDropdown().dropDown(StringsEn().rationCardDetails),
            //NFSA or SFSS Card No. (If available)
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().nFSAOrSFSSCardNoIfAvailable),
            //Category
            MyCustomDropdown().dropDown(StringsEn().category),
            //Religion
            MyCustomDropdown().dropDown(StringsEn().religion),
            //Physically challenged
            MyCustomDropdown().dropDown(StringsEn().physicallyChallenged),

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
