///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/funeral_expenses/registration_vo.dart';
import 'package:obocwwb/model/profile_general_details.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/construction_worker_details_death_benefits.dart';
import 'package:obocwwb/strings_en.dart';

import 'package:shared_preferences/shared_preferences.dart';


class RegistrationConstructionWorkerDetailsDeathBenefitsForm extends StatefulWidget {/*
  ApplicationDetailVo initiate = ApplicationDetailVo();*/
  RegistrationVo registrationResponse;


  RegistrationConstructionWorkerDetailsDeathBenefitsForm({/*required this.initiate*/required this.registrationResponse,

  })
      : super();

  @override
  RegistrationConstructionWorkerDetailsDeathBenefitsFormState createState() =>
      RegistrationConstructionWorkerDetailsDeathBenefitsFormState();
}

class RegistrationConstructionWorkerDetailsDeathBenefitsFormState
    extends State<RegistrationConstructionWorkerDetailsDeathBenefitsForm> {
  ProfileGeneralDetailsVo generalDetails = ProfileGeneralDetailsVo();
  FilterVO filterVO = FilterVO();
  bool loading = true;

  //Name
  TextEditingController _textWorkerNameController = TextEditingController();
  TextEditingController _textFatherNameController = TextEditingController();
  TextEditingController _textRegistredNumberController = TextEditingController();
  TextEditingController _textMobileNumberController = TextEditingController();
  TextEditingController _textWorkerAddressController = TextEditingController();

  ApplicationDetailVo initiate = ApplicationDetailVo();
  @override
  void initState() {
    // findGeneralDetailsByWorkerId();
    // getRegistrationDateByWorkerId();
    fields();
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
                  builder: (context) => SignInScreen(),
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


    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsEn().deathBenefits),
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
                          SizedBox(height: 10.0),
                          //Name
                          MyCustomTextField()
                              .textWithTextControllerTextField(
                              TextInputType.text,
                              StringsEn().registeredMobileNumberOfTheMe,
                              _textMobileNumberController,
                              true),
                          SizedBox(
                            height: AppDigits.size,
                          ),

                          //Sex
                          MyCustomTextField()
                              .textWithTextControllerTextField(
                              TextInputType.text,
                              StringsEn().registrationNumberOfTheMember,
                              _textRegistredNumberController,
                              true),
                          SizedBox(
                            height: AppDigits.size,
                          ),

                          //Registration No.
                          MyCustomTextField()
                              .textWithTextControllerTextField(
                              TextInputType.text,
                              StringsEn().workerName,
                              _textWorkerNameController,
                              true),
                          SizedBox(
                            height: AppDigits.size,
                          ),

                          //Registration Date
                          MyCustomTextField()
                              .textWithTextControllerDateTextField(
                              context,
                              StringsEn().workerAddress,
                              _textWorkerAddressController,
                              true),
                          SizedBox(
                            height: AppDigits.size,
                          ),

                          //Date of Birth
                          MyCustomTextField()
                              .textWithTextControllerDateTextField(
                              context,
                              StringsEn().workerFatherName,
                              _textFatherNameController,
                              true),
                          SizedBox(
                            height: AppDigits.size,
                          ),



                          SizedBox(height: 10.0),

                          SizedBox(height: 20,),

                          Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              onPressed: () {
                               /* Navigator.of(
                                    context)
                                    .push(MaterialPageRoute(
                                    builder:
                                        (context) =>
                                        ConstructionWorkerDetailsDeathBenefitsForm(initiate: initiate)));*/
                                initiateApplication();
                               /* GoToDeathBenefitFormFunction();*/
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    AppColor.primaryColor),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(14.0),
                                child: Text(
                                  StringsEn().proceed,
                                  style: TextStyle(fontSize: AppDigits.titleSize),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
           /*   MyCustomText().textInformation(),
              MyCustomContainer().getBottomLayout(
                context,
                DeclarationDeathBenefitsForm(initiate: widget.initiate),
                AddressDetailsDeathBenefitsForm(initiate: widget.initiate),
                "1",
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> findGeneralDetailsByWorkerId() async {
  //   CommonFilterVo commonFilterVo = CommonFilterVo();
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? token = pref.getString("token");
  //
  //   commonFilterVo.status =
  //       pref.getString("encryptedWorkerId");
  //   Map<String, String> headers = {
  //     'content-type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   String encodedData = convert.jsonEncode(commonFilterVo);
  //   var response = await Api.findGeneralDetailsByWorkerId(encodedData, headers);
  //   if (response.statusCode == 200) {
  //     generalDetails =
  //         ProfileGeneralDetailsVo.fromJson(convert.jsonDecode(response.body));
  //     setState(() {
  //       _textNameController.text = generalDetails.workerFirstName! +
  //           " " +
  //           generalDetails.workerLastName!;
  //       if (generalDetails.gender == "M") {
  //         _textSexController.text = "Male";
  //       } else if (generalDetails.gender == "F") {
  //         _textSexController.text = "Female";
  //       } else if (generalDetails.gender == "O") {
  //         _textSexController.text = "Others";
  //       }
  //       /*_textRegistrationNoController.text = generalDetails.gender!;*/
  //       DateTime newDate = DateTime.tryParse(generalDetails.dob!)!;
  //       DateFormat formatDate = DateFormat('dd-MM-yyyy');
  //       _textDateOfBirthController.text = formatDate.format(newDate);
  //       _textFatherNameController.text = generalDetails.fathersName!;
  //       if (generalDetails.maritalStatus == "S") {
  //         _textMartialStatusController.text = "Single";
  //       } else {
  //         _textMartialStatusController.text = "Married";
  //       }
  //       loading = true;
  //     });
  //   } else {
  //     if (response.statusCode == 401) {
  //       MyCustomText().alertDialogBox1(context);
  //     } else if (response.statusCode == 404) {
  //       MyCustomText().alertDialogBox2(context);
  //     } else if (response.statusCode == 500) {
  //       MyCustomText().alertDialogBox(context);
  //     }
  //     throw Exception('Failed to load jobs from API');
  //   }
  // }
  //
  // Future<void> getRegistrationDateByWorkerId() async {
  //   CommonFilterVo commonFilterVo = CommonFilterVo();
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? token = pref.getString("token");
  //   int? workerRegId = pref.getInt('workerId');
  //   commonFilterVo.workerRegId = workerRegId;
  //   Map<String, String> headers = {
  //     'content-type': 'application/json',
  //     'Authorization': 'Bearer $token'
  //   };
  //   String encodedData = convert.jsonEncode(commonFilterVo);
  //   var response =
  //   await Api.getRegistrationDateByWorkerId(encodedData, headers);
  //   if (response.statusCode == 200) {
  //     filterVO = FilterVO.fromJson(convert.jsonDecode(response.body));
  //     setState(() {
  //       if (filterVO.regDate != null) {
  //         DateTime newDate = DateTime.tryParse(filterVO.regDate!)!;
  //         DateFormat formatDate = DateFormat('dd-MM-yyyy');
  //         _textRegistrationDateController.text = formatDate.format(newDate);
  //       } else {
  //         _textRegistrationDateController.text = "--- Not Available ---";
  //       }
  //
  //       if (pref.getString("registrationNumber") != null) {
  //         _textRegistrationNoController.text =
  //         pref.getString("registrationNumber")!;
  //       } else {
  //         _textRegistrationNoController.text = "--- Not Available ---";
  //       }
  //       loading = false;
  //     });
  //   } else {
  //     if (response.statusCode == 401) {
  //       MyCustomText().alertDialogBox1(context);
  //     } else if (response.statusCode == 404) {
  //       MyCustomText().alertDialogBox2(context);
  //     } else if (response.statusCode == 500) {
  //       MyCustomText().alertDialogBox(context);
  //     }
  //     throw Exception('Failed to load jobs from API');
  //   }
  // }

  void fields() {
    _textFatherNameController.text = widget.registrationResponse.fathersName.toString();
    _textWorkerAddressController.text = widget.registrationResponse.presentAddress.toString();
    _textWorkerNameController.text =widget.registrationResponse.workerFirstName.toString();
    _textMobileNumberController.text =widget.registrationResponse.mobileNumber.toString();
    _textRegistredNumberController.text =widget.registrationResponse.licenseNumber.toString();

  }

  Future<void> initiateApplication() async {
    String encryptedId = "a1tPFkzj5HM=";
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    };
    var response = await Api.initiateDeathBenefit(encryptedId, headers);
    if (response.statusCode == 200) {

      Navigator.of(
          context)
          .push(MaterialPageRoute(
          builder:
              (context) =>
              ConstructionWorkerDetailsDeathBenefitsForm(initiate: initiate)));
      setState(() {
        loading = true;
      });
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBoxSessionTimeOut(context);
      }
    }
  }
}
