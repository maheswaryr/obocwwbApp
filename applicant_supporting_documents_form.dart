///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/supporting_documents_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_bank_details_form.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_payment_details_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

class ApplicantSupportingDocumentsForm extends StatefulWidget {
  const ApplicantSupportingDocumentsForm({Key? key}) : super(key: key);

  @override
  ApplicantSupportingDocumentsFormState createState() =>
      ApplicantSupportingDocumentsFormState();
}

class ApplicantSupportingDocumentsFormState
    extends State<ApplicantSupportingDocumentsForm> {
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
                  child: MyWidget().card8ApplicationDetails()),
            ),
            MyCustomText().textInformationSupportingDocument(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantBankDetailsForm(),
              ApplicantPaymentsDetailsForm(),
              "8",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  List<SupportingDocumentDeathBenefitVO> strNomineeDetailsList = [
    SupportingDocumentDeathBenefitVO(
        1, "Bank Passbook Front Page Copy", "abc.pdf", "02-12-1992"),
    SupportingDocumentDeathBenefitVO(
        2, "Passport Size Photo", "abc.pdf", "02-12-1992"),
    SupportingDocumentDeathBenefitVO(
        3, "Aadhaar Card", "abc.pdf", "02-12-1992"),
    SupportingDocumentDeathBenefitVO(
        4, "Signature of Applicant", "abc.pdf", "02-12-1992"),
    SupportingDocumentDeathBenefitVO(
        5, "Employment Certificate", "abc.pdf", "02-12-1992"),
  ];
  //Supporting Documents
  card8ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().supportingDocuments),
            SizedBox(height: 10.0),

            SizedBox(height: 10.0),
            Card(
              elevation: 3,
              child: Column(
                children: [
                  MyCustomHeader()
                      .headerCard(StringsEn().listOfSupportingDocuments),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: strNomineeDetailsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  strNomineeDetailsList[index].id.toString() +
                                      ". ",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        strNomineeDetailsList[index]
                                                .attachment!
                                                .toUpperCase() +
                                            ". ",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            StringsEn().file,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            strNomineeDetailsList[index]
                                                .attachedFile!
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            StringsEn().attachedOn,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            strNomineeDetailsList[index]
                                                .attachedOn!
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.delete_forever_sharp,
                                color: Colors.red),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 31.0),
                        child:
                            new Divider(height: 0.1, color: Colors.grey[600]),
                      );
                    },
                  ),
                ],
              ),
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
                        StringsEn().uploadDocuments,
                        Colors.white,
                        Colors.blue)),
              ],
            ),

            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
