///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown/custom_dropdown_widget.dart';
import 'package:obocwwb/custom_widgets/custom_list.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/block_setup_vo.dart';
import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';
import 'package:obocwwb/model/district_setup_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/education_setup_vo.dart';
import 'package:obocwwb/model/mw_services_models/filter_vo.dart';
import 'package:obocwwb/model/natureof_work_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/state_setup.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/addree_details_old.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/application_details.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/application_detail_vo.dart';

class WorkerApplicationDetails extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  final RegistrationVO? regResponse;
  WorkerApplicationDetails({Key? key, this.regResponse}) : super(key: key);

  @override
  State<WorkerApplicationDetails> createState() =>
      _WorkerApplicationDetailsState();
}

class _WorkerApplicationDetailsState extends State<WorkerApplicationDetails> {
  final _formKey = GlobalKey<FormState>();
  RegistrationVO regResponseNew = RegistrationVO();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String? typeOfGenderChoose;
  String? maritalStatus;
  List<DropDownVO> typeOfGenderList = MyCustomList().sexList;
  List<DropDownVO> maritalStatusList = MyCustomList().maritalStatus;
  TextEditingController _dateOfBirthController = TextEditingController();
  TextEditingController textFirstNameController = TextEditingController();
  TextEditingController textSurNameController = TextEditingController();
  TextEditingController textMobileNumberController = TextEditingController();
  TextEditingController textFatherNameController = TextEditingController();
  TextEditingController textSpouseNameController = TextEditingController();
  TextEditingController otherWorkController = TextEditingController();
  TextEditingController establishmentAddressController =
      TextEditingController();
  TextEditingController textTrainingDetailsController = TextEditingController();
  TextEditingController registrationPerVillageOutController =
      TextEditingController();
  TextEditingController gramPanchayatController = TextEditingController();
  TextEditingController gramPanchayatOutController = TextEditingController();
  TextEditingController registrationPerVillageController =
      TextEditingController();
  TextEditingController durationInMonthsController = TextEditingController();
  TextEditingController durationInMonthsInController = TextEditingController();
  TextEditingController blockOrUlbController = TextEditingController();
  bool loading = true;
  bool migrantWorker = false;
  bool maritalStatusValue = false;
  bool othersValue = false;
  int _groupValue = 1;
  int _migrantGroupValue = 1;
  String? value1;
  String? educationDropdownValue;
  String? workDropDownValue;
  String? nomineeId;
  String? districtId;
  String? dropdownValueForRegDistrict;
  String? dropdownValueForOutRegDistrict;
  String? dropdownValueForRegistrationDistrictPermanent;
  String? dropdownValueForRegBlock;
  String? dropdownValueForRegState;
  String? dropdownValueForUlbPresent;
  List natureOfWorkList = [];
  List educationList = [];
  List districtList = [];
  List ulbListPresent = [];
  List blockList = [];
  List stateList = [];
  List districtListPermanent = [];
  String? workId;
  String? blockId;
  int? otrId;
  RegistrationVO? regResponse;
  RegistrationVO? workerRegResponse;

