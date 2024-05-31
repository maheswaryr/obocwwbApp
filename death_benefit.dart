///Updated on 19/12/2022 by Arsha

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/scheme_attachment_vo.dart';

import 'package:obocwwb/model/scheme_setup.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/construction_worker_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/home/home-page_new.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../model/application_detail_vo.dart';
import '../../model/one_time_registration.dart';

import 'dart:convert' as convert;

class DeathBenefit extends StatefulWidget {
 final int? id;
  DeathBenefit({this.id}) : super();

  @override
  DeathBenefitState createState() => DeathBenefitState();
}

class DeathBenefitState extends State<DeathBenefit> {
  SchemeSetup schemeInfo = SchemeSetup();
  List<SchemeAttachmentVo> schemeAttachmentList = [];
  bool loading = true;
  ApplicationDetailVo initiate = ApplicationDetailVo();

  @override
  void initState() {
    getSchemeById(widget.id);
    getSchemeAttachmentList(widget.id);
    super.initState();
  }

  String formatHtmlString(String string) {
    return string
        .replaceAll("<p>", "") // Paragraphs
        .replaceAll("</p>", "") // Paragraphs

        .trim(); // Whitespace
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
                      builder: (context) => HomePageNew(),
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
          title: Text(StringsEn().grantOfDeathBenefits),
          backgroundColor: AppColor.primaryColor,
        ),
        body: loading
            ? Center(child: const CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    MyCustomText().textWithPadding(
                        formatHtmlString(
                            schemeInfo.schemeGuidelines.toString()),
                        Colors.black),
                    SizedBox(
                      height: 10,
                    ),
                    MyCustomText()
                        .textWithoutPadding(StringsEn().documentsNeeded, Colors.black),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: ListView.builder(
                        itemCount: schemeAttachmentList.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return MyCustomText().textWithPadding(
                              (index + 1).toString() +
                                  ". " +
                                  schemeAttachmentList[index]
                                      .attachmentName
                                      .toString(),
                              Colors.black);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          await initiateApplication();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ConstructionWorkerDetailsDeathBenefitsForm(
                                        initiate: initiate)),
                          );
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              AppColor.primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            StringsEn().apply.toUpperCase(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> getSchemeById(int? id) async {
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(id);
    var response = await Api.getSchemeById(encodedData, headers);
    if (response.statusCode == 200) {
      schemeInfo = SchemeSetup.fromJson(convert.jsonDecode(response.body));
      setState(() {
        loading = false;
      });
    } else {}
  }

  Future<void> initiateApplication() async {
    ApplicationDetailVo applicationDetailVo = ApplicationDetailVo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    applicationDetailVo.otr = OneTimeRegistration();
    applicationDetailVo.otr!.id = prefs.getInt("otrID");
    applicationDetailVo.scheme = SchemeSetup();
    applicationDetailVo.scheme!.id = schemeInfo.id;
    applicationDetailVo.applicationType = "SH";
    applicationDetailVo.status = "I";
    applicationDetailVo.worker = RegistrationVO();
    applicationDetailVo.worker!.id = prefs.getInt("workerId");
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(applicationDetailVo);
    var response = await Api.initiateApplication(encodedData, headers);
    if (response.statusCode == 200) {
      initiate =
          ApplicationDetailVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        loading = true;
      });
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBoxSessionTimeOut(context);
      }
    }
  }

  Future<void> getSchemeAttachmentList(int? id) async {
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(id);
    var response = await Api.getSchemeAttachmentList(encodedData, headers);
    if (response.statusCode == 200) {
      schemeAttachmentList = (json.decode(response.body) as List)
          .map((i) => SchemeAttachmentVo.fromJson(i))
          .toList();
      setState(() {
        loading = false;
      });
    }
  }
}
