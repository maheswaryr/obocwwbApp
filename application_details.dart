///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_appllcation_deatils.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../model/application_detail_vo.dart';

class ApplicationDetails extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  ApplicationDetails({Key? key}) : super(key: key);

  @override
  State<ApplicationDetails> createState() => _ApplicationDetailsState();
}

class _ApplicationDetailsState extends State<ApplicationDetails> {
  TextEditingController _textAadhaarController = TextEditingController();
  TextEditingController _textNameAsPerAadhaarController =
      TextEditingController();
  RegistrationVO regResponse = new RegistrationVO();
  RegistrationVO regResponseNew = new RegistrationVO();
  bool? secondCheck = false;

  @override
  void initState() {
    super.initState();
    getRegistrationDetails();
  }

  var _validate = false;
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
                StringsEn().doYouReallyWantToExit,
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
                      builder: (context) => SignInScreen /*WelcomePage*/ (),
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
          title: Text(StringsEn()
              .applicationForRegistrationOfBuildingAndConstructionWorkers),
          backgroundColor: AppColor.primaryColor,
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          headerCard(StringsEn().applicantDetails),
                          SizedBox(height: 10.0),
                          //Already registered member
                          MyCustomText().textWithoutPadding(
                              StringsEn().alreadyRegisteredMember,
                              Colors.black),
                          SizedBox(
                            height: AppDigits.size,
                          ),
                          //Aadhaar number
                          MyCustomTextField()
                              .textWithTextControllerAadhaarNewWithoutImpMark(
                                  TextInputType.number,
                                  StringsEn().aadhaarNumber,
                                  _validate
                                      ? StringsEn().aadhaarCantBeEmpty
                                      : null,
                                  _textAadhaarController,
                                  false),
                          SizedBox(
                            height: 10,
                          ),
                          //Name as per Aadhaar
                          MyCustomTextField()
                              .textWithTextControllerTextFieldNewWithoutImpMark(
                                  TextInputType.text,
                                  StringsEn().nameAsPerAadhaar,
                                  _validate
                                      ? StringsEn().nameCantBeEmpty
                                      : null,
                                  _textNameAsPerAadhaarController,
                                  false),
                          SizedBox(
                            height: 10,
                          ),
                          //Declaration form
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    border: Border.all(color: Colors.black12)),
                                child: CheckboxListTile(
                                  title: Text(
                                    "I hereby state that I have no objection in authenticating myself with Aadhaar based authentication system and giving my consent to provide my Aadhaar number for Aadhaar based authentication for the purpose of establishing my identity and delivery of services / assistances by OB&OCWW Board.",
                                    style:
                                        TextStyle(fontSize: AppDigits.fontSize),
                                  ),
                                  value: secondCheck,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      secondCheck = value;
                                      ApplicationDetails();
                                    });
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              )),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              secondCheck!
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(0),
                          border: Border.all(color: Colors.black12)),
                      child: Row(
                        children: [getNextButtonWidget(context)],
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        StringsEn().clickTheCheckBox,
                        style: TextStyle(color: Colors.red[900]),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  getNextButtonWidget(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _textNameAsPerAadhaarController.text.isEmpty
                  ? _validate = true
                  : _validate = false;
              _textAadhaarController.text.isEmpty
                  ? _validate = true
                  : _validate = false;
            });
            if (_textAadhaarController.text.length == 12 &&
                _textNameAsPerAadhaarController.text != "") {
              saveApplicantDetails();
            } else {
              Fluttertoast.showToast(
                msg: StringsEn()
                    .makeSureAllTheMandatoryFieldsAreFilled /*+ applicationDetailVo.id.toString()*/,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
              );
            }
          },
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColor.primaryColor),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(StringsEn().next, style: TextStyle(fontSize: 16)),
                SizedBox(width: 5.0),
                Icon(Icons.arrow_forward, size: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
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

  declarationForm() {
    return Padding(
        padding: EdgeInsets.only(left: 10.0),
        child: MyCustomText().textWithoutFontWeight(
            "I hereby state that I have no objection in authenticating myself with Aadhaar based authentication system and giving my consent to provide my Aadhaar number for Aadhaar based authentication for the purpose of establishing my identity and delivery of services / assistances by OB&OCWW Board.",
            Colors.black));
  }

  void saveApplicantDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    RegistrationVO registration = new RegistrationVO();
    // registration = regResponse;
    registration.id = prefs.getInt('workerId');

    /*   String date = regResponseNew!.dobToStr.toString();
    DateFormat format = new DateFormat("yyyy-MM-dd");
    var formattedDate = format.parse(date);
    DateFormat format1 = new DateFormat("yyyy-MM-dd");
    String date1 = format1.format(formattedDate);*/

    // DateTime now = DateTime.now();
    // String date = DateFormat('yyyy-MM-dd').format(regResponseNew.dob!);
    // DateTime formattedDate = DateFormat('yyyy-MM-dd').parse(regResponseNew.dob!);
    // print(formattedDate);

    // DateTime Date = formattedDate.parse(regResponseNew.dob!);

/*
   String dateNew=  DateFormat('yyyy-MM-dd').format(DateFormat('yyyy-MM-dd').parse(regResponseNew.dob!));*/

    registration.aadhaarNumber = _textAadhaarController.text;
    registration.nameAsPerAadhar = _textNameAsPerAadhaarController.text;
    registration.oneTimeRegistration = new OneTimeRegistration();
    registration.oneTimeRegistration!.id = prefs.getInt("otrID");
    registration.oneTimeRegistration!.alreadyRegistred = "N";

    regResponseNew.dob = null;

    registration = regResponseNew;

    String encodedData = convert.jsonEncode(registration);
    var response = await Api.saveWorkerRegistration(encodedData, headers);

    if (response.statusCode == 200) {
      regResponse = RegistrationVO.fromJson(json.decode(response.body));
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => WorkerApplicationDetails(
                  regResponse: regResponse,
                )),
      );
    }
  }

  void getRegistrationDetails() async {
    RegistrationVO registration = RegistrationVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    registration.oneTimeRegistration = OneTimeRegistration();
    registration.oneTimeRegistration!.id = preferences.getInt('otrID');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registration);
    var response = await Api.getWorkerRegistrationDetails(encodedData, headers);
    if (response.statusCode == 200) {
      regResponseNew =
          RegistrationVO.fromJson(convert.jsonDecode(response.body));
      _textAadhaarController.text = regResponseNew.aadhaarNumber!;
      _textNameAsPerAadhaarController.text = regResponseNew.nameAsPerAadhar!;
    } else if (response.statusCode == 401) {
      MyCustomText().alertDialogBoxSessionTimeOut(context);
    } else if (response.statusCode == 404) {
      MyCustomText().alertDialogBox2(context);
    } else if (response.statusCode == 500) {
      MyCustomText().alertDialogBox(context);
    }
  }
}
