///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/funeral_expenses/filter_vo.dart';
import 'package:obocwwb/model/profile_general_details.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/address_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/declaration_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/home/home-page_new.dart';
import 'package:obocwwb/strings_en.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;

class ConstructionWorkerDetailsDeathBenefitsForm extends StatefulWidget {
  ApplicationDetailVo initiate = ApplicationDetailVo();
  ConstructionWorkerDetailsDeathBenefitsForm({required this.initiate})
      : super();

  @override
  ConstructionWorkerDetailsDeathBenefitsFormState createState() =>
      ConstructionWorkerDetailsDeathBenefitsFormState();
}

class ConstructionWorkerDetailsDeathBenefitsFormState
    extends State<ConstructionWorkerDetailsDeathBenefitsForm> {
  ProfileGeneralDetailsVo generalDetails = ProfileGeneralDetailsVo();
  FilterVO filterVO = FilterVO();
  bool loading = true;

  //Name
  TextEditingController _textNameController = TextEditingController();
  //sex
  TextEditingController _textSexController = TextEditingController();
  //Registration No.
  TextEditingController _textRegistrationNoController = TextEditingController();
  //Registration Date
  TextEditingController _textRegistrationDateController =
      TextEditingController();
  //Date of Birth
  TextEditingController _textDateOfBirthController = TextEditingController();
  //Father Name
  TextEditingController _textFatherNameController = TextEditingController();
  //Martial Status
  TextEditingController _textMartialStatusController = TextEditingController();
  @override
  void initState() {
    findGeneralDetailsByWorkerId();
    getRegistrationDateByWorkerId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
              StringsEn().Return,
                style: TextStyle(fontSize: AppDigits.titleSize),
              ),
              content: Text(
              StringsEn().doYouWantToReturnToHomePage,
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                   StringsEn().no,
                    style: TextStyle(
                        color: Colors.black, fontSize: AppDigits.fontSize),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePageNew(),
                    ),
                  ),
                  child: Text(
                   StringsEn().yes,
                    style: TextStyle(
                        color: Colors.black, fontSize: AppDigits.fontSize),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }
    headerCard(String headerText) {
      return Container(
        width: double.infinity,
        color: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(headerText,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold)),
        ),
      );
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsEn().deathBenefitApplicationForm),
          backgroundColor: AppColor.primaryColor,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            /*  loading
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              StringsEn().loadingPleaseWait,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  :*/ Expanded(
                      child: SingleChildScrollView(
                        child: Card(
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            headerCard(StringsEn().constructionWorkerDetails),
                                SizedBox(height: 10.0),
                                //Name
                                MyCustomTextField()
                                    .textWithTextControllerTextField(
                                        TextInputType.text,
                                       StringsEn().name,
                                        _textNameController,
                                        true),
                                SizedBox(
                                  height: AppDigits.size,
                                ),

                                //Sex
                                MyCustomTextField()
                                    .textWithTextControllerTextField(
                                        TextInputType.text,
                                        StringsEn().sex,
                                        _textSexController,
                                        true),
                                SizedBox(
                                  height: AppDigits.size,
                                ),

                                //Registration No.
                                MyCustomTextField()
                                    .textWithTextControllerTextField(
                                        TextInputType.text,
                                       StringsEn().registrationNumber,
                                        _textRegistrationNoController,
                                        true),
                                SizedBox(
                                  height: AppDigits.size,
                                ),

                                //Registration Date
                                MyCustomTextField()
                                    .textWithTextControllerDateTextField(
                                        context,
                                        StringsEn().registrationDate,
                                        _textRegistrationDateController,
                                        true),
                                SizedBox(
                                  height: AppDigits.size,
                                ),

                                //Date of Birth
                                MyCustomTextField()
                                    .textWithTextControllerDateTextField(
                                        context,
                                      StringsEn().dateOfBirth,
                                        _textDateOfBirthController,
                                        true),
                                SizedBox(
                                  height: AppDigits.size,
                                ),

                                //Father Name
                                MyCustomTextField()
                                    .textWithTextControllerTextField(
                                        TextInputType.text,
                                        StringsEn().fatherName,
                                        _textFatherNameController,
                                        true),
                                SizedBox(
                                  height: AppDigits.size,
                                ),

                                //Martial Status
                                MyCustomTextField()
                                    .textWithTextControllerTextField(
                                        TextInputType.text,
                                       StringsEn().maritalStatus,
                                        _textMartialStatusController,
                                        true),

                                SizedBox(height: 10.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              MyCustomText().textInformation(),
              MyCustomContainer().getBottomLayout(
                context,
                DeclarationDeathBenefitsForm(initiate: widget.initiate),
                AddressDetailsDeathBenefitsForm(initiate: widget.initiate),
                "1",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> findGeneralDetailsByWorkerId() async {
    CommonFilterVo commonFilterVo = CommonFilterVo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");

    commonFilterVo.status =
        pref.getString("encryptedWorkerId");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response = await Api.findGeneralDetailsByWorkerId(encodedData, headers);
    if (response.statusCode == 200) {
      generalDetails =
          ProfileGeneralDetailsVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        _textNameController.text = generalDetails.workerFirstName! +
            " " +
            generalDetails.workerLastName!;
        if (generalDetails.gender == "M") {
          _textSexController.text = "Male";
        } else if (generalDetails.gender == "F") {
          _textSexController.text = "Female";
        } else if (generalDetails.gender == "O") {
          _textSexController.text = "Others";
        }
        /*_textRegistrationNoController.text = generalDetails.gender!;*/
        DateTime newDate = DateTime.tryParse(generalDetails.dob!)!;
        DateFormat formatDate = DateFormat('dd-MM-yyyy');
        _textDateOfBirthController.text = formatDate.format(newDate);
        _textFatherNameController.text = generalDetails.fathersName!;
        if (generalDetails.maritalStatus == "S") {
          _textMartialStatusController.text = "Single";
        } else {
          _textMartialStatusController.text = "Married";
        }
        loading = true;
      });
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBox1(context);
      } else if (response.statusCode == 404) {
        MyCustomText().alertDialogBox2(context);
      } else if (response.statusCode == 500) {
        MyCustomText().alertDialogBox(context);
      }
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<void> getRegistrationDateByWorkerId() async {
    CommonFilterVo commonFilterVo = CommonFilterVo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    int? workerRegId = pref.getInt('workerId');
    commonFilterVo.workerRegId = workerRegId;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response =
        await Api.getRegistrationDateByWorkerId(encodedData, headers);
    if (response.statusCode == 200) {
      filterVO = FilterVO.fromJson(convert.jsonDecode(response.body));
      setState(() {
        if (filterVO.regDate != null) {
          DateTime newDate = DateTime.tryParse(filterVO.regDate!)!;
          DateFormat formatDate = DateFormat('dd-MM-yyyy');
          _textRegistrationDateController.text = formatDate.format(newDate);
        } else {
          _textRegistrationDateController.text = "--- Not Available ---";
        }

        if (pref.getString("registrationNumber") != null) {
          _textRegistrationNoController.text =
              pref.getString("registrationNumber")!;
        } else {
          _textRegistrationNoController.text = "--- Not Available ---";
        }
        loading = false;
      });
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBox1(context);
      } else if (response.statusCode == 404) {
        MyCustomText().alertDialogBox2(context);
      } else if (response.statusCode == 500) {
        MyCustomText().alertDialogBox(context);
      }
      throw Exception('Failed to load jobs from API');
    }
  }
}
