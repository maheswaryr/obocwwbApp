///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_declaration_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

class ApplicantPaymentsDetailsForm extends StatefulWidget {
  const ApplicantPaymentsDetailsForm({Key? key}) : super(key: key);

  @override
  ApplicantPaymentsDetailsFormState createState() =>
      ApplicantPaymentsDetailsFormState();
}

class ApplicantPaymentsDetailsFormState
    extends State<ApplicantPaymentsDetailsForm> {
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
                  child: MyWidget().card9ApplicationDetails()),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantPaymentsDetailsForm(),
              ApplicantDeclarationForm(),
              "9",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Payment details
  card9ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().paymentDetails),
            SizedBox(
              height: 10.0,
            ),
            //Total Amount
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().totalAmount),
            SizedBox(height: 30.0),

            //Pay- Button
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                //Save- Button
                Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: MyCustomButton().getButton(
                        StringsEn().payNow, Colors.white, Colors.green)),
              ],
            ),

            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
