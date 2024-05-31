///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_supporting_documents_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

import 'applicant_other_details_form.dart';

class ApplicantBankDetailsForm extends StatefulWidget {
  const ApplicantBankDetailsForm({Key? key}) : super(key: key);

  @override
  ApplicantBankDetailsFormState createState() =>
      ApplicantBankDetailsFormState();
}

class ApplicantBankDetailsFormState extends State<ApplicantBankDetailsForm> {
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
                  child: MyWidget().card7ApplicationDetails()),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantOtherDetails1Form(),
              ApplicantSupportingDocumentsForm(),
              "7",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Bank details
  card7ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().bankDetails),
            SizedBox(height: 10.0),
            //Bank Name
            MyCustomDropdown().dropDown(StringsEn().bankName),
            //Name of Branch
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().enterYourNameOfBranch),
            //IFSC

            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().enterYourIFSC),
            //Aadhaar Linked Bank Account Number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().aadhaarLinkedBankAccountNumber),
            //Confirm bank account number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().confirmBankAccountNumber),
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
