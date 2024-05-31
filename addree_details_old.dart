///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/app_theme.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/block_setup_vo.dart';
import 'package:obocwwb/model/district_setup_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/model_class/ulb_setup_vo.dart';
import 'package:obocwwb/model/model_class/village_setup_vo.dart';
import 'package:obocwwb/model/model_class/ward_setup_vo.dart';
import 'package:obocwwb/model/mw_services_models/filter_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/model/panchayth_setup_vo.dart';
import 'package:obocwwb/model/state_setup.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/family_and_nominee_details.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_appllcation_deatils.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

import '../../model/application_detail_vo.dart';

class AddressDetailsFormOld extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();

  final int? id;
  final int? otrID;
  final int? workId;
  RegistrationVO? regResponse;

  AddressDetailsFormOld(
      {this.id, this.workId, this.otrID, Key? key, this.regResponse})
      : super(key: key);

  @override
  State<AddressDetailsFormOld> createState() => _AddressDetailsFormOldState();
}

class _AddressDetailsFormOldState extends State<AddressDetailsFormOld> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String? dropdownValueRegStatePermanent;
  String? dropDownValueForPanchayath;
  String? dropdownValueForRegistrationDistrictPermanent;
  String? dropdownValueForRegVillage;
  String? dropdownValueForRegistrationDistrictPresent;
  String? dropDownValueForRegBlockPresent;
  String? dropDownValueForRegBlockPermanent;
  String? dropDownValueForPresentVillage;
  String? dropDownValueForVillage;
  String? dropdownValueForUlb;
  String? dropdownValueForUlbPresent;
  String? dropdownValueForWard;
  String? dropdownValueForWardPresent;
  String? dropDownValueForPanchayathPresent;
  TextEditingController _textPermanentAddress = TextEditingController();
  TextEditingController _textPermanentGramPanchayat = TextEditingController();
  TextEditingController _textPermanentPincode = TextEditingController();
  TextEditingController _textPresentAddress = TextEditingController();
  TextEditingController _textPresentGramPanchayat = TextEditingController();
  TextEditingController _textPresentPincode = TextEditingController();
  RegistrationVO profileAddressDetailsVo = RegistrationVO();
  List stateList = [];
  List districtList = [];
  List districtListPresent = [];
  List blockList = [];
  List blockListPresent = [];
  List villageList = [];
  List villageListPermanent = [];
  List panchaythsListPermanent = [];
  List wardList = [];
  List wardListPresent = [];
  List ulbList = [];
  List ulbListPresent = [];
  List panchaythsListPresent = [];
  String? stateId;
  String? panchaythIdPresent;
  String? villageId;
  String? panchaythId;
  String? districtId;
  String? districtPresentId;
  String? ulbId;
  String? wardId;
  int _groupValue = 1;
  int? _groupValuePresent = 1;
  bool? secondCheck = false;
  bool? checkBoxValue;
  RegistrationVO? regResponse;
  RegistrationVO? regResponseNew;
  bool? loading = true;

  @override
  void initState() {
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
            body: /*loading! ? Center(child: CircularProgressIndicator(color: AppColor.primaryColor,)) : */ Container(
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
                                      "State", Colors.black),
                                  textWithoutPadding("*", Colors.red),
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
                                                Row(
                                                  children: [
                                                    textWithPaddingForProfile(
                                                        StringsEn()
                                                            .gramPanchayat,
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
                                                            panchayathDropDownPermanent(
                                                                cont, state))),

                                                /*   MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                  TextInputType.text,
                                                  StringsEn()
                                                      .gramPanchayat,
                                                  _textPermanentGramPanchayat,
                                                  false),*/
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
                                      _textPermanentPincode,
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
                                        Row(
                                          children: [
                                            textWithPaddingForProfile(
                                                StringsEn().gramPanchayat,
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
                                                child:
                                                    panchayathDropDownPresent(
                                                        cont, state))),
                                        /*MyCustomTextField()
                                          .textWithTextControllerTextField(
                                          TextInputType.text,
                                          StringsEn().gramPanchayat,
                                          _textPresentGramPanchayat,
                                          false),*/
                                      ],
                                    ),
                              SizedBox(height: 10.0),
                              MyCustomTextField()
                                  .textWithPinCodeControllerTextField(
                                      TextInputType.number,
                                      StringsEn().pincode,
                                      _textPresentPincode,
                                      false),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        saveAddressDetails(widget.otrID);
                                        Fluttertoast.showToast(
                                          msg: StringsEn().saved,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                        );
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
                      WorkerApplicationDetails(
                        regResponse: regResponse,
                      ),
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
            dropDownValueForRegBlockPermanent = null;
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
        /* var loading = false;*/
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
            dropDownValueForRegBlockPermanent = null;
            dropdownValueForRegistrationDistrictPermanent = newValue!;
            getBlocks1();
            getUlbsBlocks();
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
            dropDownValueForRegBlockPresent = null;
            dropdownValueForRegistrationDistrictPresent = newValue!;
            getBlocksPresent();
            getUlbsBlocksPresent();
          });
        },
      ),
    );
  }

  Future<void> getDistrictListPermanent() async {
    FilterVo filterVo = FilterVo();
    filterVo.stateId = dropdownValueRegStatePermanent != null
        ? int.parse(dropdownValueRegStatePermanent!)
        : int.parse(dropdownValueRegStatePermanent!);
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
        loading = false;
      });
    } else {}
  }

  villagePresentDropDown(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropDownValueForPresentVillage,
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
            dropDownValueForPresentVillage = newValue!;
            getPanchaythsListPresent();
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
        value: dropDownValueForVillage,
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
            dropDownValueForVillage = newValue!;
            /* getPanchaythsListPermanent();*/
          });
        },
      ),
    );
  }

  panchayathDropDownPermanent(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropDownValueForPanchayath,
        hint: Text(
          StringsEn().selectPanchayath,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: panchaythsListPermanent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['panchayatName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            panchaythId = newValue;
            dropDownValueForPanchayath = newValue!;
            /* getPanchaythsList_permanent();*/
          });
        },
      ),
    );
  }

  panchayathDropDownPresent(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropDownValueForPanchayathPresent,
        hint: Text(
          StringsEn().selectPanchayath,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: panchaythsListPresent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(item['panchayatName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize)),
            ),
            value: item['id'].toString(),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            panchaythIdPresent = newValue;
            dropDownValueForPanchayathPresent = newValue!;
            /* getPanchaythSList_permanent();*/
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
          value: dropDownValueForRegBlockPermanent,
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
              dropDownValueForRegBlockPermanent = newValue!;
              getVillageByBlockListPermanent();
              getPanchaythsListPermanent();
            });
          },
        ));
  }

  blockPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropDownValueForRegBlockPresent,
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
              dropDownValueForRegBlockPresent = newValue!;
              getVillageByBlockList();
              getPanchaythsListPresent();
            });
          },
        ));
  }

  Future<void> getBlocks1() async {
    FilterVo filterVo = FilterVo();
    filterVo.districtId = dropdownValueForRegistrationDistrictPermanent != null
        ? int.parse(dropdownValueForRegistrationDistrictPermanent!)
        : 0;
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
        loading = false;
      });
    } else {}
  }

  Future<void> getBlocksPresent() async {
    FilterVo filterVo = FilterVo();
    filterVo.districtId = dropdownValueForRegistrationDistrictPresent != null
        ? int.parse(dropdownValueForRegistrationDistrictPresent!)
        : 0;
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
        blockListPresent = responseBody;
        /* loading = false;*/
      });
    } else {}
  }

  Future<void> getVillageByBlockList() async {
    FilterVo filterVO = FilterVo();
    filterVO.placeId = dropDownValueForRegBlockPresent != null
        ? int.parse(dropDownValueForRegBlockPresent!)
        : 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getVillageByBlockList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        villageList = responseBody;
      });
    }
  }

  Future<void> getVillageByBlockListPermanent() async {
    FilterVo filterVO = FilterVo();
    filterVO.placeId = dropDownValueForRegBlockPermanent != null
        ? int.parse(dropDownValueForRegBlockPermanent!)
        : 0;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getVillageByBlockList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        villageListPermanent = responseBody;
      });
    }
  }

  Future<void> getPanchaythsListPermanent() async {
    FilterVO filterVO = FilterVO();
    filterVO.blockId =
            4074 /*dropDownValueForRegBlockPermanent != null
        ? int.parse(dropDownValueForRegBlockPermanent!)
        : int.parse(dropDownValueForRegBlockPermanent!)*/
        ;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getPanchaythsList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        panchaythsListPermanent = responseBody;
      });
    }
  }

  Future<void> getPanchaythsListPresent() async {
    FilterVO filterVO = FilterVO();
    filterVO.blockId =
            4074 /* dropDownValueForVillage != null
        ? int.parse(dropDownValueForVillage!)
        : 0*/
        ;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getPanchaythsList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        panchaythsListPresent = responseBody;
      });
    }
  }


  Future<void> getDistrictListPresent() async {
    FilterVo filterVo = FilterVo();
    filterVo.stateId = 21;
/*     filterVo.stateId = stateId != null ? int.parse(stateId!) : 0;*/

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
        districtListPresent = responseBody;
      });
    }
  }

  Future<void> getWardListPresent() async {
    FilterVo filterVO = FilterVo();
    filterVO.placeId = dropdownValueForUlbPresent != null
        ? int.parse(dropdownValueForUlbPresent!)
        : int.parse(dropdownValueForUlb!);
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    String encodedData = convert.jsonEncode(filterVO);
    var res = await Api.getWardEst(encodedData, headers);
    if (res.statusCode == 200) {
      var responseBody = json.decode(res.body);
      setState(() {
        wardListPresent = responseBody;
      });
    }
  }

  Future<void> getWardList() async {
    FilterVo filterVO = FilterVo();
    filterVO.placeId = dropdownValueForUlb != null
        ? int.parse(dropdownValueForUlb!)
        : int.parse(dropdownValueForUlb!);
    Map<String, String> headers = {
      'content-type': 'application/json',
    };
    String encodedData = convert.jsonEncode(filterVO);
    var res = await Api.getWardEst(encodedData, headers);
    if (res.statusCode == 200) {
      var responseBody = json.decode(res.body);
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

  Future<void> getUlbsBlocksPresent() async {
    FilterVo filter = FilterVo();
    filter.districtId =
        districtPresentId != null ? int.parse(districtPresentId!) : 0;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filter);
    var response = await Api.ulbsBlocks(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        ulbListPresent = responseBody;
      });
    } else {}
  }

  Future<void> getUlbsBlocks() async {
    FilterVo filterVO = FilterVo();
    filterVO.districtId = districtId != null ? int.parse(districtId!) : 0;
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
        ulbList = responseBody;
        loading = false;
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
    profileAddressDetails.id = pref.getInt('workerId');
    profileAddressDetails = widget.regResponse!;

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

      if (dropdownValueRegStatePermanent != null) {
        profileAddressDetails.permanentState!.id =
            int.parse(/*stateId*/ dropdownValueRegStatePermanent!);
      }
      profileAddressDetails.permanentDistrict = DistrictSetupVo();
      if (dropdownValueForRegistrationDistrictPermanent != null) {
        profileAddressDetails.permanentDistrict!.id =
            int.parse(dropdownValueForRegistrationDistrictPermanent!);
      } else {
        profileAddressDetails.permanentDistrict!.id = 0;
      }
      profileAddressDetails.permanentBlock = BlockSetUpVo();
      if (dropDownValueForRegBlockPermanent != null) {
        profileAddressDetails.permanentBlock!.id =
            int.parse(dropDownValueForRegBlockPermanent!);
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
      if (dropDownValueForVillage != null) {
        profileAddressDetails.permanentVillageSetup!.id =
            int.parse(/*villageId*/ dropDownValueForVillage!);
      }
      profileAddressDetails.presentVillageSetup = VillageSetupVO();
      if (dropDownValueForPresentVillage != null) {
        profileAddressDetails.presentVillageSetup!.id =
            int.parse(dropDownValueForPresentVillage!);
      }
      profileAddressDetails.permanentPanchayth = PanchaythSetupVO();
      if (dropDownValueForPanchayath != null) {
        profileAddressDetails.permanentPanchayth!.id =
            int.parse(dropDownValueForPanchayath!);
      }
      profileAddressDetails.presentPanchayth = PanchaythSetupVO();
      if (dropDownValueForPanchayathPresent != null) {
        profileAddressDetails.presentPanchayth!.id =
            int.parse(dropDownValueForPanchayathPresent!);
      }

      profileAddressDetails.permanentGramaPanchayat =
          _textPermanentGramPanchayat.text;
      profileAddressDetails.permanentPostOffice = _textPermanentPincode.text;
      profileAddressDetails.presentAddress = _textPresentAddress.text;
      profileAddressDetails.presentDistrict = DistrictSetupVo();
      if (dropdownValueForRegistrationDistrictPresent != null) {
        profileAddressDetails.presentDistrict!.id =
            int.parse(dropdownValueForRegistrationDistrictPresent!);
      }
      profileAddressDetails.presentBlock = BlockSetUpVo();
      if (dropDownValueForRegBlockPresent != null) {
        profileAddressDetails.presentBlock!.id =
            int.parse(dropDownValueForRegBlockPresent!);
      }
      profileAddressDetails.presentUlbSetup = UlbSetupVO();
      if (dropdownValueForUlbPresent != null) {
        profileAddressDetails.presentUlbSetup!.id =
            int.parse(dropdownValueForUlbPresent!);
      }
      profileAddressDetails.presentGramaPanchayat =
          _textPermanentGramPanchayat.text;
      profileAddressDetails.presentPostOffice = _textPresentPincode.text;

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
                  profileAddressDetailsVo: profileAddressDetailsVo)));
          Fluttertoast.showToast(
              msg:
              "Saved",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blueGrey,
              textColor: Colors.white,
              fontSize: 16.0);
       /*   final snackBar = SnackBar(content: Text('Saved!'));
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
    getUlbsBlocksPresent();
    getBlocksPresent();
    getWardListPresent();
    dropdownValueForUlbPresent = dropdownValueForUlb;
    dropdownValueForWardPresent = dropdownValueForWard;
    dropDownValueForRegBlockPresent = dropDownValueForRegBlockPermanent;
    dropDownValueForPanchayathPresent = dropDownValueForPanchayath;

    getVillageByBlockList();
    getPanchaythsListPresent();
    dropDownValueForPresentVillage = dropDownValueForVillage;
    _textPresentPincode.text = _textPermanentPincode.text;
    _textPresentGramPanchayat.text = _textPermanentGramPanchayat.text;
  }

  void getRegistrationDetails() async {
    RegistrationVO registration = RegistrationVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    registration.oneTimeRegistration = OneTimeRegistration();
    registration.oneTimeRegistration!.id = preferences.getInt('otrID');
    /*registration = widget.regResponse!;*/

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
        _textPermanentAddress.text = regResponse!.permanentAddress.toString();
        _groupValue = regResponse!.permanentRuralOrUrban! == "U" ? 1 : 2;

        if (regResponse!.permanentState != null) {
          dropdownValueRegStatePermanent =
              regResponse!.permanentState!.id!.toString();
        }
        if (regResponse!.permanentDistrict != null) {
          dropdownValueForRegistrationDistrictPermanent =
              regResponse!.permanentDistrict!.id.toString();
        }

        if (regResponse!.permanentBlock != null) {
          dropDownValueForRegBlockPermanent =
              regResponse!.permanentBlock!.id!.toString();
        }
        if (regResponse!.permanentVillageSetup != null) {
          dropDownValueForVillage =
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
            regResponse!.permanentGramaPanchayat.toString();
        if (regResponse!.permanentPostOffice != null) {
          _textPermanentPincode.text = regResponse!.permanentPostOffice!;
        }

        _textPresentAddress.text = regResponse!.presentAddress.toString();
        _groupValuePresent = regResponse!.presentRuralOrUrban! == "U" ? 1 : 2;
        if (regResponse!.presentDistrict != null) {
          dropdownValueForRegistrationDistrictPresent =
              regResponse!.presentDistrict!.id!.toString();
        }
        if (regResponse!.presentBlock != null) {
          dropDownValueForRegBlockPresent =
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
          dropDownValueForPresentVillage =
              regResponse!.presentVillageSetup!.id!.toString();
        }

        if (regResponse!.permanentPanchayth != null) {
          dropDownValueForPanchayath =
              regResponse!.permanentPanchayth!.id.toString();
        }

        if (regResponse!.presentPanchayth != null) {
          dropDownValueForPanchayathPresent =
              regResponse!.presentPanchayth!.id.toString();
        }
        _textPresentGramPanchayat.text =
            regResponse!.presentGramaPanchayat.toString();
        _textPresentPincode.text = regResponse!.presentPostOffice!;
        getDistrictListPermanent();
        getBlocks1();
        getUlbsBlocks();
        getWardList();
        getVillageByBlockListPermanent();
        getDistrictListPresent();
        getBlocksPresent();
        getUlbsBlocksPresent();
        getWardListPresent();
        getVillageByBlockList();
        getPanchaythsListPermanent();
        getPanchaythsListPresent();
      });
      /*   saveAddressDetails(widget.otrID);*/
    }
  }
}