  @override
  void initState() {
    // getOneTimeRegistration();
    getAllActiveNatureOFWork();
    getAllActiveEducationSetupVO();
    getBlocks1();
    getStateList1();
    getDistrictListPresent();

    getRegistrationDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(StringsEn().Return),
              content: Text(StringsEn().doYouReallyWantToExit),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    StringsEn().no,
                    style: TextStyle(color: Colors.black),
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
                    style: TextStyle(color: Colors.black),
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
            backgroundColor: AppColor.primaryColor,
          ),
          body: Container(
            child: Form(
              key: _formKey,
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
                              headerCard(StringsEn().applicationDetails),
                              SizedBox(height: AppDigits.size),
                              //First name
                              MyCustomTextField()
                                  .textWithTextControllerTextFieldWithoutImpMark(
                                      TextInputType.text,
                                      StringsEn().firstName,
                                      textFirstNameController,
                                      true),
                              SizedBox(height: AppDigits.size),
                              //Surname
                              MyCustomTextField()
                                  .textWithTextControllerTextFieldWithoutImpMark(
                                      TextInputType.text,
                                      StringsEn().surName,
                                      textSurNameController,
                                      true),
                              SizedBox(height: AppDigits.size),
                              //gender
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: CustomDropDownWidget(
                                  text: "Sex",
                                  chooseValue: typeOfGenderChoose,
                                  myList: typeOfGenderList,
                                  onChanged: (newValue) => setState(
                                      () => typeOfGenderChoose = newValue),
                                ),
                              ),
                              SizedBox(height: AppDigits.size),
                              //Mobile Number
                              MyCustomTextField()
                                  .textWithMobileNumValidationTextFieldWithoutImpMark(
                                      TextInputType.phone,
                                      StringsEn().mobileNumber,
                                      textMobileNumberController,
                                      true),
                              SizedBox(height: AppDigits.size),
                              // Date of Birth
                              MyCustomTextField()
                                  .textWithTextControllerDateTextFieldWithoutAsterisksMInMax(
                                      context,
                                      StringsEn().dateOfBirth,
                                      _dateOfBirthController,
                                      false),
                              SizedBox(height: AppDigits.size),
                              //Father's name
                              MyCustomTextField()
                                  .textWithTextControllerTextFieldOnlyText(
                                      TextInputType.text,
                                      StringsEn().fatherName,
                                      textFatherNameController,
                                      false),
                              SizedBox(height: AppDigits.size),
                              //Marital status
                              Column(
                                children: [
                                  CustomDropDownWidget(
                                    text: StringsEn().maritalStatus,
                                    chooseValue: maritalStatus,
                                    myList: maritalStatusList,
                                    onChanged: (newValue) => setState(() {
                                      maritalStatus = newValue;
                                      maritalStatus == 'M'
                                          ? maritalStatusValue = true
                                          : maritalStatusValue = false;
                                    }),
                                  ),
                                  SizedBox(height: AppDigits.size),
                                  Visibility(
                                      visible: maritalStatusValue,
                                      child: MyCustomTextField()
                                          .textWithTextControllerTextFieldWithoutImpMark(
                                              TextInputType.text,
                                              StringsEn().spouseName,
                                              textSpouseNameController,
                                              false))
                                ],
                              ),
                              SizedBox(height: AppDigits.size),
                              //Nature of work
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: natureOfWorkListDropDown(context),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                  visible: othersValue,
                                  child: MyCustomTextField()
                                      .textWithTextControllerTextFieldWithoutImpMark(
                                          TextInputType.text,
                                          StringsEn().pleaseSpecifyNew,
                                          otherWorkController,
                                          false)),
                              SizedBox(height: AppDigits.size),
                              //Education Qualification
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: educationListDropDown(context),
                                  )),
                              SizedBox(height: AppDigits.size),
                              //Training Details
                              MyCustomTextField()
                                  .textWithTextControllerTextFieldWithoutImpMarkNe(
                                      TextInputType.text,
                                      StringsEn().trainingDetailsIfAny,
                                      textTrainingDetailsController,
                                      false),
                              SizedBox(height: AppDigits.size),
                              // Are you a registered migrant
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Column(
                                    children: [
                                      //Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?
                                      Row(
                                        children: [
                                          MyCustomText().textWithPadding(
                                              StringsEn().areYouAMigrantWorker,
                                              Colors.black),
                                          MyCustomText().textWithoutPadding(
                                              "*", Colors.red),
                                        ],
                                      ),
                                      //Radio Button [Yes/No]
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: CustomRadioButton(
                                                text: "Yes",
                                                value: 2,
                                                groupValue: _groupValue,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _groupValue = newValue;
                                                    _groupValue == 1
                                                        ? migrantWorker = false
                                                        : migrantWorker = true;
                                                  });
                                                }),
                                          ),
                                          Expanded(
                                            child: CustomRadioButton(
                                                text: "No",
                                                value: 1,
                                                groupValue: _groupValue,
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    _groupValue = newValue;
                                                    _groupValue == 1
                                                        ? migrantWorker = false
                                                        : migrantWorker = true;
                                                  });
                                                }),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: migrantWorker,
                                child: Column(
                                  children: [
                                    SizedBox(height: AppDigits.size),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                MyCustomText().textWithPadding(
                                                    StringsEn()
                                                        .inMigrantOrOutMigrant,
                                                    Colors.black),
                                                MyCustomText()
                                                    .textWithoutPadding(
                                                        "*", Colors.red),
                                              ],
                                            ),
                                            //Radio Button [Yes/No]
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: CustomRadioButton(
                                                    text: "In migrant",
                                                    value: 1,
                                                    groupValue:
                                                        _migrantGroupValue,
                                                    onChanged: (newValue) =>
                                                        setState(() =>
                                                            _migrantGroupValue =
                                                                newValue),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomRadioButton(
                                                    text: "Out migrant",
                                                    value: 2,
                                                    groupValue:
                                                        _migrantGroupValue,
                                                    onChanged: (newValue) =>
                                                        setState(() =>
                                                            _migrantGroupValue =
                                                                newValue),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    _migrantGroupValue == 1
                                        ?
                                        //Establishment's address
                                        Column(
                                            children: [
                                              SizedBox(height: AppDigits.size),
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn()
                                                          .establishmentAddress,
                                                      establishmentAddressController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //District dropdown
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  child:
                                                      districtPresentDropDown(
                                                          cont, state),
                                                ),
                                              ),
                                              SizedBox(height: AppDigits.size),
                                              //Block/Ulb
                                              Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        border: Border.all(
                                                            color: Colors
                                                                .black12)),
                                                    child: ulbPresentDropDown(
                                                        cont, state),
                                                  )),
                                              SizedBox(height: AppDigits.size),
                                              //GramPanchayat
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn().gramPanchayat,
                                                      gramPanchayatController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //registration per village
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn().village,
                                                      registrationPerVillageController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //Duration in months
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldDurationInMonth(
                                                      TextInputType.phone,
                                                      StringsEn()
                                                          .durationInMonths,
                                                      durationInMonthsInController,
                                                      false),
                                            ],
                                          )
                                        : Column(
                                            children: [
                                              SizedBox(height: AppDigits.size),
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn()
                                                          .establishmentAddress,
                                                      establishmentAddressController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //State dropdown
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  child: stateListDropDown(
                                                      cont, state),
                                                ),
                                              ),
                                              SizedBox(height: AppDigits.size),
                                              //District
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0),
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12)),
                                                  child:
                                                      districtPresentOutDropDown(
                                                          cont, state),
                                                ),
                                              ),
                                              SizedBox(height: AppDigits.size),
                                              //Block/Ulb
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn().blockOrUlb,
                                                      blockOrUlbController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //GramPanchayat
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn().gramPanchayat,
                                                      gramPanchayatOutController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //registration per village
                                              MyCustomTextField()
                                                  .textWithTextControllerTextFieldWithoutImpMark(
                                                      TextInputType.text,
                                                      StringsEn().village,
                                                      registrationPerVillageOutController,
                                                      false),
                                              SizedBox(height: AppDigits.size),
                                              //Duration in months

                                              MyCustomTextField()
                                                  .textWithTextControllerShareInPercentageWithoutImpMark(
                                                      TextInputType.phone,
                                                      StringsEn()
                                                          .durationInMonths,
                                                      durationInMonthsController,
                                                      false),
                                              //Save button
                                              Center(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        Fluttertoast.showToast(
                                                            msg:
                                                            'Saved!',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            timeInSecForIosWeb: 1,
                                                            backgroundColor: Colors.blueGrey,
                                                            textColor: Colors.white,
                                                            fontSize: 16.0);
                                                       /* final snackBar =
                                                            SnackBar(
                                                                content: Text(
                                                                    'Saved'));
                                                        _scaffoldKey
                                                            .currentState!
                                                            .showSnackBar(
                                                                snackBar);*/
                                                      }
                                                    },
                                                    child:
                                                        Text(StringsEn().save),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor: AppColor
                                                                .primaryColor)),
                                              ),
                                            ],
                                          )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  MyCustomText().textInformation(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(color: Colors.black12)),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ApplicationDetails()),
                                );
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 14),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back, size: 16.0),
                                    Text(StringsEn().previous,
                                        style: TextStyle(
                                            fontSize: AppDigits.titleSize)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 100.0,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.blue[200],
                              shape: BoxShape.circle,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "2",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            child: ElevatedButton(
                              onPressed: () {
                                if (_dateOfBirthController.text != "" &&
                                    textFatherNameController.text != "" &&
                                    natureOfWorkList != "") {
                                  saveWorkerApplicationDetails();
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
                                  );
                                }
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        AppColor.primaryColor),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
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
                                    Text(StringsEn().next,
                                        style: TextStyle(
                                            fontSize: AppDigits.titleSize)),
                                    SizedBox(width: 5.0),
                                    Icon(Icons.arrow_forward, size: 16.0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  districtDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForRegistrationDistrictPermanent,
        hint: Text(
          StringsEn().selectDistrict,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: districtListPermanent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['districtName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            districtId = newValue;

            dropdownValueForRegistrationDistrictPermanent = newValue!;
            getBlocks1();
          });
        },
      ),
    );
  }

  Future<void> getAllActiveNatureOFWork() async {
    FilterVO filterVO = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    filterVO.status = "Y";
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getAllAciveNatureOFWork(encodedData, headers);
    if (response.statusCode == 200) {
      NatureOfWorkVO others = NatureOfWorkVO();
      others.workId = 16;
      others.natureOfWork = "Others";
      others.activeStatus = "Y";
      // var responseBody = json.decode(response.body);
      List<NatureOfWorkVO> responseBody = (json.decode(response.body) as List)
          .map((i) => NatureOfWorkVO.fromJson(i))
          .toList();
      responseBody.add(others);
      setState(() {
        natureOfWorkList = convert.jsonDecode(json.encode(responseBody));
        loading = false;
      });
    }
  }

  Future<void> getAllActiveEducationSetupVO() async {
    FilterVO filterVO = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    filterVO.status = "Y";
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getAllAciveEducationSetupVO(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        educationList = responseBody;
        loading = false;
      });
    }
  }

  natureOfWorkListDropDown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
          underline: SizedBox(),
          value: /*workId*/ workDropDownValue,
          hint: Text(
            StringsEn().natureOfWork,
            style: TextStyle(fontSize: AppDigits.fontSize),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: natureOfWorkList.map((item) {
            return DropdownMenuItem(
              child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20)),
                          child: Container(
                              padding: EdgeInsets.all(2),
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(
                                item['natureOfWork'].toString(),
                                style: TextStyle(fontSize: AppDigits.fontSize),
                              ))),
                    ],
                  )),
              value: item['workId'].toString(),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              workId = newValue;
              workId == '16' ? othersValue = true : othersValue = false;
              workDropDownValue = newValue!;
            });
          }),
    );
  }

  educationListDropDown(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: educationDropdownValue,
            hint: Text(
              StringsEn().educationQualification,
              style: TextStyle(fontSize: AppDigits.fontSize),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: educationList.map((item) {
              return DropdownMenuItem(
                child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Row(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: Container(
                                padding: EdgeInsets.all(2),
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(item['name'].toString(),
                                    style: TextStyle(
                                        fontSize: AppDigits.fontSize)))),
                      ],
                    )),
                value: item['id'].toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                id = newValue;
                educationDropdownValue = newValue!;
              });
            }));
  }

  radioButton(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Column(
          children: [
            //Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?
            Row(
              children: [
                Expanded(
                    child: MyCustomText().textWithPadding(title, Colors.black)),
                MyCustomText().textWithoutPadding("*", Colors.red),
              ],
            ),
            //Radio Button [Yes/No]
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomRadioButton(
                    text: "Yes",
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (newValue) =>
                        setState(() => _groupValue = newValue),
                  ),
                ),
                Expanded(
                  child: CustomRadioButton(
                    text: "No",
                    value: 2,
                    groupValue: _groupValue,
                    onChanged: (newValue) =>
                        setState(() => _groupValue = newValue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getDistrictListPresent() async {
    FilterVo filterVo = FilterVo();

    filterVo.stateId = 21;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVo);

    var response = await Api.getDistrictList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        districtList = responseBody;
      });
    }
  }

  Future<void> getDistrictListPermanent() async {
    FilterVo filterVo = FilterVo();
    filterVo.stateId = dropdownValueForRegState != null
        ? int.parse(dropdownValueForRegState!)
        : null;
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVo);
    //api
    var response = await Api.getDistrictList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        districtListPermanent = responseBody;
        /*loading = false;*/
      });
    } else {}
  }

  districtPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValueForRegDistrict,
        hint: Text(
          StringsEn().selectDistrict,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: districtList.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['districtName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            id = newValue;
            dropdownValueForRegDistrict = newValue!;
            dropdownValueForUlbPresent = null;
            getUlbSBlocksPresent();
          });
        },
      ),
    );
  }

  districtPresentOutDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValueForOutRegDistrict,
        hint: Text(
          StringsEn().selectDistrict,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: districtListPermanent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['districtName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            id = newValue;
            dropdownValueForOutRegDistrict = newValue!;
            /* dropdownValueForUlbPresent = null;*/
            /*     getUlbSBlocksPresent();*/
          });
        },
      ),
    );
  }

  Future<void> getUlbSBlocksPresent() async {
    FilterVO filterVO = FilterVO();
    filterVO.districtId = id != null ? int.parse(id!) : 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.ulbsBlocks(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        ulbListPresent = responseBody;
      });
    } else {}
  }

  ulbPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForUlbPresent,
        hint: Text(
          StringsEn().blockOrUlb,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: ulbListPresent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['ulbName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownValueForUlbPresent = newValue!;
          });
        },
      ),
    );
  }

  blockPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          value: dropdownValueForRegBlock,
          hint: Text(
            StringsEn().blockOrUlb,
            style: TextStyle(fontSize: AppDigits.fontSize),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: blockList.map((item) {
            return DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(item['blockName'].toString(),
                    style: TextStyle(fontSize: AppDigits.fontSize)),
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              blockId = newValue;
              dropdownValueForRegBlock = newValue!;
            });
          },
        ));
  }

  Future<void> getBlocks1() async {
    FilterVo filterVo = FilterVo();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 0;
    filterVo.placeId = 0;
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVo);
    //api
    var response = await Api.getBlocks(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        blockList = responseBody;
        /* loading = false;*/
      });
    } else {}
  }

  Future<void> getStateList1() async {
    FilterVo filterVo = FilterVo();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 0;
    filterVo.placeId = 0;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String encodedData = convert.jsonEncode(filterVo);
    //api
    var response = await Api.getStateList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        stateList = responseBody;
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

  stateListDropDown(BuildContext context, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        // Initial Value
        underline: SizedBox(),
        value: dropdownValueForRegState,
        hint: Text(
          StringsEn().selectState,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: stateList.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['stateName'].toString(),
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
            id = newValue;
            dropdownValueForRegState = newValue!;
            dropdownValueForOutRegDistrict = null;
            getDistrictListPermanent();
          });
        },
      ),
    );
  }

  void getOneTimeRegistration() async {
    OneTimeRegistration oneTimeRegistration = OneTimeRegistration();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    oneTimeRegistration.id = preferences.getInt('otrID');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(oneTimeRegistration);
    var response =
        await Api.getOneTimeRegistrationDetails(encodedData, headers);
    if (response.statusCode == 200) {
      oneTimeRegistration =
          OneTimeRegistration.fromJson(convert.jsonDecode(response.body));
      textFirstNameController.text = oneTimeRegistration.firstName!;
      textSurNameController.text = oneTimeRegistration.lastName!;
      textMobileNumberController.text = oneTimeRegistration.mobileNo!;
      typeOfGenderChoose = oneTimeRegistration.gender!;
    } else {}
  }

  void saveWorkerApplicationDetails() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    RegistrationVO regRequest = new RegistrationVO();
    regRequest.id = preferences.getInt('workerId');
    regRequest = widget.regResponse!; /*widget.regResponse!;*/
    regRequest.dobToStr = DateFormat('dd-MM-yyyy')
        .format(DateFormat('dd-MM-yyyy').parse(_dateOfBirthController.text));
    regRequest.fathersName = textFatherNameController.text;
    regRequest.maritalStatus = maritalStatus;
    regRequest.spouseName = textSpouseNameController.text;
    regRequest.natureOfJob = new NatureOfWorkVO();
    regRequest.natureOfJob!.workId = int.parse(/*workId*/ workDropDownValue!);
    regRequest.otherWork = otherWorkController.text;
    regRequest.educationOrTraining = new EducationSetupVO();
    regRequest.educationOrTraining!.id = int.parse(educationDropdownValue!);
    regRequest.trainingDetails = textTrainingDetailsController.text;
    regRequest.isMigrantWorker = _groupValue == 1 ? "N" : "Y";
    if (_groupValue == 2) {
      regRequest.inMigrantOrOutMigrant = _migrantGroupValue == 1 ? "I" : "O";
      regRequest.employerAddress = establishmentAddressController.text;
      regRequest.inMigrantGramPanchayath = gramPanchayatController.text;
      regRequest.inMigrantVillage = registrationPerVillageController.text;
      regRequest.inMigrantDuration = durationInMonthsInController.text;
      if (_migrantGroupValue == 1) {
        regRequest.inMigrantDistrict = DistrictSetupVo();
        regRequest.inMigrantDistrict!.id =
            int.parse(dropdownValueForRegDistrict!);
        if (regRequest.inMigrantBlock != null) {
          regRequest.inMigrantBlock = BlockSetUpVo();
          regRequest.inMigrantBlock!.id = int.parse(
              /*dropdownValueForRegBlock*/ dropdownValueForUlbPresent!);
        }
      } else {
        regRequest.outMigrantState = StateSetup();
        regRequest.outMigrantState!.id = int.parse(dropdownValueForRegState!);
        regRequest.outMigrantDuration = durationInMonthsController.text;
        regRequest.outMigrantDistrict = DistrictSetupVo();
        regRequest.outMigrantDistrict!.id =
            int.parse(dropdownValueForOutRegDistrict!);
        regRequest.outMigrantBlock = blockOrUlbController.text;
        regRequest.outMigrantVillage = registrationPerVillageOutController.text;
        regRequest.outMigrantGramPanchayath = gramPanchayatOutController.text;
      }
    }

    String encodedData = convert.jsonEncode(regRequest);
    var response = await Api.saveWorkerRegistration(encodedData, headers);
    if (response.statusCode == 200) {
      workerRegResponse = RegistrationVO.fromJson(json.decode(response.body));
      setState(() {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => AddressDetailsFormOld(
                    regResponse: workerRegResponse,
                  )),
        );
      });
    }
  }

  void getRegistrationDetails() async {
    RegistrationVO registration = RegistrationVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    registration.oneTimeRegistration = OneTimeRegistration();
    registration.oneTimeRegistration!.id = preferences.getInt('otrID');
    registration.id = preferences.getInt('workerId');

/*    registration = widget.regResponse!;
    registration.id = preferences.getInt('workerId');*/

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registration);
    var response = await Api.getWorkerRegistrationDetails(encodedData, headers);
    if (response.statusCode == 200) {
      regResponse = RegistrationVO.fromJson(convert.jsonDecode(response.body));
      setState(() {
        loading = false;
        /*   regResponse = widget.regResponse;*/
        textFirstNameController.text =
            regResponse!.oneTimeRegistration!.firstName.toString();
        textSurNameController.text =
            regResponse!.oneTimeRegistration!.lastName.toString();
        textMobileNumberController.text =
            regResponse!.oneTimeRegistration!.mobileNo.toString();
        typeOfGenderChoose = regResponse!.oneTimeRegistration!.gender;

        /* textFirstNameController.text=   regResponse!.workerFirstName.toString();
        textSurNameController.text = regResponse!.workerLastName.toString();
        textMobileNumberController.text = regResponse!.mobileNumber.toString();
        typeOfGenderChoose = regResponse!.gender;*/
        /*     if(_dateOfBirthController.text != null){
          var date = regResponse!.dobToStr.toString();
          DateFormat format = new DateFormat("yyyy-MM-dd");
          var formattedDate = format.parse(date);
          DateFormat format1 = new DateFormat("yyyy-MM-dd");

          _dateOfBirthController.text = format1.format(formattedDate);
        }*/
        if (regResponse!.dob != null) {
          /*  _dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(
              DateFormat('yyyy-MM-dd').parse(regResponse!.dob.toString()));*/
          _dateOfBirthController.text = regResponse!.dob.toString();
          regResponse!
                  .dob = /*DateFormat('yyyy-MM-dd')
              .format(DateFormat('yyyy-MM-dd').parse(*/
              _dateOfBirthController.text /*))*/;
        }

        if (regResponse!.fathersName != null) {
          textFatherNameController.text = regResponse!.fathersName.toString();
        }
        if (regResponse!.maritalStatus != null) {
          maritalStatus = regResponse!.maritalStatus.toString();
          /*    textSpouseNameController.text = regResponse!.spouseName.toString();*/

        }

        if (regResponse!.spouseName != null) {
          textSpouseNameController.text = regResponse!.spouseName.toString();
        }
        if (/*workId*/ regResponse!.natureOfJob!.workId != null) {
          /*workId*/ workDropDownValue =
              regResponse!.natureOfJob!.workId.toString();
        }
        if (regResponse!.otherWork != null) {
          otherWorkController.text = regResponse!.otherWork.toString();
        }
        if (regResponse!.educationOrTraining != null) {
          educationDropdownValue =
              regResponse!.educationOrTraining!.id.toString();
        }
        if (regResponse!.trainingDetails != null) {
          textTrainingDetailsController.text =
              regResponse!.trainingDetails.toString();
        }

        _groupValue = regResponse!.isMigrantWorker == "Y" ? 2 : 1;

        if (_groupValue == 2) {
          setState(() {
            migrantWorker = true;
          });
          _migrantGroupValue =
              regResponse!.inMigrantOrOutMigrant == "I" ? 1 : 2;
          if (regResponse!.employerAddress != null) {
            establishmentAddressController.text = regResponse!.employerAddress!;
          }
          if (regResponse!.inMigrantGramPanchayath != null) {
            gramPanchayatController.text =
                regResponse!.inMigrantGramPanchayath!;
          }
          if (regResponse!.inMigrantVillage != null) {
            registrationPerVillageController.text =
                regResponse!.inMigrantVillage!;
          }
          if (regResponse!.inMigrantDuration != null) {
            durationInMonthsInController.text = regResponse!.inMigrantDuration!;
          }

          if (_migrantGroupValue == 1) {
            dropdownValueForRegDistrict =
                regResponse!.inMigrantDistrict!.id!.toString();
            /*dropdownValueForRegBlock*/ dropdownValueForUlbPresent =
                regResponse!.inMigrantBlock!.id!.toString();
          } else {
            if (regResponse!.outMigrantState != null) {
              dropdownValueForRegState =
                  regResponse!.outMigrantState!.id.toString();
            }
            if (regResponse!.outMigrantDistrict != null) {
              dropdownValueForOutRegDistrict =
                  (regResponse!.outMigrantDistrict!.id).toString();
            }
            if (regResponse!.outMigrantVillage != null) {
              registrationPerVillageOutController.text =
                  regResponse!.outMigrantVillage.toString();
            }
            if (regResponse!.outMigrantGramPanchayath != null) {
              gramPanchayatOutController.text =
                  regResponse!.outMigrantGramPanchayath.toString();
            }
            durationInMonthsController.text =
                regResponse!.outMigrantDuration.toString();
            blockOrUlbController.text = regResponse!.outMigrantBlock.toString();
          }
        }
      });

      saveWorkerApplicationDetails();
    } else if (response.statusCode == 401) {
      MyCustomText().alertDialogBoxSessionTimeOut(context);
    } else if (response.statusCode == 404) {
      MyCustomText().alertDialogBox2(context);
    } else if (response.statusCode == 500) {
      MyCustomText().alertDialogBox(context);
    }
  }
}
