///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/app_theme.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';

import 'package:obocwwb/custom_widgets/custom_dropdown/custom_dropdown_widget.dart';

import 'package:obocwwb/custom_widgets/custom_list.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/custom_widgets/establishment_list.dart';
import 'package:obocwwb/model/block_setup_vo.dart';
import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';
import 'package:obocwwb/model/district_setup_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/model_class/ulb_setup_vo.dart';
import 'package:obocwwb/model/model_class/village_setup_vo.dart';
import 'package:obocwwb/model/model_class/ward_setup_vo.dart';
import 'package:obocwwb/model/mw_services_models/filter_vo.dart';
import 'package:obocwwb/model/natureof_work_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/model/state_setup.dart';
import 'package:obocwwb/model/trade_union_setup_vo.dart';
import 'package:obocwwb/model/worker_establishment_vo.dart';

import 'package:obocwwb/obocwwb_ui/application_for_registration/family_and_nominee_details.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_other_details.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/application_detail_vo.dart';
import '../applicant_application/test_home.dart';

class DetailsOfTheEstablishment extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  final int? workId;
  RegistrationVO? profileAddressDetailsVo;
  DetailsOfTheEstablishment(
      {Key? key, this.workId, this.profileAddressDetailsVo})
      : super(key: key);

  @override
  State<DetailsOfTheEstablishment> createState() =>
      _DetailsOfTheEstablishmentState();
}

