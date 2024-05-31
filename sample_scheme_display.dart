///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/model/FilterVo/filter_vo.dart';
import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/model/block_setup_vo.dart';
import 'package:obocwwb/model/district_setup_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/model/scheme_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SchemeDisplay extends StatefulWidget {
 final int? id;
  SchemeDisplay({Key? key, this.id}) : super(key: key);
  @override
  SchemeDisplayState createState() => SchemeDisplayState();
}

class SchemeDisplayState extends State<SchemeDisplay> {
  int? countryId;
  int? id;
  List<SchemeSetup> schemeList = <SchemeSetup>[];
  var loading = true;
  ApplicationDetailVo initiate = ApplicationDetailVo();
  @override
  void initState() {
    fetchSchemeList();
    initiateApplication();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit'),
              content: Text('Do you want to Exit?'),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: loading
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'Loading, Please Wait...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.all(0.0),
                      title: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    (index + 1).toString() + ". ",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          schemeList[index].schemeName.toString() + ".",
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 5.0),
                                  MyCustomButton().getHomeApplyButton(
                                      index = index + 1,
                                      context,
                                      schemeList[index - 1].id!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }

  void fetchSchemeList() async {
    Filter schemeSetup = Filter();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    schemeSetup.countryId = countryId;

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(schemeSetup);
    var response = await Api.getSchemeList(encodedData, headers);
    //Checking condition whether response is null or not
    if (response.body != null) {
      //Converting jsonList to dartObject
      schemeList = (json.decode(response.body) as List)
          .map((i) => SchemeSetup.fromJson(i))
          .toList();
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> initiateApplication() async {
    ApplicationDetailVo applicationDetailVo = ApplicationDetailVo();
    applicationDetailVo.block = BlockSetUpVo();
    applicationDetailVo.block!.id = 642;
    applicationDetailVo.district = DistrictSetupVo();
    applicationDetailVo.district!.id = 344;
    applicationDetailVo.otr = OneTimeRegistration();
    applicationDetailVo.otr!.id = 51;
    applicationDetailVo.scheme = SchemeSetup();
    applicationDetailVo.scheme!.id = 4;
    applicationDetailVo.applicationType = "SH";
    applicationDetailVo.status = "I";
    applicationDetailVo.worker = RegistrationVO();
    applicationDetailVo.worker!.id = 45;
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
        loading = false;
      });
    } else {}
  }
}
