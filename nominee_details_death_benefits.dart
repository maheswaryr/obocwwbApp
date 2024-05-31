///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button_save.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';

import 'package:obocwwb/custom_widgets/custom_dropdown/custom_dropdown_widget.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';
import 'package:obocwwb/custom_widgets/custom_list.dart';
import 'package:obocwwb/custom_widgets/custom_nominee_details_widget.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/bank_details_vo.dart';
import 'package:obocwwb/model/block_setup_vo.dart';
import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';

import 'package:obocwwb/model/death_Benefits_Models/death_benefit_vo.dart';
import 'package:obocwwb/model/death_Benefits_Models/legalheir_death_benefit_vo.dart';
import 'package:obocwwb/model/district_setup_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/funeral_expenses/filter_vo.dart';
import 'package:obocwwb/model/funeral_expenses/registration_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/model_class/relation_setup_vo.dart';
import 'package:obocwwb/model/model_class/ulb_setup_vo.dart';
import 'package:obocwwb/model/model_class/village_setup_vo.dart';
import 'package:obocwwb/model/model_class/ward_setup_vo.dart';
import 'package:obocwwb/model/mw_services_models/filter_vo.dart';
import 'package:obocwwb/model/nominee.dart';
import 'package:obocwwb/model/profile_address_details_vo.dart';
import 'package:obocwwb/model/profile_general_details.dart';
import 'package:obocwwb/model/profile_nominee_details_vo.dart';
import 'package:obocwwb/model/registration_Models/filter_vo.dart';
import 'package:obocwwb/model/state_setup.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/subscription_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/supporting_documents_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'dart:convert' as convert;

import '../../model/application_detail_vo.dart';
import '../../strings_en.dart';

class NomineeDetailsDeathBenefitsForm extends StatefulWidget {
  ApplicationDetailVo initiate = ApplicationDetailVo();
  NomineeDetailsDeathBenefitsForm({required this.initiate}) : super();

  @override
  NomineeDetailsDeathBenefitsFormState createState() =>
      NomineeDetailsDeathBenefitsFormState();
}

