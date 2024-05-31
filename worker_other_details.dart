///Updated on 19/12/2022 by Arsha

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown/custom_dropdown_widget.dart';
import 'package:obocwwb/custom_widgets/custom_list.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';
import 'package:obocwwb/model/education_Schme_Details_Models/religion_setup_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/details_of_the_establishment.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_bank_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_theme.dart';
import '../../constants.dart';

import '../../model/application_detail_vo.dart';
import '../../strings_en.dart';
import 'dart:convert' as convert;

class WorkerOtherDetails extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  final int? id;
  final int? otrID;
  final int? workId;
  final RegistrationVO? profileAddressDetailsVo;
  WorkerOtherDetails(
      {Key? key,
      this.otrID,
      this.workId,
      this.id,
      this.profileAddressDetailsVo})
      : super(key: key);

  @override
  _WorkerOtherDetailsState createState() => _WorkerOtherDetailsState();
}

class _WorkerOtherDetailsState extends State<WorkerOtherDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String? rationCardDetails;
  String? physicallyChallengedOrNot;
  String? communityDetails;
  String? religionId;
  bool nFSASfsa = false;
  List religionList = [];
  /* int _groupValue = 1;*/
  int _groupValue = 1;
  RegistrationVO otherDetailsRegistration = RegistrationVO();
  List<DropDownVO> rationCard = MyCustomList().rationCardList;
  List<DropDownVO> physicallyChallenged = MyCustomList().list;
  List<DropDownVO> community = MyCustomList().communityList;
  RegistrationVO regResponseNew = RegistrationVO();
  RegistrationVO? regResponse;
  TextEditingController cardDetails = TextEditingController();

  @override
  void initState() {
    super.initState();
    getRegistrationDetails();
    getReligionList();
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

    return StatefulBuilder(builder: (BuildContext cont, StateSetter state) {
      return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
              title: Text(StringsEn()
                  .applicationForRegistrationOfBuildingAndConstructionWorkers),
              backgroundColor: AppColor.primaryColor),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SingleChildScrollView(
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headerCard(StringsEn().otherDetails),
                          SizedBox(height: AppDigits.size),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(color: Colors.black12)),
                              child: Column(
                                children: [
                                  //Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?
                                  Row(
                                    children: [
                                      MyCustomText().textWithPadding(
                                          StringsEn().doUouHaveNFSAorSFSA,
                                          Colors.black),
                                      MyCustomText()
                                          .textWithoutPadding("*", Colors.red),
                                    ],
                                  ),
                                  //Radio Button [Yes/No]
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CustomRadioButton(
                                          text: "Yes",
                                          value: 2,
                                          groupValue: _groupValue,
                                          onChanged: (newValue) => setState(
                                              () => _groupValue = newValue),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomRadioButton(
                                          text: "No",
                                          value: 1,
                                          groupValue: _groupValue,
                                          onChanged: (newValue) => setState(
                                              () => _groupValue = newValue),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          _groupValue == 1
                              ? Container()
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: AppDigits.size,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(1),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.white,
                                                Colors.white70
                                              ]),
                                          color: AppTheme.deactivatedText,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8.0),
                                            bottomLeft: Radius.circular(8.0),
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            MyCustomTextField()
                                                .textWithTextControllerTextField(
                                                    TextInputType.text,
                                                    /* StringsEn().rationCardDetails*/ StringsEn()
                                                        .nFSAOrSFSSCardNoAvailable,
                                                    cardDetails,
                                                    false),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                          SizedBox(height: AppDigits.size),
                          CustomDropDownWidget(
                            text: StringsEn().category,
                            chooseValue: communityDetails,
                            myList: community,
                            onChanged: (newValue) =>
                                setState(() => communityDetails = newValue),
                          ),
                          SizedBox(height: AppDigits.size),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(color: Colors.black12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        textWithPaddingForProfile(
                                          StringsEn().religion,
                                          Colors.black,
                                        ),
                                        textWithoutPadding("*", Colors.red),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 5.0, right: 5),
                                    child: religionDropDown(cont, state),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: AppDigits.size),
                          CustomDropDownWidget(
                            text: StringsEn().physicallyChallenged,
                            chooseValue: physicallyChallengedOrNot,
                            myList: physicallyChallenged,
                            onChanged: (newValue) => setState(
                                () => physicallyChallengedOrNot = newValue),
                          ),
                          SizedBox(height: AppDigits.size),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  if (physicallyChallengedOrNot != "" &&
                                          religionId != "" &&
                                          communityDetails !=
                                              "" /* && _textRationCardDetails.text != ""*/ &&
                                          _groupValue == 2
                                      ? cardDetails.text != ""
                                      : _groupValue == 1) {
                                    saveOtherDetails(widget.otrID);
                                    Fluttertoast.showToast(
                                      msg: StringsEn().saved,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                    );
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: StringsEn()
                                            .makeSureAllTheMandatoryFieldsAreFilled,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blueGrey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                   /* _scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                            content: Text(StringsEn()
                                                .makeSureAllTheMandatoryFieldsAreFilled)));*/
                                  }
                                },
                                child: MyCustomButton()
                                    .buttonTextWidget(StringsEn().save),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                MyCustomText().textInformation(),
                MyCustomContainer().getBottomLayout(
                  context,
                  DetailsOfTheEstablishment(),
                  WorkerBankDetails(),
                  "6",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  religionDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(/*left: 5.0,*/ bottom: 5.0, right: 5.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: religionId,
        hint: Text(
          StringsEn().select,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: religionList.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['name'].toString(),
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            religionId = newValue;
          });
        },
      ),
    );
  }

  Future<void> getReligionList() async {
    FilterVO filterVO = FilterVO();
    filterVO.status = 'Y';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String encodedData = convert.jsonEncode(filterVO);
    //api
    var response = await Api.getAllAciveReligionSetup(encodedData, headers);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        religionList = responseBody;
      });
    }
  }

  Future<void> saveOtherDetails(int? otrID) async {
    RegistrationVO registrationVO = RegistrationVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    /* registrationVO = widget.regResponse!;*/
    registrationVO.id = pref.getInt('workerId');
    registrationVO = widget.profileAddressDetailsVo!;
    registrationVO.oneTimeRegistration = OneTimeRegistration();
    registrationVO.oneTimeRegistration!.id = pref.getInt('otrID');
    registrationVO.oneTimeRegistration!.alreadyRegistred = "N";
    /* registrationVO = regResponse!;
    registrationVO.id = pref.getInt('workerId');
    registrationVO.oneTimeRegistration = OneTimeRegistration();
    registrationVO.oneTimeRegistration!.id = pref.getInt('otrID');
    registrationVO.oneTimeRegistration!.alreadyRegistred = "N";*/
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    registrationVO.bplOrAntyodaya = _groupValue == 2 ? "Y" : "R";

    try {
      if (_groupValue == 2) {
        /* registrationVO.bplOrAntyodaya = "Y";*/
        registrationVO.bplOrAntyodayaCardNumber = cardDetails.text;
      }
      /*else if(_groupValue == 1){
        registrationVO.bplOrAntyodaya = "R";
      }
*/

      if (communityDetails == "General") {
        registrationVO.caste = 1;
      } else if (communityDetails == "OBC") {
        registrationVO.caste = 2;
      } else if (communityDetails == "SC") {
        registrationVO.caste = 3;
      } else if (communityDetails == "ST") {
        registrationVO.caste = 4;
      } else if (communityDetails == "SEBC") {
        registrationVO.caste = 5;
      } else if (communityDetails == "Other") {
        registrationVO.caste = 6;
      }
      registrationVO.religion = ReligionSetupVo();
      registrationVO.religion!.id = int.parse(religionId!);
      registrationVO.disability = physicallyChallengedOrNot;

      if (physicallyChallengedOrNot == "Yes") {
        registrationVO.disability = "1";
      } else if (physicallyChallengedOrNot == "No") {
        registrationVO.disability = "2";
      }
      String encodedData = convert.jsonEncode(registrationVO);

      var response = await Api.saveWorkerRegistration(encodedData, headers);
      if (response.statusCode == 200) {
        regResponse =
            RegistrationVO.fromJson(convert.jsonDecode(response.body));
        setState(() {
          Fluttertoast.showToast(
              msg: "Saved!!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0);
        /*  _scaffoldKey.currentState!
              .showSnackBar(SnackBar(content: Text('Saved!!!')));*/
        });
      } else {
        if (response.statusCode == 401) {
          MyCustomText().alertDialogBoxSessionTimeOut(context);
        }
      }
    } catch (e) {
      print(e);
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
      regResponse = RegistrationVO.fromJson(convert.jsonDecode(response.body));
      setState(() {
        cardDetails.text = regResponse!.bplOrAntyodayaCardNumber.toString();

        if (_groupValue == 2) {
          regResponse!.bplOrAntyodaya = "nfsaY";
        } else {
          regResponse!.bplOrAntyodaya = "nfsaN";
        }
        if (regResponse!.caste == 1) {
          communityDetails = "General";
        } else if (regResponse!.caste == 2) {
          communityDetails = "OBC";
        } else if (regResponse!.caste == 3) {
          communityDetails = "SC";
        } else if (regResponse!.caste == 4) {
          communityDetails = "ST";
        } else if (regResponse!.caste == 5) {
          communityDetails = "SEBC";
        } else {
          communityDetails = "Other";
        }
        if (regResponse!.disability == "1") {
          physicallyChallengedOrNot = "Yes";
        } else {
          physicallyChallengedOrNot = "No";
        }

        if (religionId != null) {
          regResponse!.religion = ReligionSetupVo();
          religionId = regResponse!.religion!.id!.toString();
        }
      });
    }
  }
}
