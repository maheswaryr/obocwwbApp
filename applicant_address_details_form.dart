///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';
import 'applicant_application_details_2_form.dart';

import 'applicant_family&nominee_details_form.dart';

class ApplicantAddressDetailsForm extends StatefulWidget {
  const ApplicantAddressDetailsForm({Key? key}) : super(key: key);

  @override
  ApplicantAddressDetailsFormState createState() =>
      ApplicantAddressDetailsFormState();
}

class ApplicantAddressDetailsFormState
    extends State<ApplicantAddressDetailsForm> {
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
                  child: MyWidget().card3ApplicationDetails()),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantApplicationDetails2Form(),
              ApplicantFamilyNomineeDetailsForm(),
              "3",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Address details
  card3ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().addressDetails),

            MyCustomHeader().headerCard(StringsEn().permanentAddress),
            //Address
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().address),

            //State
            MyCustomDropdown().dropDown(StringsEn().state),

            //District
            MyCustomDropdown().dropDown(StringsEn().district),

            //Block/ULB
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().blockOrUlb),

            //Gram Panchayat
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().gramPanchayat),

            //Village
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().village),

            //Pin code
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().pincode),

            MyCustomHeader().headerCard(StringsEn().presentAddress),

            //declaration 2
            MyCustomText().textAddress(
                StringsEn().checkIfPresentAddressSameAsPermanentAddress,
                Colors.black),

            //Address
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().address),

            //District
            MyCustomDropdown().dropDown(StringsEn().district),

            //Block/ULB
            MyCustomDropdown().dropDown(StringsEn().blockOrUlb),

            //Gram Panchayat
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().blockOrUlb),

            //Village
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().village),

            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().pincode),

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
