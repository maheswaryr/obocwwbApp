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

import 'applicant_family&nominee_details_form.dart';
import 'applicant_other_details_form.dart';
import 'package:intl/intl.dart';

class ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearForm
    extends StatefulWidget {
  const ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearForm(
      {Key? key})
      : super(key: key);

  @override
  ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearFormState
      createState() =>
          ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearFormState();
}

class ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearFormState
    extends State<
        ApplicantDetailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYearForm> {
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
                  child: MyWidget().card5ApplicationDetails(context)),
            ),
            MyCustomText().textInformation(),
            MyCustomContainer().getBottomLayout(
              context,
              ApplicantFamilyNomineeDetailsForm(),
              ApplicantOtherDetails1Form(),
              "5",
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget {
  //Details of the establishment(s) where the applicant worked during last one year
  card5ApplicationDetails(BuildContext context) {
    DateTime? _selectedDate;
    //Date of Birth
    TextEditingController _textEditingController1 = TextEditingController();
    TextEditingController _textEditingController2 = TextEditingController();

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

    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyCustomHeader().headerCard(StringsEn()
                .detailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYear),
            SizedBox(height: 10.0),
            //Name of Organization/Office
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().nameOfOrganizationOffice),
            //Registration Number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().registrationNumber),
            //Contact Number
            MyCustomTextField().textWithTextField(
                TextInputType.text, StringsEn().enterYourContactNumber),
            //Whether the Establishment is Govt/Private
            MyCustomDropdown().dropDownColumn(
                StringsEn().whetherTheEstablishmentIsGovtPrivate),
            //Nature of job
            MyCustomTextField()
                .textWithTextField(TextInputType.text, StringsEn().natureOfJob),
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
            //Period from
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
              child: TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: _textEditingController1,
                onTap: () {
                  _selectDate(context, _textEditingController1);
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  labelText: StringsEn().periodFrom,
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
            //Period up to
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
              child: TextFormField(
                focusNode: AlwaysDisabledFocusNode(),
                controller: _textEditingController2,
                onTap: () {
                  _selectDate(context, _textEditingController2);
                },
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                  labelText: StringsEn().periodUpTo,
                  labelStyle: TextStyle(color: Colors.black, fontSize: 16.0),
                  errorStyle:
                      TextStyle(color: Colors.redAccent, fontSize: 14.0),
                  helperStyle: TextStyle(color: Colors.black, fontSize: 19.0),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
