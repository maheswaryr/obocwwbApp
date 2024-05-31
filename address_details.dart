///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/app_theme.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/controller/reg_controller.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';

import 'package:obocwwb/model/block_setup_vo.dart';
import 'package:obocwwb/model/district_setup_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/model_class/village_setup_vo.dart';
import 'package:obocwwb/model/mw_services_models/filter_vo.dart';
import 'package:obocwwb/model/model_class/ulb_setup_vo.dart';
import 'package:obocwwb/model/model_class/ward_setup_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/model/state_setup.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';

import 'package:obocwwb/obocwwb_ui/application_for_registration/family_and_nominee_details.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_appllcation_deatils.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../model/application_detail_vo.dart';

class AddressDetailsForm extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();

  final int? id;
  final int? otrID;
  final int? workId;
  final RegistrationVO? registration;

  AddressDetailsForm(
      {this.id, this.workId, this.otrID, Key? key, this.registration})
      : super(key: key);

  @override
  State<AddressDetailsForm> createState() => _AddressDetailsFormState();
}

class _AddressDetailsFormState extends State<AddressDetailsForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? dropdownValueRegStatePermanent;
  String? dropdownValueForRegistrationDistrictPermanent;
  String? dropdownValueForRegVillage;
  String? dropdownValueForRegistrationDistrictPresent;
  String? dropdownValueForRegBlockPresent;
  String? dropdownValueForRegBlockPermanent;
  String? dropdownValueForPresentVillage;
  String? dropdownValueForVillage;
  String? dropdownValueForUlb;
  String? dropdownValueForUlbPresent;
  String? dropdownValueForWard;
  String? dropdownValueForWardPresent;
  TextEditingController _textPermanentAddress = TextEditingController();
  TextEditingController _textPermanentGramPanchayat = TextEditingController();
  TextEditingController _textPermanentPinCode = TextEditingController();
  TextEditingController _textPresentAddress = TextEditingController();
  TextEditingController _textPresentGramPanchayat = TextEditingController();
  TextEditingController _textPresentPinCode = TextEditingController();
  RegistrationVO profileAddressDetailsVo = RegistrationVO();
  List stateList = [];
  List districtList = [];
  List districtListPresent = [];
  List blockList = [];
  List blockListPresent = [];
  List villageList = [];
  List villageListPermanent = [];
  List wardList = [];
  List wardListPresent = [];
  List ulbList = [];
  List ulbListPresent = [];
  String? stateId;
  String? villageId;
  String? districtId;
  String? districtPresentId;
  String? ulbId;
  String? wardId;
  int _groupValue = 1;
  int? _groupValuePresent = 1;
  bool? secondCheck = false;
  bool? checkBoxValue;
  RegistrationVO? regResponse;
  bool? loading = true;

  @override
  void initState() {
    super.initState();
    getStateList();
    getDistrictListPresent();
    getRegistrationDetails();
  }

  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                StringsEn().Return,
                style: TextStyle(fontSize: AppDigits.titleSize),
              ),
              content: Text(StringsEn().doYouReallyWantToExit),
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

    return StatefulBuilder(
      builder: (BuildContext cont, StateSetter state) {
        return WillPopScope(
          onWillPop: showExitPopup,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                title: Text(StringsEn()
                    .applicationForRegistrationOfBuildingAndConstructionWorkers),
                backgroundColor: AppColor.primaryColor),
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
                              headerCard(StringsEn().permanentAddress),
                              SizedBox(height: 20.0),
                              MyCustomTextField()
                                  .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().address,
                                      _textPermanentAddress,
                                      false),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CustomRadioButton(
                                      text: "Urban",
                                      value: 1,
                                      groupValue: _groupValue,
                                      onChanged: (newValue) => setState(
                                          () => _groupValue = newValue),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomRadioButton(
                                      text: "Rural",
                                      value: 2,
                                      groupValue: _groupValue,
                                      onChanged: (newValue) => setState(
                                          () => _groupValue = newValue),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  textWithPaddingForProfile(
                                      StringsEn().state, Colors.black),
                                  textWithoutPadding("*", Colors.red),
                                ],
                              ),
                              /*       stateListDropDown(cont, state),*/
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: stateListDropDown(cont, state))),
                              Row(
                                children: [
                                  textWithPaddingForProfile(
                                      StringsEn().district, Colors.black),
                                  textWithoutPadding("*", Colors.red)
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: districtDropDown(cont, state))),
                              _groupValue == 1
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              textWithPaddingForProfile(
                                                  StringsEn().uLB,
                                                  Colors.black),
                                              textWithoutPadding(
                                                  "*", Colors.red),
                                            ],
                                          ),
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
                                                  child: ulbDropDown(
                                                      cont, state))),
                                          Row(
                                            children: [
                                              textWithPaddingForProfile(
                                                  StringsEn().ward,
                                                  Colors.black),
                                              textWithoutPadding(
                                                  "*", Colors.red),
                                            ],
                                          ),
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
                                                  child: wardDropDown(
                                                      cont, state))),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(0),
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
                                                bottomLeft:
                                                    Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
                                                topRight: Radius.circular(8.0),
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    textWithPaddingForProfile(
                                                        StringsEn().block,
                                                        Colors.black),
                                                    textWithoutPadding(
                                                        "*", Colors.red)
                                                  ],
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12)),
                                                        child:
                                                            blockPermanentDropDown(
                                                                cont, state))),
                                                Row(
                                                  children: [
                                                    textWithPaddingForProfile(
                                                        StringsEn().village,
                                                        Colors.black),
                                                    textWithoutPadding(
                                                        "*", Colors.red),
                                                  ],
                                                ),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10.0,
                                                            right: 10.0),
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        0),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black12)),
                                                        child:
                                                            villageDropDownPermanent(
                                                                cont, state))),
                                                SizedBox(
                                                  height: AppDigits.fontSize,
                                                ),
                                                MyCustomTextField()
                                                    .textWithTextControllerTextField(
                                                        TextInputType.text,
                                                        StringsEn()
                                                            .gramPanchayat,
                                                        _textPermanentGramPanchayat,
                                                        false),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                              SizedBox(height: 10.0),
                              MyCustomTextField()
                                  .textWithPinCodeControllerTextField(
                                      TextInputType.number,
                                      StringsEn().pincode,
                                      _textPermanentPinCode,
                                      false),
                              SizedBox(height: 10.0),
                              CheckboxListTile(
                                title: Text(
                                  StringsEn()
                                      .checkIfPresentAddressSameAsPermanentAddress,
                                  style:
                                      TextStyle(fontSize: AppDigits.fontSize),
                                ),
                                value: secondCheck,
                                onChanged: (bool? value) {
                                  setState(() {
                                    secondCheck = value!;
                                    if (secondCheck == true) {
                                      copyAddress();
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                          StringsEn()
                                              .presentStateMustBeOdisha,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueGrey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                     /* _scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(
                                              content: Text(StringsEn()
                                                  .presentStateMustBeOdisha)));*/
                                    }
                                  });
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                              ),
                              headerCard(StringsEn().presentAddress),
                              SizedBox(height: 20.0),
                              MyCustomTextField()
                                  .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().address,
                                      _textPresentAddress,
                                      false),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: CustomRadioButton(
                                      text: "Urban",
                                      value: 1,
                                      groupValue: _groupValuePresent,
                                      onChanged: (newValue) => setState(
                                          () => _groupValuePresent = newValue),
                                    ),
                                  ),
                                  Expanded(
                                    child: CustomRadioButton(
                                      text: "Rural",
                                      value: 2,
                                      groupValue: _groupValuePresent,
                                      onChanged: (newValue) => setState(
                                          () => _groupValuePresent = newValue),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  textWithPaddingForProfile(
                                      StringsEn().district, Colors.black),
                                  textWithoutPadding("*", Colors.red)
                                ],
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          border: Border.all(
                                              color: Colors.black12)),
                                      child: districtDropDownForPresent(
                                          cont, state))),
                              _groupValuePresent == 1
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              textWithPaddingForProfile(
                                                  StringsEn().uLB,
                                                  Colors.black),
                                              textWithoutPadding(
                                                  "*", Colors.red),
                                            ],
                                          ),
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
                                                  child: ulbPresentDropDown(
                                                      cont, state))),
                                          Row(
                                            children: [
                                              textWithPaddingForProfile(
                                                  StringsEn().ward,
                                                  Colors.black),
                                              textWithoutPadding(
                                                  "*", Colors.red),
                                            ],
                                          ),
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
                                                  child: wardDropDownPresent(
                                                      cont, state))),
                                        ],
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          children: [
                                            textWithPaddingForProfile(
                                                StringsEn().block,
                                                Colors.black),
                                            textWithoutPadding("*", Colors.red)
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    border: Border.all(
                                                        color: Colors.black12)),
                                                child: blockPresentDropDown(
                                                    cont, state))),
                                        Row(
                                          children: [
                                            textWithPaddingForProfile(
                                                StringsEn().village,
                                                Colors.black),
                                            textWithoutPadding("*", Colors.red),
                                          ],
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0, right: 10.0),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                    border: Border.all(
                                                        color: Colors.black12)),
                                                child: villagePresentDropDown(
                                                    cont, state))),
                                        SizedBox(
                                          height: AppDigits.fontSize,
                                        ),
                                        MyCustomTextField()
                                            .textWithTextControllerTextField(
                                                TextInputType.text,
                                                StringsEn().gramPanchayat,
                                                _textPresentGramPanchayat,
                                                false),
                                      ],
                                    ),
                              SizedBox(height: 10.0),
                              MyCustomTextField()
                                  .textWithPinCodeControllerTextField(
                                      TextInputType.number,
                                      StringsEn().pincode,
                                      _textPresentPinCode,
                                      false),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        saveAddressDetails(widget.otrID);
                                      }
                                    },
                                    child: Text(StringsEn().save),
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
                      WorkerApplicationDetails(),
                      FamilyAndNomineeDetails(),
                      "3",
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  stateListDropDown(BuildContext context, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueRegStatePermanent,
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
            stateId = newValue;
            dropdownValueForRegistrationDistrictPermanent = null;
            dropdownValueForWard = null;
            dropdownValueForUlb = null;
            dropdownValueForRegBlockPermanent = null;
            dropdownValueRegStatePermanent = newValue!;
            getDistrictListPermanent();
          });
        },
      ),
    );
  }

  Future<void> getStateList() async {
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
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            districtId = newValue;
            dropdownValueForUlb = null;
            dropdownValueForWard = null;
            dropdownValueForRegBlockPermanent = null;
            dropdownValueForRegistrationDistrictPermanent = newValue!;
            getBlocks1();
            getUlbSBlocks();
          });
        },
      ),
    );
  }

  districtDropDownForPresent(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForRegistrationDistrictPresent,
        hint: Text(
          StringsEn().selectDistrict,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: districtListPresent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['districtName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        // After selecting the desired option,it will change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            districtPresentId = newValue;
            dropdownValueForWardPresent = null;
            dropdownValueForUlbPresent = null;
            dropdownValueForRegBlockPresent = null;
            dropdownValueForRegistrationDistrictPresent = newValue!;
            getBlocksPresent();
            getUlbSBlocksPresent();
          });
        },
      ),
    );
  }

  Future<void> getDistrictListPermanent() async {
    FilterVo filterVo = FilterVo();
    filterVo.stateId = dropdownValueRegStatePermanent != null
        ? int.parse(dropdownValueRegStatePermanent!)
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
        districtList = responseBody;
      });
    } else {}
  }

  villagePresentDropDown(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValueForPresentVillage,
        hint: Text(
          StringsEn().selectVillage,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: villageList.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['name'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValueForPresentVillage = newValue!;
          });
        },
      ),
    );
  }

  villageDropDownPermanent(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValueForVillage,
        hint: Text(
          StringsEn().selectVillage,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: villageListPermanent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['name'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            villageId = newValue;
            dropdownValueForVillage = newValue!;
          });
        },
      ),
    );
  }

  blockPermanentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropdownValueForRegBlockPermanent,
          hint: Text(
            StringsEn().selectBlock,
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
              dropdownValueForRegBlockPermanent = newValue!;
              getVillageByBlockListPermanent();
            });
          },
        ));
  }

  blockPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropdownValueForRegBlockPresent,
          hint: Text(
            StringsEn().selectBlock,
            style: TextStyle(fontSize: AppDigits.fontSize),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: blockListPresent.map((item) {
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
              dropdownValueForRegBlockPresent = newValue!;
              getVillageByBlockList();
            });
          },
        ));
  }

  Future<void> getBlocks1() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    FilterVo filterVo = FilterVo();
    filterVo.districtId = dropdownValueForRegBlockPermanent != null
        ? int.parse(dropdownValueForRegBlockPermanent!)
        : 0;
    String encodedData = convert.jsonEncode(filterVo);
    /*  var response = Impl().blockGet1(districtId);*/
    var response = await Api.getBlocks(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        blockList = responseBody;
      });
    } else {}
  }

  Future<void> getBlocksPresent() async {
    var response =
        Impl().blockPresentGet(dropdownValueForRegistrationDistrictPresent);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        blockListPresent = responseBody;
      });
    } else {}
  }

  Future<void> getVillageByBlockList() async {
    var response =
        Impl().villageByBlockListGet(dropdownValueForRegBlockPresent!);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        villageList = responseBody;
      });
    }
  }

  Future<void> getVillageByBlockListPermanent() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    FilterVO filterVO = FilterVO();
    filterVO.blockId = villageId != null ? int.parse(villageId!) : 0;
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getVillageByBlockList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        villageListPermanent = responseBody;
      });
    }
  }

  Future<void> getDistrictListPresent() async {
    var response = Impl().districtListPresentGet();
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        districtListPresent = responseBody;
      });
    }
  }

  Future<void> getWardListPresent() async {
    var response =
        Impl().wardListGet(dropdownValueForUlbPresent, dropdownValueForUlb);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        wardListPresent = responseBody;
      });
    }
  }

  Future<void> getWardList() async {
    var response = Impl().getWardList(dropdownValueForUlb);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        wardList = responseBody;
      });
    }
  }

  wardDropDownPresent(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForWardPresent,
        hint: Text(
          StringsEn().selectWard,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: wardListPresent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['name'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownValueForWardPresent = newValue!;
          });
        },
      ),
    );
  }

  wardDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForWard,
        hint: Text(
          StringsEn().selectWard,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: wardList.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['name'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            wardId = newValue;
            dropdownValueForWard = newValue!;
          });
        },
      ),
    );
  }

  Future<void> getUlbSBlocksPresent() async {
    var response = Impl().getUlbSBlocksPresent(districtPresentId);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        ulbListPresent = responseBody;
      });
    } else {}
  }

  Future<void> getUlbSBlocks() async {
    var response = Impl().getUlbSBlocks(districtId);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        ulbList = responseBody;
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
          StringsEn().selectULB,
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
            dropdownValueForWardPresent = null;
            dropdownValueForUlbPresent = newValue!;
            getWardListPresent();
          });
        },
      ),
    );
  }

  ulbDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForUlb,
        hint: Text(
          StringsEn().selectULB,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: ulbList.map((item) {
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
            ulbId = newValue;
            dropdownValueForWard = null;
            dropdownValueForUlb = newValue!;
            getWardList();
          });
        },
      ),
    );
  }

  Future<void> saveAddressDetails(int? otrID) async {
    RegistrationVO profileAddressDetails = RegistrationVO();
    SharedPreferences pref = await SharedPreferences.getInstance();

    String? token = pref.getString("token");
    profileAddressDetails = regResponse!;
    profileAddressDetails.id = pref.getInt('workerId');
    profileAddressDetails.oneTimeRegistration = OneTimeRegistration();
    profileAddressDetails.oneTimeRegistration!.id = pref.getInt('otrID');
    profileAddressDetails.oneTimeRegistration!.alreadyRegistred = "N";

    try {
      profileAddressDetails.permanentAddress = _textPermanentAddress.text;
      profileAddressDetails.permanentState = StateSetup();

      if (_groupValue == 1) {
        profileAddressDetails.permanentRuralOrUrban = "U";
      } else {
        profileAddressDetails.permanentRuralOrUrban = "R";
      }

      if (_groupValuePresent == 1) {
        profileAddressDetails.presentRuralOrUrban = "U";
      } else {
        profileAddressDetails.presentRuralOrUrban = "R";
      }

      if (stateId != null) {
        profileAddressDetails.permanentState!.id = int.parse(stateId!);
      }
      profileAddressDetails.permanentDistrict = DistrictSetupVo();
      if (dropdownValueForRegistrationDistrictPermanent != null) {
        profileAddressDetails.permanentDistrict!.id =
            int.parse(dropdownValueForRegistrationDistrictPermanent!);
      } else {
        profileAddressDetails.permanentDistrict!.id = 0;
      }
      profileAddressDetails.permanentBlock = BlockSetUpVo();
      if (dropdownValueForRegBlockPermanent != null) {
        profileAddressDetails.permanentBlock!.id =
            int.parse(dropdownValueForRegBlockPermanent!);
      }
      profileAddressDetails.permanentUlbSetup = UlbSetupVO();
      if (ulbId != null) {
        profileAddressDetails.permanentUlbSetup!.id = int.parse(ulbId!);
      }
      profileAddressDetails.permanentWardSetup = WardSetupVO();
      if (wardId != null) {
        profileAddressDetails.permanentWardSetup!.id = int.parse(wardId!);
      }
      profileAddressDetails.presentWardSetup = WardSetupVO();
      if (dropdownValueForWardPresent != null) {
        profileAddressDetails.presentWardSetup!.id =
            int.parse(dropdownValueForWardPresent!);
      }
      profileAddressDetails.permanentVillageSetup = VillageSetupVO();
      if (villageId != null) {
        profileAddressDetails.permanentVillageSetup!.id = int.parse(villageId!);
      }
      profileAddressDetails.presentVillageSetup = VillageSetupVO();
      if (dropdownValueForPresentVillage != null) {
        profileAddressDetails.presentVillageSetup!.id =
            int.parse(dropdownValueForPresentVillage!);
      }
      profileAddressDetails.permanentGramaPanchayat =
          _textPermanentGramPanchayat.text;
      profileAddressDetails.permanentPostOffice = _textPermanentPinCode.text;
      profileAddressDetails.presentAddress = _textPresentAddress.text;
      profileAddressDetails.presentDistrict = DistrictSetupVo();
      if (dropdownValueForRegistrationDistrictPresent != null) {
        profileAddressDetails.presentDistrict!.id =
            int.parse(dropdownValueForRegistrationDistrictPresent!);
      }
      profileAddressDetails.presentBlock = BlockSetUpVo();
      if (dropdownValueForRegBlockPresent != null) {
        profileAddressDetails.presentBlock!.id =
            int.parse(dropdownValueForRegBlockPresent!);
      }
      profileAddressDetails.presentUlbSetup = UlbSetupVO();
      if (dropdownValueForUlbPresent != null) {
        profileAddressDetails.presentUlbSetup!.id =
            int.parse(dropdownValueForUlbPresent!);
      }
      profileAddressDetails.presentGramaPanchayat =
          _textPermanentGramPanchayat.text;
      profileAddressDetails.presentPostOffice = _textPresentPinCode.text;

      Map<String, String> headers = {
        'content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };

      String encodedData = convert.jsonEncode(profileAddressDetails);

      var response = await Api.saveWorkerRegistration(encodedData, headers);

      if (response.statusCode == 200) {
        profileAddressDetailsVo =
            RegistrationVO.fromJson(convert.jsonDecode(response.body));
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FamilyAndNomineeDetails(
                  profileAddressDetailsVo: regResponse)));
          Fluttertoast.showToast(
              msg:
             "Saved!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0);
      /*    final snackBar = SnackBar(content: Text('Saved!'));
          _scaffoldKey.currentState!.showSnackBar(snackBar);*/
        });
      } else {
        if (response.statusCode == 401) {
          MyCustomText().alertDialogBoxSessionTimeOut(context);
        }
      }
    } catch (e) {}
  }

  void copyAddress() {
    _textPresentAddress.text = _textPermanentAddress.text;
    _groupValuePresent = _groupValue;
    dropdownValueForRegistrationDistrictPresent =
        dropdownValueForRegistrationDistrictPermanent;
    getUlbSBlocksPresent();
    getBlocksPresent();
    getWardListPresent();
    dropdownValueForUlbPresent = dropdownValueForUlb;
    dropdownValueForWardPresent = dropdownValueForWard;
    dropdownValueForRegBlockPresent = dropdownValueForRegBlockPermanent;
    getVillageByBlockList();
    dropdownValueForPresentVillage = dropdownValueForVillage;
    _textPresentPinCode.text = _textPermanentPinCode.text;
    _textPresentGramPanchayat.text = _textPermanentGramPanchayat.text;
  }

  void getRegistrationDetails() async {
    var response = Impl().registrationDetailsGet();
    if (response.statusCode == 200) {
      regResponse = RegistrationVO.fromJson(convert.jsonDecode(response.body));
      setState(() {
        _textPermanentAddress.text = regResponse!.permanentAddress.toString();
        _groupValue = regResponse!.permanentRuralOrUrban! == "U" ? 1 : 2;
        if (regResponse!.permanentState!.id != null) {
          dropdownValueRegStatePermanent =
              regResponse!.permanentState!.id.toString();
        }
        if (regResponse!.permanentDistrict!.id != null) {
          dropdownValueForRegistrationDistrictPermanent =
              regResponse!.permanentDistrict!.id.toString();
        }

        if (regResponse!.permanentBlock != null) {
          dropdownValueForRegBlockPermanent =
              regResponse!.permanentBlock!.id!.toString();
        }
        if (regResponse!.permanentVillageSetup != null) {
          dropdownValueForVillage =
              regResponse!.permanentVillageSetup!.id!.toString();
        }
        if (regResponse!.permanentUlbSetup != null) {
          dropdownValueForUlb = regResponse!.permanentUlbSetup!.id!.toString();
        }
        if (regResponse!.permanentWardSetup != null) {
          dropdownValueForWard =
              regResponse!.permanentWardSetup!.id!.toString();
        }
        _textPermanentGramPanchayat.text =
            regResponse!.permanentGramaPanchayat!;
        _textPermanentPinCode.text = regResponse!.permanentPostOffice!;

        _textPresentAddress.text = regResponse!.presentAddress!;
        _groupValuePresent = regResponse!.presentRuralOrUrban! == "U" ? 1 : 2;
        if (regResponse!.presentDistrict != null) {
          dropdownValueForRegistrationDistrictPresent =
              regResponse!.presentDistrict!.id!.toString();
        }
        if (regResponse!.presentBlock != null) {
          dropdownValueForRegBlockPresent =
              regResponse!.presentBlock!.id!.toString();
        }
        if (regResponse!.presentUlbSetup != null) {
          dropdownValueForUlbPresent =
              regResponse!.presentUlbSetup!.id!.toString();
        }
        if (regResponse!.presentWardSetup != null) {
          dropdownValueForWardPresent =
              regResponse!.presentWardSetup!.id!.toString();
        }
        if (regResponse!.presentVillageSetup != null) {
          dropdownValueForPresentVillage =
              regResponse!.presentVillageSetup!.id!.toString();
        }
        _textPresentGramPanchayat.text = regResponse!.presentGramaPanchayat!;
        _textPresentPinCode.text = regResponse!.presentPostOffice!;
        getDistrictListPermanent();
        getBlocks1();
        getUlbSBlocks();
        getWardList();
        getVillageByBlockListPermanent();
        getDistrictListPresent();
        getBlocksPresent();
        getUlbSBlocksPresent();
        getWardListPresent();
        getVillageByBlockList();
        loading = false;
      });
    }
  }
}
