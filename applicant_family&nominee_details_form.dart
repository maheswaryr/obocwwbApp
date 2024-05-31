///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/family_details.dart';
import 'package:obocwwb/model/nominee_details.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_address_details_form.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_details_of_the_establishments_where_%20the_applicant_worked_durning_last_one_year_form.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

import 'package:intl/intl.dart';

class ApplicantFamilyNomineeDetailsForm extends StatefulWidget {
  const ApplicantFamilyNomineeDetailsForm({Key? key}) : super(key: key);

  @override
  ApplicantFamilyNomineeDetailsFormState createState() =>
      ApplicantFamilyNomineeDetailsFormState();
}

class ApplicantFamilyNomineeDetailsFormState
    extends State<ApplicantFamilyNomineeDetailsForm> {
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
                  child: MyWidget().card4ApplicationDetails(context)),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantAddressDetailsForm(),
              ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearForm(),
              "4",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  List<FamilyDetailsVO> strFamilyDetailsList = [
    FamilyDetailsVO(1, "fam mem 1", 1541257894, "02-12-92", "Son"),
    FamilyDetailsVO(2, "fam mem 2", 5556664879, "02-12-92", "Daughter")
  ];
  List<NomineeDetailsVO> strNomineeDetailsList = [
    NomineeDetailsVO(1, "fam mem 1", 1541257894, "abc", "02-12-1992", "Son", 50,
        "State Bank of India", "Azara", "SBIN000036", 9508459730, 123456789012),
    NomineeDetailsVO(
        2,
        "fam mem 2",
        1541257235,
        "xyz",
        "02-12-1990",
        "Daughter",
        50,
        "State Bank of India",
        "Azara",
        "SBIN000036",
        9508459730,
        123456789012)
  ];

  DateTime? _selectedDate;
  //Date of Birth
  TextEditingController _textDateOfBirthFamilyController =
      TextEditingController();
  TextEditingController _textDateOfBirthNomineeController =
      TextEditingController();

  _selectDate(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textController
        ..text = DateFormat.yMMMd().format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  //Family & Nominee details
  card4ApplicationDetails(BuildContext context) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn().familyAndNomineeDetails),
            MyCustomHeader().headerCard(StringsEn().familyDetails),
            //Name
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().name),

            //Aadhaar Number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().aadhaarNumber),

            //Date of Birth
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
              child: TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: _textDateOfBirthFamilyController,
                onTap: () {
                  _selectDate(context, _textDateOfBirthFamilyController);
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  labelText: StringsEn().dateOfBirth,
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 14.0),
                  helperStyle: TextStyle(color: Colors.black, fontSize: 19.0),
                  /*contentPadding: EdgeInsets.all(12.0),*/
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(0)),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      Icons.star,
                      size: 9.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            //Relationship
            MyCustomDropdown().dropDown(StringsEn().relationship),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        StringsEn().addMember,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            Card(
              elevation: 3,
              child: Column(
                children: [
                  MyCustomHeader().headerCard(StringsEn().listOfFamilyDetails),
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: strFamilyDetailsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  strFamilyDetailsList[index].id.toString() +
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
                                      Row(
                                        children: [
                                          Text(
                                            strFamilyDetailsList[index]
                                                    .name!
                                                    .toUpperCase() +
                                                ". ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            "( " +
                                                strFamilyDetailsList[index]
                                                    .relationship! +
                                                " )",
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  StringsEn().aadhaarNo,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  strFamilyDetailsList[index]
                                                      .aadhaarNumber!
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  StringsEn().dateofBirth,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  strFamilyDetailsList[index]
                                                      .dateOfBirth!
                                                      .toString(),
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            trailing: Icon(Icons.arrow_right),
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

            //Nominee Details
            MyCustomHeader().headerCard(StringsEn().nomineeDetails),

            //Name
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().name),

            //Aadhaar number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().aadhaarNumber),

            //Address
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().address),

            //Date of Birth
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
              child: TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: _textDateOfBirthNomineeController,
                onTap: () {
                  _selectDate(context, _textDateOfBirthNomineeController);
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  labelText: StringsEn().dateOfBirth,
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 14.0),
                  helperStyle: TextStyle(color: Colors.black, fontSize: 19.0),
                  /*contentPadding: EdgeInsets.all(12.0),*/
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(0)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black12),
                      borderRadius: BorderRadius.circular(0)),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      Icons.star,
                      size: 9.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),

            //Relationship
            MyCustomDropdown().dropDown(StringsEn().relationship),

            //Share in percentage
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().shareInPercentage),

            //Bank Name
            MyCustomDropdown().dropDown(StringsEn().bankName),

            //Name of Branch
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().nameOfBranch),

            //IFSC
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().ifsc),

            //Aadhaar linked bank account number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().aadhaarLinkedBankAccountNumber),

            //Confirm bank account number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().confirmBankAccountNumber),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        StringsEn().addDetails,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 3,
                child: Column(
                  children: [
                    MyCustomHeader()
                        .headerCard(StringsEn().listOfNomineeDetails),
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
                                        Row(
                                          children: [
                                            Text(
                                              strNomineeDetailsList[index]
                                                      .name!
                                                      .toUpperCase() +
                                                  ". ",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "( " +
                                                  strNomineeDetailsList[index]
                                                      .relationship! +
                                                  " )",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringsEn().accountNo,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              strNomineeDetailsList[index]
                                                  .confirmBankAccountNumber!
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringsEn().aadhaarNo,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              strNomineeDetailsList[index]
                                                  .aadhaarNumber!
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringsEn().dateofBirth,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              strNomineeDetailsList[index]
                                                  .dateOfBirth!
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringsEn().shareInPercentages,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              strNomineeDetailsList[index]
                                                      .shareInPercentage!
                                                      .toString() +
                                                  " %",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              StringsEn().address1,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
                                            Text(
                                              strNomineeDetailsList[index]
                                                  .address!
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
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
                              trailing: Icon(Icons.arrow_right),
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
            ),
          ],
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
