///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';

import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/custom_widgets/family_member_details_list_widget.dart';
import 'package:obocwwb/custom_widgets/nominee_member_list.dart';
import 'package:obocwwb/model/bank_details_vo.dart';
import 'package:obocwwb/model/family_member_details_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/funeral_expenses/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/model_class/relation_setup_vo.dart';
import 'package:obocwwb/model/nominee.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/addree_details_old.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/details_of_the_establishment.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import '../../model/application_detail_vo.dart';
import '../applicant_application/test_home.dart';

class FamilyAndNomineeDetails extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();

  final int? otrID;
  final int? workId;

  final RegistrationVO? profileAddressDetailsVo;
  FamilyAndNomineeDetails(
      {Key? key, this.otrID, this.workId, this.profileAddressDetailsVo})
      : super(key: key);

  @override
  State<FamilyAndNomineeDetails> createState() =>
      _FamilyAndNomineeDetailsState();
}

class _FamilyAndNomineeDetailsState extends State<FamilyAndNomineeDetails> {
  double sharePrice = 0.0;
  int _groupValue = 1;
  int nomineeValue = 1;
  bool loading = true;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController textNameController = TextEditingController();
  TextEditingController textAadhaarNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController textNomineeAadhaarController = TextEditingController();
  TextEditingController nomineeDateOfBirthController = TextEditingController();
  TextEditingController textNomineeAddressController = TextEditingController();
  TextEditingController textShareInPercentageController =
      TextEditingController();
  TextEditingController textBranchNameController = TextEditingController();
  TextEditingController textIfscController = TextEditingController();
  TextEditingController aadhaarLinkedBankAccountNumberController =
      TextEditingController();
  TextEditingController confirmBankAccountNumberController =
      TextEditingController();
  String? relationDropdownValue;
  String? nomineeDropDownValue;
  String? dropdownValueBankDetails;
  String? dropdownValueNameDetails;
  String? nameId;
  String? bankId;
  String? id;

  List relationList = [];
  List bankList = [];
  List nomineeList = [];
  List familyMemberList = [];
  bool? onCheck = false;

