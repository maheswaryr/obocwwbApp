///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_address_details_form.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_application_details_1_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

class ApplicantApplicationDetails2Form extends StatefulWidget {
  const ApplicantApplicationDetails2Form({Key? key}) : super(key: key);

  @override
  ApplicantApplicationDetails2FormState createState() =>
      ApplicantApplicationDetails2FormState();
}

class ApplicantApplicationDetails2FormState
    extends State<ApplicantApplicationDetails2Form> {
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
                  child: MyWidget().card2ApplicationDetails(context)),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantApplicationDetails1Form(),
              ApplicantAddressDetailsForm(),
              "2",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Date of Birth
  TextEditingController _textDateOfBirthController = TextEditingController();

  //application details
  card2ApplicationDetails(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().applicationDetails),
            SizedBox(height: 10.0),
            //First Name
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().firstName),

            //Surname
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().surName),

            //Sex
            MyCustomDropdown().dropDown(StringsEn().sex),

            //Aadhaar Linked Mobile Number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().aadhaarLinkedMobileNumber),

            //Aadhaar Number
            MyCustomTextField().textWithTextField(
                TextInputType.number, StringsEn().aadhaarNumber),

            //Date of Birth
            MyCustomTextField().textWithTextControllerDateTextField(context,
                StringsEn().dateOfBirth, _textDateOfBirthController, true),

            //Father Name
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().fatherName),

            //Martial Status
            MyCustomDropdown().dropDown(StringsEn().maritalStatus),

            //Spouse's Name
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().spouseName),

            //Nature of work
            MyCustomDropdown().dropDown(StringsEn().natureOfWork),

            //Educational details
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().educationalDetails),

            //Training details (if any)
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().trainingDetailsIfAny),

            //Are you a migrant worker ?
            Row(
              children: [
                MyCustomText()
                    .textWithPadding(StringsEn().migrantWorker, Colors.black),
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