class _DetailsOfTheEstablishmentState extends State<DetailsOfTheEstablishment> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loading = true;
  int _groupValue = 1;
  TextEditingController nameOfEstablishmentController = TextEditingController();
  TextEditingController registeredNumberController = TextEditingController();
  TextEditingController contactPersonController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController establishmentAddressController =
      TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController periodFromController = TextEditingController();
  TextEditingController periodUpToController = TextEditingController();
  TextEditingController _textPermanentGramPanchayat = TextEditingController();
  TextEditingController textInspectorNameController = TextEditingController();
  TextEditingController textTradeUnionNameController = TextEditingController();
  TextEditingController textCertifyingNameController = TextEditingController();
  String? typeOfCertificationChoose;
  String? typeOfEstablishmentChoose;
  String? typeOfGVOTChoose;

  String? dropdownValueRegStatePermanent;
  String? dropdownValueForRegistrationDistrictPermanent;
  String? dropdownValueForPresentVillage;
  String? dropdownValueForUlb;
  String? dropdownValueForWard;
  String? dropdownValueForRegBlockPermanent;
  String? dropdownValueForRegVillage;
  String? dropdownValueForTradeUnion;
  String? dropdownValueForCertifying;
  String? value1;
  String? workId;
  String? id;
  String? tradeId;
  String? certifyingId;
  bool inspectorStatusValue = false;
  bool tradeStatusValue = false;
  List<DropDownVO> typeOfCertificationList =
      MyCustomList().employmentCertificationList;
  List<DropDownVO> typeOfEstablishmentList = MyCustomList().establishmentList;
  List natureOfWorkList = [];
  List stateList = [];
  List certifyingList = [];
  List districtList = [];
  List villageList = [];
  List tradeUnionList = [];
  List blockList = [];
  List ulbList = [];
  List wardList = [];
  List<WorkerEstablishmentVo> establishmentDetails = [];
  RegistrationVO regResponse = new RegistrationVO();

  @override
  void initState() {
    super.initState();
    getStateList();
    getAllActiveNatureOFWork();
    getWorkerEstablishmentDetails();
    getRegistrationDetails();
    getTradeUnion();
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
                            headerCard(StringsEn().detailsOfTheEstablishment),
                            SizedBox(height: AppDigits.size),
                            //Name of establishment/employer
                            MyCustomTextField()
                                . /*readOnlyText*/ textWithTextControllerTextFieldWithoutImpMark(
                                    TextInputType.text,
                                    StringsEn().nameOfEstablishmentOrEmployer,
                                    nameOfEstablishmentController,
                                    false),
                            SizedBox(height: AppDigits.size),
                            //Registered number
                            MyCustomTextField()
                                .textWithTextControllerTextFieldWithoutImpMarkNew(
                                    TextInputType.text,
                                    StringsEn().registeredNumber,
                                    registeredNumberController,
                                    false),
                            SizedBox(height: AppDigits.size),
                            //Contact person
                            MyCustomTextField()
                                .textWithTextControllerTextFieldWithoutImpMark(
                                    TextInputType.name,
                                    StringsEn().contactPerson,
                                    contactPersonController,
                                    false),
                            SizedBox(height: AppDigits.size),
                            //Contact number
                            MyCustomTextField()
                                .textWithMobileNumValidationTextFieldWithoutImpMark(
                                    TextInputType.phone,
                                    StringsEn().contactNumber,
                                    contactNumberController,
                                    false),

                            SizedBox(height: AppDigits.size),
                            //Whether the establishment is govt/private
                            CustomDropDownWidget(
                              text: StringsEn()
                                  .whetherTheEstablishmentIsGovtOrPvt,
                              chooseValue: typeOfGVOTChoose,
                              myList: typeOfEstablishmentList,
                              onChanged: (newValue) =>
                                  setState(() => typeOfGVOTChoose = newValue),
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
                            SizedBox(height: AppDigits.size),
                            //Establishment"s address
                            MyCustomTextField()
                                .textWithTextControllerTextFieldWithoutImpMark(
                                    TextInputType.text,
                                    StringsEn().establishmentAddress,
                                    establishmentAddressController,
                                    false),
                            SizedBox(height: AppDigits.size),
                            //Urban or Rural
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
                                )),
                            //State list
                            SizedBox(height: AppDigits.size),

                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: stateListDropDown(cont, state),
                                )),
                            //District list

                            SizedBox(height: AppDigits.size),
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border:
                                          Border.all(color: Colors.black12)),
                                  child: districtDropDown(cont, state),
                                )),
                            //ulb list
                            //ward list
                            _groupValue == 1
                                ? Container(
                                    child: Column(
                                      children: [
                                        SizedBox(height: AppDigits.size),
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
                                                  ulbListDropDown(cont, state),
                                            )),
                                        SizedBox(height: AppDigits.size),
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
                                                  wardListDropDown(cont, state),
                                            )),
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
                                              bottomLeft: Radius.circular(8.0),
                                              bottomRight: Radius.circular(8.0),
                                              topRight: Radius.circular(8.0),
                                            ),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: AppDigits.size),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        border: Border.all(
                                                            color: Colors
                                                                .black12)),
                                                    child: blockDropDown(
                                                        cont, state),
                                                  )),
                                              SizedBox(height: AppDigits.size),
                                              Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        border: Border.all(
                                                            color: Colors
                                                                .black12)),
                                                    child: villageDropDown(
                                                        cont, state),
                                                  )),
                                              SizedBox(height: AppDigits.size),
                                              MyCustomTextField()
                                                  .textWithTextControllerTextField(
                                                      TextInputType.text,
                                                      StringsEn().gramPanchayat,
                                                      _textPermanentGramPanchayat,
                                                      false),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                            SizedBox(height: AppDigits.size),
                            //Pincode
                            MyCustomTextField()
                                .textWithPinCodeControllerTextField(
                                    TextInputType.number,
                                    StringsEn().pincode,
                                    pinCodeController,
                                    false),

                            SizedBox(height: AppDigits.size),

                            Column(
                              children: [
                                CustomDropDownWidget(
                                  text: StringsEn().employmentCertifiedBy,
                                  chooseValue: typeOfCertificationChoose,
                                  myList: typeOfCertificationList,
                                  onChanged: (newValue) => setState(() {
                                    typeOfCertificationChoose = newValue;
                                    typeOfCertificationChoose == 'I'
                                        ? inspectorStatusValue = true
                                        : inspectorStatusValue = false;
                                    typeOfCertificationChoose == "T"
                                        ? tradeStatusValue = true
                                        : tradeStatusValue = false;
                                  }),
                                ),
                                SizedBox(height: AppDigits.size),
                                Visibility(
                                  visible: tradeStatusValue,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, right: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(0),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: tradeUnionDropDown(cont, state),
                                      )),
                                ),
                                SizedBox(height: AppDigits.size),
                                /*           Visibility(
                                  visible: tradeStatusValue,
                                  child: Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 10.0,
                                          right: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius
                                                .circular(0),
                                            border: Border.all(
                                                color: Colors
                                                    .black12)),
                                        child: certifyingPersonDropDown(cont, state)
                                      )),
                                ),*/

                                Visibility(
                                    visible: inspectorStatusValue,
                                    child: MyCustomTextField()
                                        .textWithTextControllerTextFieldWithoutImpMark(
                                            TextInputType.text,
                                            StringsEn().pleaseSpecify,
                                            textInspectorNameController,
                                            false))
                              ],
                            ),
                            //Employment certified by

                            SizedBox(height: AppDigits.size),
                            //Period from
                            MyCustomTextField()
                                .textWithTextControllerDateTextFieldOneDiff(
                                    context,
                                    StringsEn().periodFrom,
                                    periodFromController,
                                    false),
                            SizedBox(height: AppDigits.size),
                            //Period upto
                            MyCustomTextField()
                                .textWithTextControllerDateCurrentTextFieldOneYearDiff(
                                    context,
                                    StringsEn().periodUpTo,
                                    periodUpToController,
                                    false),
                            SizedBox(height: AppDigits.size),
                            //Add establishment
                            Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {});
                                    var diffDate = DateTime.parse(
                                            periodUpToController.text)
                                        .difference(DateTime.parse(
                                            periodFromController.text))
                                        .inDays;
                                    if (_formKey.currentState!.validate()) {
                                      Fluttertoast.showToast(
                                          msg:
                                          StringsEn().addingDetails,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueGrey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                   /*   final snackBar = SnackBar(
                                          content:
                                              Text(StringsEn().addingDetails));
                                      _scaffoldKey.currentState!
                                          .showSnackBar(snackBar);*/
                                    }
                                    if (registeredNumberController.text != "" &&
                                            nameOfEstablishmentController.text !=
                                                "" &&
                                            contactNumberController.text !=
                                                "" &&
                                            contactPersonController.text !=
                                                "" &&
                                            establishmentAddressController
                                                    .text !=
                                                "" &&
                                            pinCodeController.text != "" &&
                                            nameOfEstablishmentController
                                                    .text !=
                                                "" &&
                                            diffDate <= 90 &&
                                            typeOfCertificationChoose == 'I'
                                        ? textInspectorNameController.text != ""
                                        : typeOfCertificationChoose != "" &&
                                                typeOfCertificationChoose == 'T'
                                            ? (textTradeUnionNameController
                                                        .text !=
                                                    "" &&
                                                textCertifyingNameController
                                                        .text !=
                                                    "")
                                            : typeOfCertificationChoose != "" &&
                                                pinCodeController.text != "") {
                                      saveWorkerEstablishmentForm();
                                    } else if (nameOfEstablishmentController
                                            .text ==
                                        "") {
                                      Fluttertoast.showToast(
                                          msg:
                                          StringsEn()
                                              .enterValidEstablishmentEmployerName,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueGrey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                   /*   _scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(
                                              content: Text(StringsEn()
                                                  .enterValidEstablishmentEmployerName)));*/
                                    } else if (registeredNumberController
                                            .text ==
                                        "") {
                                      Fluttertoast.showToast(
                                          msg:
                                          StringsEn()
                                              .enterValidRegisteredNumber,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.blueGrey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                     /* _scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(
                                              content: Text(StringsEn()
                                                  .enterValidRegisteredNumber)));*/
                                    } else if (diffDate > 90) {
                                      EasyLoading.showError(StringsEn()
                                          .periodOfWorkingInEstablishmentsShouldBeGreaterThan90Days);
                                    } else {
                                      saveWorkerEstablishmentForm();
                                      /*  _scaffoldKey.currentState!.showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Make sure all the mandatory fields are filled  ?' */ /*  'Account number must be same'*/ /*)));*/

                                    }
                                  },
                                  child: MyCustomButton().buttonTextWidget(
                                      StringsEn().addEstablishment),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColor.primaryColor)),
                            ),
                            EstablishmentListWidget(
                              establishmentDetailsList: establishmentDetails,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  MyCustomContainer().getBottomLayout(
                    context,
                    FamilyAndNomineeDetails(),
                    WorkerOtherDetails(
                      profileAddressDetailsVo: widget.profileAddressDetailsVo,
                    ),
                    "5",
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
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
            id = newValue;
            dropdownValueForRegistrationDistrictPermanent = null;
            dropdownValueForRegBlockPermanent = null;
            dropdownValueForRegVillage = null;
            dropdownValueForUlb = null;
            dropdownValueRegStatePermanent = newValue!;
            getDistrictListPermanent(id!);
          });
        },
      ),
    );
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
            id = newValue;
            dropdownValueForRegBlockPermanent = null;
            dropdownValueForRegVillage = null;
            dropdownValueForUlb = null;
            dropdownValueForWard = null;
            dropdownValueForRegistrationDistrictPermanent = newValue!;
            getULBs(id);
            getBlocks(id);
          });
        },
      ),
    );
  }

  blockDropDown(BuildContext context, StateSetter setter) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        // Initial Value
        value: dropdownValueForRegBlockPermanent,
        hint: Text(
          StringsEn().block,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        // Array list of items
        items: blockList.map((item) {
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
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            id = newValue;
            dropdownValueForRegBlockPermanent = newValue!;
            getVillageByBlockList(id);
          });
        },
      ),
    );
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
            id = newValue;
            dropdownValueForPresentVillage = newValue!;
          });
        },
      ),
    );
  }

  villageDropDown(BuildContext cont, StateSetter state) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropdownValueForRegVillage,
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
              id = newValue;
              dropdownValueForRegVillage = newValue!;
            });
          },
        ));
  }

  tradeUnionDropDown(BuildContext cont, StateSetter state) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropdownValueForTradeUnion,
          hint: Text(
            StringsEn().tradeUnion,
            style: TextStyle(fontSize: AppDigits.fontSize),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: tradeUnionList.map((item) {
            return DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item['unionName'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize),
                ),
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              tradeId = newValue;
              dropdownValueForCertifying = null;
              dropdownValueForTradeUnion = newValue!;

              getCertifyingPerson(id!);
            });
          },
        ));
  }

  Future<void> getTradeUnion() async {
    FilterVO filterVO = FilterVO();
    filterVO.status = "Y";
    filterVO.blockId = 0;

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String encodedData = convert.jsonEncode(filterVO);
    //api
    var response = await Api.getAllAciveTradeUnion(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        tradeUnionList = responseBody;
      });
    }
  }

  Future<void> getCertifyingPerson(String? id) async {
    FilterVO filterVO = FilterVO();
    filterVO.status = 'Y';
    filterVO.blockId = int.parse(id!);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    String encodedData = convert.jsonEncode(filterVO);
    //api
    var response = await Api.getCertifyingPerson(encodedData, headers);

    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        certifyingList = responseBody;
      });
    }
  }

  certifyingPersonDropDown(BuildContext cont, StateSetter state) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: dropdownValueForCertifying,
          hint: Text(
            StringsEn().certifyingPerson,
            style: TextStyle(fontSize: AppDigits.fontSize),
          ),
          icon: const Icon(Icons.keyboard_arrow_down),
          isExpanded: true,
          items: certifyingList.map((item) {
            return DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item['personNo'].toString(),
                  style: TextStyle(fontSize: AppDigits.fontSize),
                ),
              ),
              value: item['id'].toString(),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              certifyingId = newValue;
              dropdownValueForCertifying = newValue!;
            });
          },
        ));
  }

  Future<void> getVillageByBlockList(String? id) async {
    FilterVO filterVO = FilterVO();
    filterVO.placeId = int.parse(id!);
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

  ulbListDropDown(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValueForUlb,
        hint: Text(
          StringsEn().selectULB,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: ulbList.map((item) {
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
        onChanged: (String? newValue) {
          setState(() {
            id = newValue;
            dropdownValueForUlb = newValue!;
            dropdownValueForWard = null;
            getWardList(id);
          });
        },
      ),
    );
  }

  wardListDropDown(BuildContext cont, StateSetter state) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: DropdownButton<String>(
        underline: SizedBox(),
        value: dropdownValueForWard,
        hint: Text(
          StringsEn().selectWard,
          style: TextStyle(fontSize: AppDigits.fontSize),
        ),
        icon: const Icon(Icons.keyboard_arrow_down),
        isExpanded: true,
        items: wardList.map((item) {
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
            id = newValue;
            dropdownValueForWard = newValue!;
          });
        },
      ),
    );
  }

  natureOfWorkListDropDown(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: value1,
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
                                  style:
                                      TextStyle(fontSize: AppDigits.fontSize),
                                ))),
                      ],
                    )),
                value: item['workId'].toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                workId = newValue;
                value1 = newValue!;
              });
            }));
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
      var responseBody = json.decode(response.body);
      setState(() {
        natureOfWorkList = responseBody;
        loading = false;
      });
    }
  }

  Future<void> getStateList() async {
    FilterVo filterVo = FilterVo();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = 0;
    /* filterVo.villageId = 0;*/

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

  Future<void> getDistrictListPermanent(String? id) async {
    FilterVo filterVo = FilterVo();
    filterVo.countryId = 0;
    filterVo.districtId = 0;
    filterVo.stateId = int.parse(id!);
    /*  filterVo.villageId = 0;*/
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

  Future<void> getULBs(String? id) async {
    FilterVo filterVo = FilterVo();
    filterVo.districtId = int.parse(id!);
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVo);
    //api
    var response = await Api.getULBList(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        dropdownValueForUlb = null;
        ulbList = responseBody;
      });
    } else {}
  }

  Future<void> getWardList(String? id) async {
    FilterVo filterVo = FilterVo();
    filterVo.placeId = int.parse(id!);
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVo);
    //api
    var response = await Api.getWardEst(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        dropdownValueForWard = null;
        wardList = responseBody;
      });
    } else {}
  }

  Future<void> getBlocks(String? id) async {
    FilterVo filterVo = FilterVo();

    filterVo.countryId = 0;
    filterVo.districtId = int.parse(id!);
    filterVo.stateId = 0;
    /*  filterVo.villageId = 0;*/
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
      });
    } else {}
  }

  void saveWorkerEstablishmentForm() async {
    WorkerEstablishmentVo workerEstablishmentVo = WorkerEstablishmentVo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    workerEstablishmentVo.id = prefs.getInt("workerId");
    workerEstablishmentVo.registration = RegistrationVO();
/*    workerEstablishmentVo.registration =  regResponse;*/
    workerEstablishmentVo.registration!.id = prefs.getInt('workerId');
    workerEstablishmentVo.name = nameOfEstablishmentController.text;
    workerEstablishmentVo.registrationNumber = registeredNumberController.text;
    workerEstablishmentVo.contactPerson = contactPersonController.text;
    workerEstablishmentVo.contactNumber = contactNumberController.text;
    workerEstablishmentVo.employmentCertifiedBy = typeOfCertificationChoose;

    if (typeOfCertificationChoose == "Employer") {
      workerEstablishmentVo.employmentCertifiedBy = "E";
    } else if (typeOfCertificationChoose == "Inspector") {
      workerEstablishmentVo.employmentCertifiedBy = "I";
      workerEstablishmentVo.inspectorName = textInspectorNameController.text;
    } else if (typeOfCertificationChoose == "Trade union") {
      workerEstablishmentVo.employmentCertifiedBy = "T";
      workerEstablishmentVo.tradeUnionSetup = TradeUnionSetupVO();

      workerEstablishmentVo.tradeUnionSetup!.id =
          dropdownValueForTradeUnion != null
              ? int.parse(dropdownValueForTradeUnion!)
              : null;
/*
      workerEstablishmentVo.tradeUnionSetup!.id =
          int.parse(textTradeUnionNameController.text);*/
      workerEstablishmentVo.trideUnionCertifyingAuthority!.id =
          int.parse(textCertifyingNameController.text);
    } else if (typeOfCertificationChoose == "Self certification") {
      workerEstablishmentVo.employmentCertifiedBy = "S";
    }
    workerEstablishmentVo.govtOrPrivate = typeOfGVOTChoose;
    if (typeOfGVOTChoose == "Government") {
      workerEstablishmentVo.employmentCertifiedBy = "G";
    } else if (typeOfGVOTChoose == "Private") {
      workerEstablishmentVo.employmentCertifiedBy = "P";
    }
    workerEstablishmentVo.natureOfJob = NatureOfWorkVO();
    workerEstablishmentVo.natureOfJob!.workId =
        value1 != null ? int.parse(value1!) : null;
    workerEstablishmentVo.establishmentAddress =
        establishmentAddressController.text;
    workerEstablishmentVo.establishmentRuralOrUrban =
        _groupValue == 1 ? "U" : "R";
    workerEstablishmentVo.establishmentState = StateSetup();
    workerEstablishmentVo.establishmentState!.id =
        dropdownValueRegStatePermanent != null
            ? int.parse(dropdownValueRegStatePermanent!)
            : null;
    workerEstablishmentVo.establishmentDistrict = DistrictSetupVo();
    workerEstablishmentVo.establishmentDistrict!.id =
        dropdownValueForRegistrationDistrictPermanent != null
            ? int.parse(dropdownValueForRegistrationDistrictPermanent!)
            : null;
    workerEstablishmentVo.establishmentBlock = BlockSetUpVo();
    workerEstablishmentVo.establishmentBlock!.id =
        dropdownValueForRegBlockPermanent != null
            ? int.parse(dropdownValueForRegBlockPermanent!)
            : 0;
    workerEstablishmentVo.establishmentVillageSetup = VillageSetupVO();
    workerEstablishmentVo.establishmentVillageSetup!.id =
        dropdownValueForRegVillage != null
            ? int.parse(dropdownValueForRegVillage!)
            : 0;
    workerEstablishmentVo.establishmentUlbSetup = UlbSetupVO();
    workerEstablishmentVo.establishmentUlbSetup!.id =
        dropdownValueForUlb != null ? int.parse(dropdownValueForUlb!) : 0;
    workerEstablishmentVo.establishmentWardSetup = WardSetupVO();
    workerEstablishmentVo.establishmentWardSetup!.id =
        dropdownValueForWard != null ? int.parse(dropdownValueForWard!) : 0;
    workerEstablishmentVo.establishmentGramaPanchayat =
        _textPermanentGramPanchayat.text;
    workerEstablishmentVo.establishmentPostOffice = pinCodeController.text;
    workerEstablishmentVo.durationFromStr = periodFromController.text;
    workerEstablishmentVo.durationToStr = periodUpToController.text;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(workerEstablishmentVo);
    var response = await Api.saveWorkerEstablishmentForm(encodedData, headers);
    if (response.statusCode == 200) {
      workerEstablishmentVo =
          WorkerEstablishmentVo.fromJson(convert.jsonDecode(response.body));
      Fluttertoast.showToast(
          msg:
          'Added!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    /*  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text('Added')));*/
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DetailsOfTheEstablishment()));
      setState(() {
        loading = false;
        getWorkerEstablishmentDetails();
      });
    } else {
      Fluttertoast.showToast(
          msg:
          'Something went wrong!',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
     /* _scaffoldKey.currentState!
          .showSnackBar(SnackBar(content: Text('Something went wrong!')));*/
    }
  }

  Future<void> getWorkerEstablishmentDetails() async {
    FilterVO filterVO = FilterVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    filterVO.workerRegId = preferences.getInt('workerId');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response =
        await Api.getWorkerEstablishmentDetails(encodedData, headers);
    if (response.statusCode == 200) {
      establishmentDetails = (json.decode(response.body) as List)
          .map((i) => WorkerEstablishmentVo.fromJson(i))
          .toList();
      setState(() {
        loading = false;
      });
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
    }
  }
}