  List<FamilyMemberDetailsVo> familyMemberDetailsList = [];
  FamilyMemberDetailsVo familyMemberDetails = FamilyMemberDetailsVo();
  FamilyMemberDetailsVo familyMemberItemDetails = FamilyMemberDetailsVo();
  NomineeDetailsVO nomineeDetails = NomineeDetailsVO();
  List<NomineeDetailsVO> nomineeDetailsList = [];
  @override
  void initState() {
    // TODO: implement initState

    getAllActiveRelationSetup();
    getFamilyMemberDetails();
    getWorkerNomineeDetails();
    getBankList();

    getWorkerFamilyNomineeDetails(widget.workId);
    getWorkerNomineeDetailsList(widget.workId);
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
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Card(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            headerCard(StringsEn().familyAndNomineeDetails),
                            SizedBox(height: AppDigits.size),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, bottom: 10, top: 10),
                                  child: Text(
                                    StringsEn().havingFamily,
                                    style: TextStyle(
                                        fontSize: AppDigits.titleSize,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                textWithoutPadding("*", Colors.red)
                              ],
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: CustomRadioButton(
                                          text: "Yes",
                                          value: 1,
                                          groupValue: _groupValue,
                                          onChanged: (newValue) => setState(
                                              () => _groupValue = newValue),
                                        ),
                                      ),
                                      Expanded(
                                        child: CustomRadioButton(
                                          text: "No",
                                          value: 2,
                                          groupValue: _groupValue,
                                          onChanged: (newValue) => setState(
                                              () => _groupValue = newValue),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                            _groupValue == 1
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: AppDigits.size),
                                      MyCustomText().customTextWithPadding(
                                          StringsEn().familyDetails,
                                          Colors.black),
                                      SizedBox(
                                        height: AppDigits.size,
                                      ),
                                      //Name
                                      MyCustomTextField()
                                          .textWithTextControllerTextFieldOnlyText(
                                              TextInputType.text,
                                              StringsEn().name,
                                              textNameController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Aadhaar number
                                      MyCustomTextField()
                                          . /*textWithTextControllerAadhaarWithoutImpMark*/ textWithTextControllerAadhaarImpMark(
                                              TextInputType.number,
                                              StringsEn().aadhaarNumber,
                                              textAadhaarNumberController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      // Date of Birth
                                      MyCustomTextField()
                                          .textWithTextControllerDateTextFieldWithoutAsterisksNoValidation(
                                              context,
                                              StringsEn().dateOfBirth,
                                              dateOfBirthController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Relationship
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child:
                                                relationListDropDown(context),
                                          )),
                                      SizedBox(
                                        height: AppDigits.size,
                                      ),
                                      //Declaration
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child: CheckboxListTile(
                                              title: Text(
                                                "I have taken the consent of my family members/nominees for sharing their Aadhaar for the purpose of establishing their identity for various services under OB&OCWW Board. Aadhaar holder is aware that information provided by him/her will be used for authenticating identity through Aadhaar Authentication system for the purpose stated above and no other purpose.",
                                                style: TextStyle(
                                                    fontSize:
                                                        AppDigits.fontSize),
                                              ),
                                              value: onCheck,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  onCheck = value;
                                                });
                                              },
                                              controlAffinity:
                                                  ListTileControlAffinity
                                                      .leading,
                                            ),
                                          )),
                                      SizedBox(
                                        height: AppDigits.size,
                                      ),
                                      //Add member button
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .addingFamilyMembers,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                             /*   final snackBar = SnackBar(
                                                    content: Text(StringsEn()
                                                        .addingFamilyMembers));
                                                _scaffoldKey.currentState!
                                                    .showSnackBar(snackBar);*/
                                              }
                                              if (onCheck == true) {
                                                saveWorkerFamilyMemberDetails();
                                              } else {
                                                Fluttertoast.showToast(
                                                  msg: StringsEn()
                                                      .pleaseClickTheCheckBox,
                                                  toastLength:
                                                      Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 1,
                                                );
                                              }
                                              // getFamilyMemberDetails();
                                            },
                                            child: MyCustomButton()
                                                .buttonTextWidget(
                                                    StringsEn().addMember),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.primaryColor)),
                                      ),
                                      FamilyMemberDetailsListWidget(
                                        familyMemberDetailsList:
                                            familyMemberDetailsList,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      MyCustomText().customTextWithPadding(
                                          StringsEn().nomineeDetails,
                                          Colors.black),

                                      //Nominee list
                                      Row(
                                        children: [
                                          textWithPaddingForProfile(
                                              StringsEn().name, Colors.black)
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0, right: 10.0),
                                        child: StatefulBuilder(builder:
                                            (BuildContext cont,
                                                StateSetter state) {
                                          return Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                  border: Border.all(
                                                      color: Colors.black12)),
                                              child: nomineeListDropDown(
                                                  cont, state));
                                        }),
                                      ),
                                      SizedBox(height: AppDigits.size),
                                      //Aadhaar number
                                      MyCustomTextField()
                                          . /*textWithTextControllerAadhaarWithoutImpMark*/ textWithTextControllerAadhaarImpMark(
                                              TextInputType.number,
                                              StringsEn().aadhaarNumber,
                                              textNomineeAadhaarController,
                                              true),
                                      SizedBox(height: AppDigits.size),
                                      //Nominee Date of birth
                                      MyCustomTextField()
                                          . /*textWithTextControllerDateTextFieldWithoutAsterisks*/ textWithTextControllerDateTextFieldWithoutAsterisksNoValidation(
                                              context,
                                              StringsEn().dateOfBirth,
                                              nomineeDateOfBirthController,
                                              true),
                                      SizedBox(height: AppDigits.size),
                                      //Address
                                      MyCustomTextField()
                                          .textWithTextControllerTextFieldNoImp(
                                              TextInputType.text,
                                              StringsEn().address,
                                              textNomineeAddressController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Relationship
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child:
                                                relationListDropDown(context),
                                          )),
                                      SizedBox(height: AppDigits.size),
                                      //Share in percentage
                                      MyCustomTextField()
                                          .textWithTextControllerShareInPercentageWithoutImpMark(
                                              TextInputType.phone,
                                              StringsEn().shareInPercentage,
                                              textShareInPercentageController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Bank list
                                      Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                border: Border.all(
                                                    color: Colors.black12)),
                                            child:
                                                bankListDropDown(cont, state),
                                          )),
                                      SizedBox(height: AppDigits.size),
                                      //Name of branch
                                      MyCustomTextField()
                                          .textWithTextControllerTextFieldNoImp(
                                              TextInputType.text,
                                              StringsEn().nameOfBranch,
                                              textBranchNameController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //ifsc
                                      MyCustomTextField()
                                          .textWithTextControllerTextFieldWithoutImpMarkIfsc(
                                              TextInputType.text,
                                              StringsEn().ifsc,
                                              textIfscController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Aadhaar linked bank account number
                                      MyCustomTextField()
                                          .textWithTextFieldForAccountMobileNumber(
                                              TextInputType.number,
                                              StringsEn()
                                                  .aadhaarLinkedBankAccountNumber,
                                              aadhaarLinkedBankAccountNumberController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Confirm bank account number
                                      MyCustomTextField()
                                          .textWithTextFieldForAccountMobileNumber(
                                              TextInputType.number,
                                              StringsEn()
                                                  .confirmBankAccountNumber,
                                              confirmBankAccountNumberController,
                                              false),
                                      SizedBox(height: AppDigits.size),
                                      //Add details
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              setState(() {});
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .addingDetails,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              /*  final snackBar = SnackBar(
                                                    content: Text(StringsEn()
                                                        .addingDetails));
                                                _scaffoldKey.currentState!
                                                    .showSnackBar(snackBar);*/
                                              }

                                              if (textNomineeAddressController.text != "" &&
                                                  aadhaarLinkedBankAccountNumberController
                                                          .text ==
                                                      confirmBankAccountNumberController
                                                          .text &&
                                                  textBranchNameController
                                                          .text !=
                                                      "" &&
                                                  sharePrice < 100.0 &&
                                                  textNomineeAddressController
                                                          .text !=
                                                      "" &&
                                                  textIfscController.text ==
                                                      RegExp("^[A-Z]{4}[0][0-9]{6}\$")
                                                          .hasMatch(
                                                              textIfscController
                                                                  .text)) {
                                                saveWorkerNominee();
                                              } else if (aadhaarLinkedBankAccountNumberController
                                                      .text !=
                                                  confirmBankAccountNumberController
                                                      .text) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .accountNumberMustBeSame,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                               /* _scaffoldKey.currentState!
                                                    .showSnackBar(SnackBar(
                                                        content: Text(StringsEn()
                                                            .accountNumberMustBeSame)));*/
                                              } else if (textIfscController
                                                      .text.isEmpty ||
                                                  !RegExp("^[A-Z]{4}[0][0-9]{6}\$")
                                                      .hasMatch(
                                                          textIfscController
                                                              .text)) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .enterValidIFSCCode,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                               /* _scaffoldKey.currentState!
                                                    .showSnackBar(SnackBar(
                                                        content: Text(StringsEn()
                                                            .enterValidIFSCCode)));*/
                                              } else if (textBranchNameController
                                                      .text ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .enterValidBranchName,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                               /* _scaffoldKey.currentState!
                                                    .showSnackBar(SnackBar(
                                                        content: Text(StringsEn()
                                                            .enterValidBranchName)));*/
                                              } else if (textNomineeAddressController
                                                      .text ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .enterValidAddress,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                               /* _scaffoldKey.currentState!
                                                    .showSnackBar(SnackBar(
                                                        content: Text(StringsEn()
                                                            .enterValidAddress)));*/
                                              } else if (textShareInPercentageController
                                                      .text ==
                                                  "") {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    StringsEn()
                                                        .enterValidShare,
                                                    toastLength: Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.blueGrey,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                /*_scaffoldKey.currentState!
                                                    .showSnackBar(SnackBar(
                                                        content: Text(StringsEn()
                                                            .enterValidShare)));*/
                                              } else {
                                                saveWorkerNominee();
                                              }
                                              /*else{
                                                _scaffoldKey.currentState!.showSnackBar(
                                                    SnackBar(
                                                        content: Text(
                                                            'Please select percentage of share given to nominee do not exceed 100%')));
                                              }*/
                                            },
                                            child: MyCustomButton()
                                                .buttonTextWidget(
                                                    StringsEn().addDetails),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColor.primaryColor)),
                                      ),
                                    ],
                                  )
                                : Container(),
                            //Nominee details
                            _groupValue == 1
                                ? NomineeMemberDetailsListWidget(
                                    nomineeDetailsList: nomineeDetailsList,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  )),
                  MyCustomText().textInformation(),
                  MyCustomContainer().getBottomLayout(
                    context,
                    AddressDetailsFormOld(
                        regResponse: widget.profileAddressDetailsVo),
                    DetailsOfTheEstablishment(
                        profileAddressDetailsVo:
                            widget.profileAddressDetailsVo),
                    "4",
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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

  Future<void> getWorkerNomineeDetails() async {
    FilterVO filterVO = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    filterVO.workerRegId = pref.getInt('workerId');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getWorkerNomineeDetails(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        nomineeList = responseBody;
        loading = false;
      });
    }
  }

  Future<void> getFamilyMemberDetails() async {
    FilterVO familyDetailList = FilterVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    familyDetailList.workerRegId = preferences.getInt('workerId');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(familyDetailList);

    var response = await Api.getWorkerFamilyMemberDetails(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        familyMemberList = responseBody;
        loading = false;
      });
    }
  }

  familyListDropDown(BuildContext context, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: dropdownValueNameDetails,
            hint: Text(
              StringsEn().selectName,
              style: TextStyle(fontSize: 12.0),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: familyMemberList.map((item) {
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
                                child: Text(item['name'].toString()))),
                      ],
                    )),
                value: item['id'].toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                nameId = newValue;
                dropdownValueNameDetails = newValue!;
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
        loading = false;
      });
    } else {}
  }

  bankListDropDown(BuildContext context, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: dropdownValueBankDetails,
            hint: Text(
              StringsEn().selectBank,
              style: TextStyle(fontSize: AppDigits.fontSize),
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
                                padding: EdgeInsets.all(5),
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(item['bankName'].toString(),
                                    style: TextStyle(
                                        fontSize: AppDigits.fontSize)))),
                      ],
                    )),
                value: item['bankId'].toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                bankId = newValue;
                dropdownValueBankDetails = newValue!;
              });
            }));
  }

  relationListDropDown(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: relationDropdownValue,
            hint: Text(
              StringsEn().relationship,
              style: TextStyle(fontSize: AppDigits.fontSize),
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
                relationDropdownValue = newValue!;
              });
            }));
  }

  nomineeListDropDown(BuildContext context, StateSetter state) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: nomineeDropDownValue,
            hint: Text(
              StringsEn().selectNominee,
              style:
                  TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: familyMemberList.map((item) {
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
                                  item['name'].toString(),
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
                nameId = newValue;
                nomineeDropDownValue = newValue!;
                fetchNomineeDetails(nomineeDropDownValue!);
                loading = true;
              });
            }));
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
                fontSize: 14.0,
                fontWeight: FontWeight.bold)),
      ),
    );
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

  void saveWorkerFamilyMemberDetails() async {
    FamilyMemberDetailsVo familyMemberDetailsVo = FamilyMemberDetailsVo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    familyMemberDetailsVo.name = textNameController.text;
    familyMemberDetailsVo.aadhaarNumber = textAadhaarNumberController.text;
    familyMemberDetailsVo.dobToString = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(dateOfBirthController.text).toUtc());
    familyMemberDetailsVo.relationship = RelationSetupVO();
    familyMemberDetailsVo.relationship!.id = relationDropdownValue != null
        ? int.parse(relationDropdownValue!)
        : null;
    familyMemberDetailsVo.registration = RegistrationVO();
    familyMemberDetailsVo.registration!.id = prefs.getInt('workerId');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodeData = convert.jsonEncode(familyMemberDetailsVo);
    var response = await Api.saveWorkerFamilyMemberDetails(encodeData, headers);
    if (response.statusCode == 200) {
      familyMemberDetails =
          FamilyMemberDetailsVo.fromJson(convert.jsonDecode(response.body));
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FamilyAndNomineeDetails()));
      getWorkerFamilyNomineeDetails(prefs.getInt('workerId'));
      setState(() {
        loading = false;
      });
    }
  }

  void saveWorkerNominee() async {
    NomineeDetailsVO nomineeDetailsVo = NomineeDetailsVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    nomineeDetailsVo.id = int.parse(nomineeDropDownValue!);
    nomineeDetailsVo.name = familyMemberItemDetails.name;
    nomineeDetailsVo.aadhaarNumber = textNomineeAadhaarController.text;
    nomineeDetailsVo.dob = DateFormat('yyyy-MM-dd')
        .format(DateTime.parse(nomineeDateOfBirthController.text).toUtc());
    nomineeDetailsVo.address = textNomineeAddressController.text;
    nomineeDetailsVo.shareAmount =
        double.tryParse(textShareInPercentageController.text);
    nomineeDetailsVo.nomBranchName = textBranchNameController.text;
    nomineeDetailsVo.nomIfscCode = textIfscController.text;
    nomineeDetailsVo.nomAccNo = aadhaarLinkedBankAccountNumberController.text;
    nomineeDetailsVo.nomConAccNO = confirmBankAccountNumberController.text;
    nomineeDetailsVo.relationship = RelationSetupVO();
    nomineeDetailsVo.relationship!.id = relationDropdownValue != null
        ? int.parse(relationDropdownValue!)
        : null;
    nomineeDetailsVo.nomBankName = BankDetailsVo();
    nomineeDetailsVo.nomBankName!.bankId =
        bankId != null ? int.parse(bankId!) : null;
    nomineeDetailsVo.registration = RegistrationVO();
    nomineeDetailsVo.registration!.id = preferences.getInt('workerId');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodeData = convert.jsonEncode(nomineeDetailsVo);
    var response = await Api.saveWorkerNominee(encodeData, headers);
    if (response.statusCode == 200) {
      nomineeDetails =
          NomineeDetailsVO.fromJson(convert.jsonDecode(response.body));
      Fluttertoast.showToast(
          msg:
          "Saved!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
     /* _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text('Saved!')));*/
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => FamilyAndNomineeDetails()));
      setState(() {
        loading = false;
        getWorkerNomineeDetailsList(widget.workId);
      });
    }
  }

  void getWorkerFamilyNomineeDetails(int? workId) async {
    FilterVO registrationFilterVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    registrationFilterVo.workerRegId = pref.getInt('workerId');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registrationFilterVo);
    var response = await Api.getWorkerFamilyMemberDetails(encodedData, headers);
    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      familyMemberDetailsList = (list as List)
          .map((model) => FamilyMemberDetailsVo.fromJson(model))
          .toList();
      setState(() {
        for (int i = 0; i < familyMemberDetailsList.length; i++) {}
        loading = false;
        print(familyMemberDetailsList.length.toString());
      });
    } else {}
  }

  void getWorkerNomineeDetailsList(int? workId) async {
    FilterVO registrationFilterVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    registrationFilterVo.workerRegId = pref.getInt('workerId');

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
          sharePrice += nomineeDetailsList[i].shareAmount!;
          print(sharePrice);
        }
        loading = false;
        print(nomineeDetailsList.length.toString());
      });
    } else {}
  }

  void fetchNomineeDetails(String memberId) async {
    CommonFilterVo commonFilterVo = CommonFilterVo();
    commonFilterVo.workerFamilyMemberId = int.parse(memberId);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response = await Api.fetchFamilyMemberById(headers, encodedData);
    if (response.statusCode == 200) {
      familyMemberItemDetails =
          FamilyMemberDetailsVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        textNomineeAadhaarController.text =
            familyMemberItemDetails.aadhaarNumber!;
        DateFormat format = new DateFormat("MMM dd, yyyy");

        var formattedDate = format.parse(familyMemberItemDetails.dob!).toUtc();
        DateFormat format1 = new DateFormat("yyyy-MM-dd");
        nomineeDateOfBirthController.text = format1.format(formattedDate);
        /*   nomineeDateOfBirthController.text =  DateFormat('yyyy-MM-dd').format(DateTime.parse(familyMemberItemDetails.dob!));*/
        int? relationValue = familyMemberItemDetails.relationship!.id!;
        relationDropdownValue = relationValue.toString();

        loading = false;
      });
    }
  }
}