class NomineeDetailsDeathBenefitsFormState
    extends State<NomineeDetailsDeathBenefitsForm> {
  List<NomineeDetailsVO> nomineeDetailsList = [];
  List? customList;
  bool loading = true;
  bool? displayLegalHeir = false;

  int _groupValue = 1;
  String? blockId;
  List villageList = [];
  String? dropdownValueForUlb;
  //type of death
  String? typeOfDeathChoose;
  List<DropDownVO> typeOfDeathList = MyCustomList().typeOfDeathList;
  //place of death
  TextEditingController _textPlaceOfDeathController =
      TextEditingController();
  //date of death
  TextEditingController _textDateOfDeathController =
      TextEditingController();
  //cause of death
  TextEditingController _textCauseOfDeathController =
      TextEditingController();
  //Which registered nominee is applying for the grant
  String selectNomineeText = "--- Select Nominee ---";
  int selectNomineeId = 0;
  List districtListPresent = [];
  List ulbListPresent = [];
  List wardListPresent = [];
  String? bankId;
  String? dropdownValueRegStatePermanent;
  String? dropdownValueForUlbPresent;
  String? dropdownValueForWardPresent;
  String? dropdownValueForRegBlockPermanent;
  String? dropdownValueForRegistrationDistrictPresent;
  String? relationDropdownValue;
  ProfileNomineeDetailsVO objNomineeDetailsVo = ProfileNomineeDetailsVO();
  String? districtId;
  List blockListPresent = [];
  List relationList = [];
  List bankList = [];
  //relationship
  String? relationshipChoose;
  List<DropDownVO> relationshipList = MyCustomList().relationshipList;
  //legal heir name
  TextEditingController _textLegalHeirNameController =
      TextEditingController();
  //legal heir date of birth
  TextEditingController _textLegalHeirDoBController =
      TextEditingController();
  //legal heir aadhaar number
  TextEditingController _textLegalHeirAadhaarNumberController =
      TextEditingController();
  //legal heir mobile number
  TextEditingController _textLegalHeirMobileNumberController =
      TextEditingController();
  //legal heir address
  TextEditingController _textLegalHeirAddressController =
      TextEditingController();
  //legal heir  state
  String? legalHeirStateChoose;
  List legalHeirStateList = [];
  List blockList = [];
  String? districtPresentId;
  String? dropdownValueForRegBlockPresent;
  String? dropdownValueForPresentVillage;
  StateSetup? legalHeirStateObj;
  //legal heir district
  String? legalHeirDistrictChoose;
  List legalHeirDistrictList = [];
  DistrictSetupVo? legalHeirDistrictObj;
  String? stateId;
  //legal heir block
  String? legalHeirBlockChoose;
  List legalHeirBlockList = [];
  BlockSetUpVo? legalHeirBlockObj;
  //legal heir gram panchayat
  TextEditingController _textLegalHeirGramPanchayatController =
      TextEditingController();
  //legal heir village
  //legal heir pincode
  TextEditingController _textLegalHeirPinCodeController =
      TextEditingController();
  //bank Name
  String? legalHeirBankNameChoose;
  List legalHeirBankNameList = [];
  BankDetailsVo? legalHeirBankNameObj;

  //branch Name
  TextEditingController _textBranchNameController = TextEditingController();
  //IFSC
  TextEditingController _textIfscController = TextEditingController();
  //Aadhaar Linked bank account number
  TextEditingController _textAadhaarLinkedAccountNoController =
      TextEditingController();
  TextEditingController _textConfirmAccountNo = TextEditingController();

  DeathBenefitVO saveOtherDetailsDeathBenefit = DeathBenefitVO();
  LegalHeirDeathBenefitVO saveLegalHeirDetailsDeathBenefit =
      LegalHeirDeathBenefitVO();

  ProfileGeneralDetailsVo generalDetails = ProfileGeneralDetailsVo();
  FilterVO filterVO = FilterVO();
  ProfileAddressDetailsVo addressDetails = ProfileAddressDetailsVo();

  int? _groupValuePresent = 1;
  String? relationId;

  @override
  void initState() {
    getStateList();
    getDistrictList();
    getBlockList();
    getBankList();
    getAllActiveBankDetails();
    getWorkerNomineeDetails();
    getAllActiveRelationSetup();
    findGeneralDetailsByWorkerId();
    getRegistrationDateByWorkerId();
    findAddressDetailsByWorkerId();
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
                      builder: (context) => HomePage(),
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
      child: StatefulBuilder(builder: (BuildContext cont, StateSetter state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(StringsEn().deathBenefitApplicationForm),
            backgroundColor: AppColor.primaryColor,
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                loading
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
                    : Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                               Padding(
                                     padding: const EdgeInsets.only(left: 4,right: 4,top: 4),
                                     child: headerCard(
                                         StringsEn().listOfNomineeDetails),
                                   ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, bottom: 5.0, right: 10.0),
                                      child: CustomNomineeDetailsWidget(
                              
                                        nomineeDetailsListNew:
                                            nomineeDetailsList,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                  ],
                                ),
                                //other details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Padding(
                                          padding: const EdgeInsets.only(left: 4,right: 4,top: 4),
                                          child: headerCard(StringsEn().otherDetails),
                                        ),
                                    SizedBox(height: 10.0),
                                    //Type of Death
                                    CustomDropDownWidget(
                                      text: "Type of Death",
                                      chooseValue: typeOfDeathChoose,
                                      myList: typeOfDeathList,
                                      onChanged: (newValue) => setState(() =>
                                          typeOfDeathChoose = newValue),
                                    ),
                                    SizedBox(
                                      height: AppDigits.size,
                                    ),

                                    //Place of Death
                                    MyCustomTextField()
                                        .textWithTextControllerTextField(
                                            TextInputType.text,
                                            StringsEn().placeOfDeath,
                                            _textPlaceOfDeathController,
                                            false),
                                    SizedBox(
                                      height: AppDigits.size,
                                    ),

                                    //Date of Death
                                    MyCustomTextField()
                                        .textWithTextControllerDateTextFieldDeathBenefit(
                                            context,
                                            StringsEn().dateOfDeath,
                                            _textDateOfDeathController,
                                            false),
                                    SizedBox(
                                      height: AppDigits.size,
                                    ),

                                    //Cause of Death
                                    MyCustomTextField()
                                        .textWithTextControllerTextField(
                                            TextInputType.text,
                                            StringsEn().causeOfDeath,
                                            _textCauseOfDeathController,
                                            false),
                                    SizedBox(
                                      height: AppDigits.size,
                                    ),

                                    //Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, bottom: 5.0, right: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Column(
                                          children: [
                                            //Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: MyCustomText()
                                                        .textWithPadding(
                                                            "Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?",
                                                            AppColor
                                                                .blackColor /*Colors.black*/)),
                                                MyCustomText()
                                                    .textWithoutPadding(
                                                        "*", Colors.red),
                                              ],
                                            ),
                                            //Radio Button [Yes/No]
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: CustomRadioButton(
                                                    text: "Yes",
                                                    value: 1,
                                                    groupValue: _groupValue,
                                                    onChanged: (newValue) {
                                                      setState(
                                                        () {
                                                          _groupValue =
                                                              newValue;
                                                          if (_groupValue ==
                                                              1) {
                                                            for (int i = 0;
                                                                i <
                                                                    nomineeDetailsList
                                                                        .length;
                                                                i++) {
                                                              if (nomineeDetailsList[
                                                                          i]
                                                                      .isSelectedAlive ==
                                                                  true) {
                                                                nomineeDetailsList[
                                                                            i]
                                                                        .isSelectedAlive =
                                                                    false;
                                                                displayLegalHeir =
                                                                    false;
                                                              } else if (nomineeDetailsList[
                                                                          i]
                                                                      .isSelectedAlive ==
                                                                  false) {
                                                                displayLegalHeir =
                                                                    false;
                                                              }
                                                            }
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: CustomRadioButton(
                                                    text: "No",
                                                    value: 2,
                                                    groupValue: _groupValue,
                                                    onChanged: (newValue) {
                                                      setState(
                                                        () {
                                                          _groupValue =
                                                              newValue;
                                                          if (_groupValue ==
                                                              2) {
                                                            for (int i = 0;
                                                                i <
                                                                    nomineeDetailsList
                                                                        .length;
                                                                i++) {
                                                              if (nomineeDetailsList[
                                                                          i]
                                                                      .isSelectedAlive ==
                                                                  true) {
                                                                displayLegalHeir =
                                                                    true;
                                                              } else {
                                                                displayLegalHeir =
                                                                    false;
                                                                _groupValue = 1;
                                                                warningAlertDialog();
                                                              }
                                                            }
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: AppDigits.size,
                                    ),

                                    //Which registered nominee is applying for the grant
                                    displayLegalHeir == false
                                        ? Column(
                                            children: [
                                              InkWell(
                                                onTap: () =>
                                                    selectNomineeAlertDialog(
                                                        context),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          bottom: 5.0,
                                                          right: 10.0),
                                                  child: Container(
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        border: Border.all(
                                                            color: Colors
                                                                .black12)),
                                                    child: Column(
                                                      children: [
                                                        //Which registered nominee is applying fot the grant ?
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: MyCustomText()
                                                                    .textWithPadding(
                                                                        "Which registered nominee is applying for the grant ?",
                                                                        AppColor
                                                                            .blackColor
                                                                        )),
                                                            MyCustomText()
                                                                .textWithoutPadding(
                                                                    "*",
                                                                    Colors.red),
                                                          ],
                                                        ),
                                                        selectNomineeText ==
                                                                "--- Select Nominee ---"
                                                            ? Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 15.0,
                                                                    top: 5.0,
                                                                    bottom: 5.0,
                                                                    right:
                                                                        10.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                          selectNomineeText,
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black54)),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black54,
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding: const EdgeInsets
                                                                        .only(
                                                                    left: 15.0,
                                                                    top: 5.0,
                                                                    bottom: 5.0,
                                                                    right:
                                                                        10.0),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Text(
                                                                          selectNomineeText,
                                                                          textAlign: TextAlign
                                                                              .left,
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight.w500,
                                                                              color: Colors.black)),
                                                                    ),
                                                                    Icon(
                                                                      Icons
                                                                          .keyboard_arrow_right_outlined,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //Save, Update- Button
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //Save- Button
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.0),
                                                    child: CustomButtonSave(
                                                      text: "SAVE",
                                                      buttonForegroundColor:
                                                          Colors.white,
                                                      buttonBackgroundColor:
                                                          AppColor
                                                              .primaryColor,
                                                      onPressed: () =>
                                                          saveOtherDetailsDeathBenefits(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0,
                                                    bottom: 5.0,
                                                    right: 10.0),
                                                child: Divider(
                                                  height: 0.1,
                                                  color: Colors.black12,
                                                  thickness: 3,
                                                ),
                                              ),

                                              MyCustomHeader().headerCard(
                                                  StringsEn().legalHeirDetails),

                                              //Relationship
                                              Row(
                                                children: [
                                                  textWithPaddingForProfile(
                                                      StringsEn().relationship,
                                                      AppColor
                                                          .blackColor ),
                                                  textWithoutPadding(
                                                      "*", Colors.red),
                                                ],
                                              ),
                                              relationListDropDown(cont, state),
                               
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir name
                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                      StringsEn().name,
                                                      _textLegalHeirNameController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir date of birth
                                              MyCustomTextField()
                                                  .textWithTextControllerDateTextFieldDeathBenefit(
                                                      context,
                                                    StringsEn().dateOfBirth,
                                                      _textLegalHeirDoBController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir aadhaar number
                                      
                                              MyCustomTextField()
                                                  .textWithAadharNumberControllerTextField(
                                                      TextInputType.number,
                                                      StringsEn().aadhar,
                                                      _textLegalHeirAadhaarNumberController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir mobile number
                                            
                                              MyCustomTextField()
                                                  .textWithMobileNumberControllerTextField(
                                                      TextInputType.number,
                                                      StringsEn().mobileNumber,
                                                      _textLegalHeirMobileNumberController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir address
                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                     StringsEn().address,
                                                      _textLegalHeirAddressController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir state
                                              Row(
                                                children: [
                                                  textWithPaddingForProfile(
                                                     StringsEn().state, Colors.black),
                                                  textWithoutPadding(
                                                      "*", Colors.red),
                                                ],
                                              ),
                                              stateListDropDown(cont, state),
                                       
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              Row(
                                                children: [
                                                  textWithPaddingForProfile(
                                                     StringsEn().district, Colors.black),
                                                  textWithoutPadding(
                                                      "*", Colors.red)
                                                ],
                                              ),

                                              districtDropDownForPresent(
                                                  cont, state),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Legal heir district
                              
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: CustomRadioButton(
                                                      text: "Urban",
                                                      value: 1,
                                                      groupValue:
                                                          _groupValuePresent,
                                                      onChanged: (newValue) =>
                                                          setState(() =>
                                                              _groupValuePresent =
                                                                  newValue),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: CustomRadioButton(
                                                      text: "Rural",
                                                      value: 2,
                                                      groupValue:
                                                          _groupValuePresent,
                                                      onChanged: (newValue) =>
                                                          setState(() =>
                                                              _groupValuePresent =
                                                                  newValue),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              _groupValuePresent == 1
                                                  ? Container(
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              textWithPaddingForProfile(
                                                                  StringsEn().uLB,
                                                                  AppColor
                                                                      .blackColor /* Colors.black*/),
                                                              textWithoutPadding(
                                                                  "*",
                                                                  Colors.red),
                                                            ],
                                                          ),
                                                          ulbPresentDropDown(
                                                              cont, state),
                                                          SizedBox(
                                                            height:
                                                                AppDigits.size,
                                                          ),
                                                          Row(
                                                            children: [
                                                              textWithPaddingForProfile(
                                                                  StringsEn().ward,
                                                                  Colors.black),
                                                              textWithoutPadding(
                                                                  "*",
                                                                  Colors.red),
                                                            ],
                                                          ),
                                                          wardDropDownPresent(
                                                              cont, state),

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
                                                            textWithoutPadding(
                                                                "*", Colors.red)
                                                          ],
                                                        ),
                                                        blockPresentDropDown(
                                                            cont, state),
                                                        SizedBox(
                                                          height:
                                                              AppDigits.size,
                                                        ),
                                                        Row(
                                                          children: [
                                                            textWithPaddingForProfile(
                                                                StringsEn().village,
                                                                Colors.black),
                                                            textWithoutPadding(
                                                                "*",
                                                                Colors.red),
                                                          ],
                                                        ),
                                                        villagePresentDropDown(
                                                            cont, state),
                                                        SizedBox(
                                                          height:
                                                              AppDigits.size,
                                                        ),
                                                        MyCustomTextField()
                                                            .textWithTextControllerTextField(
                                                                TextInputType
                                                                    .text,
                                                                StringsEn().gramPanchayat,
                                                                _textLegalHeirGramPanchayatController,
                                                                false),
                                                      ],
                                                    ),

                                              //Legal heir block
                                       

                                              //Legal heir gram panchayat

                                              //Legal heir village

                                              //Legal heir pincode
                                        
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              MyCustomTextField()
                                                  .textWithPinCodeControllerTextField(
                                                      TextInputType.number,
                                                      StringsEn().pincode,
                                                      _textLegalHeirPinCodeController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Bank Name
                                              Row(children: [
                                                textWithPaddingForProfile(
                                                  StringsEn().nameOfTheBank,
                                                  Colors.black,
                                                ),
                                                textWithoutPadding(
                                                    "*", Colors.red),
                                              ]),
                                              bankDropDown(cont, state),
                              

                                              //Name of Branch
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                      StringsEn().nameOfBranch,
                                                      _textBranchNameController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //IFSC
                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                      StringsEn().ifsc,
                                                      _textIfscController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Aadhaar linked bank account number
                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                      StringsEn().aadhaarLinkedBankAccountNumber,
                                                      _textAadhaarLinkedAccountNoController,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                      StringsEn().confirmBankAccountNumber,
                                                      _textConfirmAccountNo,
                                                      false),
                                              SizedBox(
                                                height: AppDigits.size,
                                              ),

                                              //Save, Update- Button
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  //Save- Button
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10.0),
                                                    child: CustomButtonSave(
                                                      text: "ADD DETAILS",
                                                      buttonForegroundColor:
                                                          Colors.white,
                                                      buttonBackgroundColor:
                                                          AppColor
                                                              .primaryColor,
                                                      onPressed: () =>
                                                          saveLegalHeirDetailsDeathBenefits(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                    SizedBox(height: 10.0),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                MyCustomContainer().getBottomLayout(
                  context,
                  SubscriptionDetailsDeathBenefitsForm(
                      initiate: widget.initiate),
                  SupportingDocumentsDeathBenefitsForm(
                      initiate: widget.initiate),
                  "4",
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  bankDropDown(BuildContext context, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 5),
        child: DropdownButton<String>(
            value: bankId,
            hint: Text(
              'Select Bank',
              style: TextStyle(fontSize: 12.0),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: bankList.map((item) {
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
                                  item['bankName'].toString(),
                                  style:
                                      TextStyle(fontSize: AppDigits.fontSize),
                                ))),
                      ],
                    )),
                value: item[
                        'bankId']
                    .toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                bankId = newValue;
              });
            }));
  }

  Future<void> getBankList() async {
    FilterVO bankDetailsVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    bankDetailsVo.status = "Y";
  
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(bankDetailsVo);

    var response = await Api.getAllActiveBankDetails(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        bankList = responseBody;
     
      });
    } else {}
  }

  Future<void> getVillageByBlockList() async {
    FilterVO filterVO = FilterVO();
    filterVO.placeId = dropdownValueForRegBlockPresent != null
        ? int.parse(dropdownValueForRegBlockPresent!)
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

  villagePresentDropDown(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        value: dropdownValueForPresentVillage,
        hint: Text(
          'Select Village',
          style: TextStyle(fontSize: 12.0),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: villageList.map((item) {
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
        onChanged: (String? newValue) {
          setState(() {
            dropdownValueForPresentVillage = newValue!;
          });
        },
      ),
    );
  }

  blockPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          value: dropdownValueForRegBlockPresent,
          hint: Text(
            'Select Block',
            style: TextStyle(fontSize: 12.0),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: blockListPresent.map((item) {
            return DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item['blockName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize),
                ),
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

  Future<void> getBlocksPresent() async {
    FilterVo filterVo = FilterVo();
    filterVo.districtId =
        dropdownValueForRegistrationDistrictPresent != null
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

      });
    } else {}
  }

  wardDropDownPresent(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        // Initial Value
        value: dropdownValueForWardPresent,
        hint: Text(
          'Select Ward',
          style: TextStyle(fontSize: 12.0),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: wardListPresent.map((item) {
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
            dropdownValueForWardPresent = newValue!;
          });
        },
      ),
    );
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

  ulbPresentDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        // Initial Value
        value: dropdownValueForUlbPresent,
        hint: Text(
          'Select Ulb',
          style: TextStyle(fontSize: 12.0),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: ulbListPresent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['ulbName'].toString(),
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
            dropdownValueForWardPresent = null;
            dropdownValueForUlbPresent = newValue!;
            getWardListPresent();
          });
        },
      ),
    );
  }

  stateListDropDown(BuildContext context, StateSetter setState) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        // Initial Value
        value: dropdownValueRegStatePermanent,
        hint: Text(
          'Select State',
          style: TextStyle(fontSize: 12.0),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: legalHeirStateList.map((item) {
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
           
            dropdownValueForUlbPresent = null;
            dropdownValueForWardPresent = null;

            dropdownValueForRegBlockPermanent = null;
   
            dropdownValueRegStatePermanent = newValue!;
            getDistrictListPresent();
          });
        },
      ),
    );
  }

  districtDropDownForPresent(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        // Initial Value
        value: dropdownValueForRegistrationDistrictPresent,
        hint: Text(
          'Select District',
          style: TextStyle(fontSize: 12.0),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: districtListPresent.map((item) {
          return DropdownMenuItem(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['districtName'].toString(),
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
            districtPresentId = newValue;

            dropdownValueForUlb = null;
            dropdownValueForWardPresent = null;
            dropdownValueForRegBlockPermanent
 = null;
            dropdownValueForRegistrationDistrictPresent = newValue!;
            /*  getBlocks1();*/
            getBlocksPresent();
            getUlbSBlocksPresent();
          });
        },
      ),
    );
  }

  Future<void> getUlbSBlocksPresent() async {
    FilterVO filterVO = FilterVO();
    filterVO.districtId =
        districtPresentId != null ? int.parse(districtPresentId!) : 0;
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

  Future<void> getStateList() async {
    print("Application Id: " + widget.initiate.id.toString());
    CommonFilterVo filterVo = CommonFilterVo();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 0;
    //Get Token from SharedPreference
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
        legalHeirStateList = responseBody;
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

  Future<void> getDistrictListPresent() async {
    FilterVo filterVo = FilterVo();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 21;
   /* filterVo.villageId = 0;*/
    filterVo.placeId = 0;
    /* filterVo.stateId = stateId != null ? int.parse(stateId!) : null;*/

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

  Future<void> getDistrictList() async {
    CommonFilterVo filterVo = CommonFilterVo();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 0;
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
        legalHeirDistrictList = responseBody;
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

  Future<void> getBlockList() async {
    CommonFilterVo filterVo = CommonFilterVo();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 0;
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
        legalHeirBlockList = responseBody;
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

  Future<void> getAllActiveBankDetails() async {
    CommonFilterVo commonFilterVo = CommonFilterVo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    commonFilterVo.status = "Y";
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response = await Api.getAllActiveBankDetails(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        legalHeirBankNameList = responseBody;
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

  Future<void> getWorkerNomineeDetails() async {
    RegistrationFilterVo registrationFilterVo = RegistrationFilterVo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    int? workerRegId = pref.getInt('workerId');
    registrationFilterVo.workerRegId = workerRegId;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registrationFilterVo);
    var response = await Api.getWorkerNomineeDetails(encodedData, headers);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      nomineeDetailsList = (list as List)
          .map((model) => NomineeDetailsVO.fromJson(model))
          .toList();
      setState(() {
        for (int i = 0; i < nomineeDetailsList.length; i++) {
          //_isSelected.add(false);
          nomineeDetailsList[i].isSelectedAlive = false;
        }
        loading = false;
      });
    } else {}
  }

  Future<void> findGeneralDetailsByWorkerId() async {
    CommonFilterVo commonFilterVo = CommonFilterVo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? encryptedWorkerId = pref.getString("encryptedWorkerId");
    commonFilterVo.status = encryptedWorkerId;
    //commonFilterVo.status = '6cjMSb4fOJI=';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response = await Api.findGeneralDetailsByWorkerId(encodedData, headers);
    if (response.statusCode == 200) {
      generalDetails =
          ProfileGeneralDetailsVo.fromJson(convert.jsonDecode(response.body));
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

  Future<void> findAddressDetailsByWorkerId() async {
    CommonFilterVo commonFilterVo = CommonFilterVo();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    String? encryptedWorkerId = pref.getString("encryptedWorkerId");
    commonFilterVo.status = encryptedWorkerId;
    //commonFilterVo.status = '6cjMSb4fOJI=';
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response = await Api.findAddressDetailsByWorkerId(encodedData, headers);
    //Checking condition whether response is null or not
    if (response.statusCode == 200) {
      addressDetails =
          ProfileAddressDetailsVo.fromJson(convert.jsonDecode(response.body));
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

  selectNomineeAlertDialog(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => new AlertDialog(
        title: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Select Nominee",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                IconButton(
                  icon: new Icon(Icons.clear),
                  highlightColor: Colors.red,
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                ),
              ],
            ),
            Container(
              width: double.maxFinite,
              height: 150,
              child: ListView.builder(
                itemCount: nomineeDetailsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text((index + 1).toString() + ". ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.primaryColor)),
                              Text(
                                  nomineeDetailsList[index].name!.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black)),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: AppColor.primaryColor,
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        selectNomineeText = nomineeDetailsList[index].name!;
                        selectNomineeId = nomineeDetailsList[index].id!;

                        objNomineeDetailsVo.id = nomineeDetailsList[index].id;
                        objNomineeDetailsVo.aadhaarNumber =
                            nomineeDetailsList[index].aadhaarNumber;
                        objNomineeDetailsVo.address =
                            nomineeDetailsList[index].address;
                        objNomineeDetailsVo.age = nomineeDetailsList[index].age;
                        objNomineeDetailsVo.alive =
                            nomineeDetailsList[index].alive;
                        objNomineeDetailsVo.deleteStatus =
                            nomineeDetailsList[index].deleteStatus;
                        objNomineeDetailsVo.dob = nomineeDetailsList[index].dob;
                        objNomineeDetailsVo.dobToString =
                            nomineeDetailsList[index].dobToString;
                        objNomineeDetailsVo.enteredOn =
                            nomineeDetailsList[index].enteredOn;
                        objNomineeDetailsVo.name =
                            nomineeDetailsList[index].name;
                        objNomineeDetailsVo.nomAccNo =
                            nomineeDetailsList[index].nomAccNo;
                        objNomineeDetailsVo.nomBankName =
                            nomineeDetailsList[index].nomBankName;
                        objNomineeDetailsVo.nomBranchName =
                            nomineeDetailsList[index].nomBranchName;
                        objNomineeDetailsVo.nomConAccNO =
                            nomineeDetailsList[index].nomConAccNO;
                        objNomineeDetailsVo.nomIfscCode =
                            nomineeDetailsList[index].nomIfscCode;
                        objNomineeDetailsVo.registration = RegistrationVO();
                        nomineeDetailsList[index].registration =
                            RegistrationVO();
                        objNomineeDetailsVo.registration =
                            nomineeDetailsList[index].registration;
                        objNomineeDetailsVo.relationship = RelationSetupVO();
                        nomineeDetailsList[index].relationship =
                            RelationSetupVO();
                        objNomineeDetailsVo.relationship =
                            nomineeDetailsList[index].relationship;
                        objNomineeDetailsVo.shareAmount =
                            nomineeDetailsList[index].shareAmount;
                        //print(jsonDecode(jsonEncode(objNomineeDetailsVo)));
                        Navigator.pop(context, true);
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> warningAlertDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new AlertDialog(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Text(
                  "Nominee are alive...",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              content: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Okay',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ));
  }

  relationListDropDown(BuildContext context, StateSetter setter) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            value: relationDropdownValue,
            hint: Text(
              'Relationship',
              style: TextStyle(color: Colors.black),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: relationList.map((item) {
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
                                  item['relationShip'].toString(),
                                  style:
                                      TextStyle(fontSize: AppDigits.fontSize),
                                ))),
                      ],
                    )),
                value: item['id'].toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
    
                relationDropdownValue = newValue;
              });
            }));
  }

  Future<void> getAllActiveRelationSetup() async {
    FilterVO filterVO = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    filterVO.status = "Y";
    filterVO.type = "N";
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getAllActiveRelationSetup(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        relationList = responseBody;
        loading = false;
      });
    }
  }

  saveOtherDetailsDeathBenefits() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    int? workerId = preferences.getInt('workerId');
    String? encryptedWorkerId = preferences.getString("encryptedWorkerId");
    DeathBenefitVO deathBenefitVO = DeathBenefitVO();
    if (deathBenefitVO.id != null) {
      deathBenefitVO.id = null;
    }
    deathBenefitVO.applicationDetails = ApplicationDetailVo();
    deathBenefitVO.applicationDetails!.id = widget.initiate.id;
    deathBenefitVO.applicationDetails!.status = encryptedWorkerId;
    deathBenefitVO.worker = RegistrationVo();
    deathBenefitVO.worker!.id = workerId;
    //parse construction worker details for saving DeathBenefits.
    deathBenefitVO.workerName = generalDetails.workerFirstName.toString() +
        " " +
        generalDetails.workerLastName.toString();
    deathBenefitVO.gender = generalDetails.gender.toString();
    deathBenefitVO.dobToString = generalDetails.dob.toString();
    deathBenefitVO.fathersName = generalDetails.fathersName.toString();
    deathBenefitVO.maritalStatus = generalDetails.maritalStatus.toString();
    //parse registration details worker details for saving DeathBenefits.
    deathBenefitVO.registrationDate = filterVO.regDate.toString();
    //parse address details for saving DeathBenefits.
    //permanent address
    deathBenefitVO.permanentAddress =
        addressDetails.permanentAddress.toString();
    if (addressDetails.permanentState != null) {
      deathBenefitVO.permanentState = StateSetup();
      deathBenefitVO.permanentState!.id = addressDetails.permanentState!.id;
    }
    if (addressDetails.permanentDistrict != null) {
      deathBenefitVO.permanentDistrict = DistrictSetupVo();
      deathBenefitVO.permanentDistrict!.id =
          addressDetails.permanentDistrict!.id;
    }
    if (addressDetails.permanentBlock != null) {
      deathBenefitVO.permanentBlock = BlockSetUpVo();
      deathBenefitVO.permanentBlock!.id = addressDetails.permanentBlock!.id;
    }
    deathBenefitVO.permanentGramaPanchayat =
        addressDetails.permanentGramaPanchayat;
    if (addressDetails.permanentVillageSetup != null) {
      deathBenefitVO.permanentVillage =
          addressDetails.permanentVillageSetup!.name.toString();
    }
    //present address
    deathBenefitVO.presentAddress = addressDetails.presentAddress;
    if (addressDetails.presentDistrict != null) {
      deathBenefitVO.presentDistrict = DistrictSetupVo();
      deathBenefitVO.presentDistrict!.id = addressDetails.presentDistrict!.id;
    }
    if (addressDetails.presentBlock != null) {
      deathBenefitVO.presentBlock = BlockSetUpVo();
      deathBenefitVO.presentBlock!.id = addressDetails.presentBlock!.id;
    }
    deathBenefitVO.presentGramaPanchayat =
        addressDetails.presentGramaPanchayat;
    if (addressDetails.presentVillageSetup != null) {
      deathBenefitVO.presentVillage =
          addressDetails.presentVillageSetup!.name.toString();
    }
    //other details
    deathBenefitVO.natureOfDeath = typeOfDeathChoose!;
    deathBenefitVO.causeOfDeath = _textCauseOfDeathController.text;
    deathBenefitVO.placeOfDeath = _textPlaceOfDeathController.text;
    deathBenefitVO.dateOfDeath = _textDateOfDeathController.text;
    deathBenefitVO.whetherNomineeOfWorker = _groupValue == 1 ? "Y" : " N";
    //deathBenefitVO details
    deathBenefitVO.nominee = ProfileNomineeDetailsVO();
    deathBenefitVO.nominee!.id = objNomineeDetailsVo.id;

    String encodedData = convert.jsonEncode(deathBenefitVO);
    //print(jsonEncode(DeathBenefitVO));

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var res = await Api.saveDeathBenefit(encodedData, headers);

    if (res.statusCode == 200) {

      print((res.statusCode).toString() + " " + (res.body).toString());
      Fluttertoast.showToast(
        msg: "Saved Successfully  ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }  else {
      Fluttertoast.showToast(
        msg: "Failed To Submit Death Benefit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );

      print("Error");
      if (res.statusCode == 401) {
        MyCustomText().alertDialogBox1(context);
      } else if (res.statusCode == 404) {
        MyCustomText().alertDialogBox2(context);
      } else if (res.statusCode == 500) {
        MyCustomText().alertDialogBox(context);
      }
      throw Exception('Failed to load jobs from API');
    }
  }

  saveLegalHeirDetailsDeathBenefits() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    LegalHeirDeathBenefitVO legalHeirDeathBenefitVO =
        LegalHeirDeathBenefitVO();

    legalHeirDeathBenefitVO.lid = widget.initiate.id;
    legalHeirDeathBenefitVO.applicationDetails = ApplicationDetailVo();
    legalHeirDeathBenefitVO.applicationDetails!.id = widget.initiate.id;

    legalHeirDeathBenefitVO.legaHeirRelationShip = RelationSetupVO();
    legalHeirDeathBenefitVO.legaHeirRelationShip!.id =
        int.parse(relationDropdownValue!);
    legalHeirDeathBenefitVO.legaHeirName =
        _textLegalHeirNameController.text;
    legalHeirDeathBenefitVO.dobToStr = _textLegalHeirDoBController.text;
    legalHeirDeathBenefitVO.legaHeirAadhaarNumber =
        _textLegalHeirAadhaarNumberController.text;
    legalHeirDeathBenefitVO.legaHeirMobileNumber =
        _textLegalHeirMobileNumberController.text;
    legalHeirDeathBenefitVO.legaHeirAddress =
        _textLegalHeirAddressController.text;

    if (_groupValuePresent == 1) {
      legalHeirDeathBenefitVO.legaHeirRuralOrUrban = "U";
    } else if (_groupValuePresent == 2) {
      legalHeirDeathBenefitVO.legaHeirRuralOrUrban = "R";
    }

    legalHeirDeathBenefitVO.legaHeirState = new StateSetup();
    if (addressDetails.permanentState != null) {
      legalHeirDeathBenefitVO.legaHeirState!.id =
          addressDetails.permanentState!.id;
    }
    legalHeirDeathBenefitVO.legaHeirDistrict = new DistrictSetupVo();
    if (addressDetails.permanentDistrict != null) {
      legalHeirDeathBenefitVO.legaHeirDistrict!.id =
          addressDetails.permanentDistrict!.id;
    }

    legalHeirDeathBenefitVO.legaHeirVillageSetup = VillageSetupVO();
    if (addressDetails.permanentVillageSetup != null) {
      legalHeirDeathBenefitVO.legaHeirVillageSetup!.id =
          addressDetails.permanentVillageSetup!.id;
    }
    legalHeirDeathBenefitVO.legaHeirBlock = BlockSetUpVo();
    if (addressDetails.permanentBlock != null) {
      legalHeirDeathBenefitVO.legaHeirBlock!.id =
          addressDetails.permanentBlock!.id;
    }
    legalHeirDeathBenefitVO.legaHeirUlbSetup = UlbSetupVO();
    if (addressDetails.permanentUlbSetup != null) {
      legalHeirDeathBenefitVO.legaHeirUlbSetup!.id =
          addressDetails.permanentUlbSetup!.id;
    }
    legalHeirDeathBenefitVO.legaHeirWardSetup = WardSetupVO();
    if (addressDetails.permanentWardSetup != null) {
      legalHeirDeathBenefitVO.legaHeirWardSetup!.id =
          addressDetails.permanentWardSetup!.id;
    }

    legalHeirDeathBenefitVO.legalBankName = BankDetailsVo();
    if (bankId != null) {
      legalHeirDeathBenefitVO.legalBankName!.bankId = int.parse(bankId!);
    }
    legalHeirDeathBenefitVO.legaHeirGramaPanchayat =
        _textLegalHeirGramPanchayatController.text;

    legalHeirDeathBenefitVO.legaHeirPostOffice =
        _textLegalHeirPinCodeController.text;


    legalHeirDeathBenefitVO.legaHeirBranchName =
        _textBranchNameController.text;
    legalHeirDeathBenefitVO.legaHeirIfscCode = _textIfscController.text;
    legalHeirDeathBenefitVO.legaHeirAccNo =
        _textAadhaarLinkedAccountNoController.text;
    legalHeirDeathBenefitVO.legaHeirNomConAccNO =
        _textConfirmAccountNo.text;

    String encodedData = convert.jsonEncode(legalHeirDeathBenefitVO);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var res = await Api.saveLegalheirDetails(encodedData, headers);
    if (res.body != null) {
      if (res.statusCode == 200) {
        saveLegalHeirDetailsDeathBenefit =
            LegalHeirDeathBenefitVO.fromJson(convert.jsonDecode(res.body));
        print(res.statusCode.toString());
        Fluttertoast.showToast(
          msg: "Saved Successfully  ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Failed To Submit Death Benefit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
      if (res.statusCode == 401) {
        MyCustomText().alertDialogBox1(context);
      } else if (res.statusCode == 404) {
        MyCustomText().alertDialogBox2(context);
      } else if (res.statusCode == 500) {
        MyCustomText().alertDialogBox(context);
      }
      throw Exception('Failed to load jobs from API');
    }
  }
}
