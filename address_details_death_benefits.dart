///Updated on 19/12/2022 by Arsha

import 'dart:async';
import 'dart:convert' as convert;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';
import 'package:obocwwb/custom_widgets/custom_header.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/profile_address_details_vo.dart';

import 'package:obocwwb/obocwwb_ui/death_benefit/construction_worker_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/subscription_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../model/application_detail_vo.dart';
import '../../model/filter_vo.dart';


class AddressDetailsDeathBenefitsForm extends StatefulWidget {
   ApplicationDetailVo initiate = ApplicationDetailVo();
  AddressDetailsDeathBenefitsForm({required this.initiate}) : super();

  @override
  AddressDetailsDeathBenefitsFormState createState() =>
      AddressDetailsDeathBenefitsFormState();
}

class AddressDetailsDeathBenefitsFormState
    extends State<AddressDetailsDeathBenefitsForm> {
  StreamSubscription? internetConnection;
  bool isOffline = false;
  bool loading = true;
  TextEditingController permanentBlock = TextEditingController();
  TextEditingController permanentVillage = TextEditingController();
  TextEditingController permanentGramPanchayat = TextEditingController();

  TextEditingController presentBlock = TextEditingController();
  TextEditingController presentVillage = TextEditingController();
  TextEditingController presentGramPanchayath = TextEditingController();

  TextEditingController permanentAddress = TextEditingController();
  TextEditingController presentAddress = TextEditingController();
  TextEditingController permanentRuralOrUrban = TextEditingController();
  TextEditingController presentRuralOrUrban = TextEditingController();
  TextEditingController ulb = TextEditingController();
  TextEditingController _presentULB = TextEditingController();
  TextEditingController _permanentWard = TextEditingController();
  TextEditingController _presentWard = TextEditingController();
  TextEditingController textPermanentStateController =
      TextEditingController();
  //permanent district
  TextEditingController textPermanentDistrictController =
      TextEditingController();
  //permanent block
  TextEditingController textPresentDistrictController =
      TextEditingController();
  //present block

  ProfileAddressDetailsVo addressDetails = ProfileAddressDetailsVo();

  @override
  void initState() {
    internetConnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // when every connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isOffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isOffline = false;
        });
      }
    });
    findAddressDetailsByWorkerIdAddressDetails();
    super.initState();
  }

  @override
  void dispose() {
    internetConnection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    return StatefulBuilder(builder: (BuildContext cont, StateSetter state) {
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
             /*   loading
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
                    : */Expanded(
                        child: SingleChildScrollView(
                          child: Card(
                            child: Container(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //headerCardWithIcon("Address details"),
                                /*  MyCustomHeader()
                                      .*/headerCard(StringsEn().permanentAddress),
                                  SizedBox(height: 10.0),
                                  //Permanent Address
                                /*  MyCustomTextField().readOnlyText(
                                      TextInputType.text,
                                      StringsEn().address,
                                      addressDetails.permanentAddress
                                          .toString())*/ MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().address,
                                      permanentAddress,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),

                                  //State
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                          TextInputType.text,
                                          StringsEn().state,
                                          textPermanentStateController,
                                          true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),

                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                          TextInputType.text,
                                         StringsEn().district,
                                          textPermanentDistrictController,
                                          true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),

                                  //Block/ULB
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                          TextInputType.text,
                                          StringsEn().urbanOrRural,
                                          permanentRuralOrUrban,
                                          true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),
                                  addressDetails.permanentRuralOrUrban == 'U' ? Container(
                                    child: Column(
                                      children: [
                                        MyCustomTextField()
                                            .textWithTextControllerTextField(
                                            TextInputType.text,
                                            StringsEn().uLB,
                                            ulb,
                                            true),
                                        SizedBox(
                                          height: AppDigits.size,
                                        ),

                                        MyCustomTextField()
                                            .textWithTextControllerTextField(
                                            TextInputType.text,
                                            StringsEn().ward,
                                            _permanentWard,
                                            true),
                                      ],
                                    ),
                                  ):
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().block,
                                      permanentBlock,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().village,
                                      permanentVillage,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().gramPanchayat,
                                      permanentGramPanchayat,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),

                                  MyCustomHeader()
                                      .headerCard(StringsEn().presentAddress),

                                 /* MyCustomTextField().readOnlyText(
                                      TextInputType.text,
                                     StringsEn().address,
                                      addressDetails.presentAddress.toString())*/  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().address,
                                      presentAddress,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),

                                  //District
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                          TextInputType.text,
                                         StringsEn().district,
                                          textPresentDistrictController,
                                          true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),

                                  //Block/ULB
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                          TextInputType.text,
                                          StringsEn()
                                      .urbanOrRural,
                                          presentRuralOrUrban,
                                          true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),
                                  addressDetails.presentRuralOrUrban == 'U' ? Container(
                                    child: Column(
                                      children: [
                                        MyCustomTextField()
                                            .textWithTextControllerTextField(
                                            TextInputType.text,
                                            StringsEn().uLB,
                                            _presentULB,
                                            true),
                                        SizedBox(
                                          height: AppDigits.size,
                                        ),

                                        MyCustomTextField()
                                            .textWithTextControllerTextField(
                                            TextInputType.text,
                                            StringsEn().ward,
                                            _presentWard,
                                            true),
                                      ],
                                    ),
                                  ):
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().block,
                                      presentBlock,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().village,
                                      presentVillage,
                                      true),
                                  SizedBox(
                                    height: AppDigits.size,
                                  ),
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                      TextInputType.text,
                                      StringsEn().gramPanchayat,
                                      presentGramPanchayath,
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
                  ConstructionWorkerDetailsDeathBenefitsForm(
                      initiate: widget.initiate),
                  SubscriptionDetailsDeathBenefitsForm(
                      initiate: widget.initiate),
                  "2",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget errMsg(String text, bool show) {
    //error message widget.
    if (show == true) {
      //if error is true then show error message box
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.white),
          ), // icon for error message

          Text(text, style: TextStyle(color: Colors.white)),
          //show error message text
        ]),
      );
    } else {
      return Container();
      //if error is false, return empty container.
    }
  }

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

  Future<void> findAddressDetailsByWorkerIdAddressDetails() async {
    FilterVO commonFilterVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    commonFilterVo.status =/* "6cjMSb4fOJI="*/ pref.getString("encryptedWorkerId");
    commonFilterVo.otrID = pref.getInt('otrID');
    commonFilterVo.workerRegId = pref.getInt('workerId');

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(commonFilterVo);
    var response = await Api.findAddressDetailsByWorkerId(encodedData, headers);
    //Checking condition whether response is null or not
    if (response.statusCode == 200) {
      setState(() {
        addressDetails =
            ProfileAddressDetailsVo.fromJson(convert.jsonDecode(response.body));
        permanentAddress.text =  addressDetails.permanentAddress!;
        if(addressDetails.permanentState!.stateName != null){

          textPermanentStateController.text = addressDetails.permanentState!.stateName!;
        }
        //permanent district
        if(addressDetails.permanentDistrict!.districtName != null){

          textPermanentDistrictController.text = addressDetails.permanentDistrict!.districtName!;
        }
        permanentRuralOrUrban.text = addressDetails.permanentRuralOrUrban == 'U' ? 'Urban' : 'Rural';

        if( addressDetails.permanentRuralOrUrban == 'U'){
          ulb.text = addressDetails.permanentUlbSetup!.ulbName!;

          _permanentWard.text = addressDetails.permanentWardSetup!.name!;
        }else{
           permanentBlock.text = addressDetails.permanentBlock!.blockName!;
           permanentVillage.text = addressDetails.permanentVillageSetup!.name!;
           permanentGramPanchayat.text = addressDetails.permanentGramaPanchayat!;

        }




        presentAddress.text = addressDetails.presentAddress!;

        if(addressDetails.presentDistrict!.districtName != null){

          textPresentDistrictController.text = addressDetails.presentDistrict!.districtName!;
        }

        presentRuralOrUrban.text = addressDetails.presentRuralOrUrban == 'U' ? 'Urban' : 'Rural';

        if(addressDetails.presentRuralOrUrban == 'U'){
          _presentWard.text = addressDetails.presentWardSetup!.name!;

          _presentULB.text = addressDetails.presentUlbSetup!.ulbName!;
        }else{
          presentBlock.text = addressDetails.presentBlock!.blockName!;
          presentVillage.text = addressDetails.presentVillageSetup!.name!;
          presentGramPanchayath.text = addressDetails.presentGramaPanchayat!;
        }
           //permanent block


        //present block

        loading = false;
      });
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBoxSessionTimeOut(context);
      }
    }
  }
}
