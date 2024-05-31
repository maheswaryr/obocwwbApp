///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/model/registration_Models/filter_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;

class CustomDeathDetailsDetailsWidgetProfile extends StatefulWidget {

 final List? familyNomineeDetailsList;

  CustomDeathDetailsDetailsWidgetProfile({
    this.familyNomineeDetailsList,

  });

  @override
  _CustomDeathDetailsDetailsWidgetProfileState createState() =>
      _CustomDeathDetailsDetailsWidgetProfileState();
}

class _CustomDeathDetailsDetailsWidgetProfileState
    extends State<CustomDeathDetailsDetailsWidgetProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.familyNomineeDetailsList!.length,

      itemBuilder: (context, index) {

        return ListTile(
          dense: true,
          contentPadding: EdgeInsets.all(0.0),
          title: Container(
            decoration: BoxDecoration(
              border:
              Border.all(color: Colors.black26),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Nominee name, share in percentage, relationship, DoB
                Container(
                  padding: EdgeInsets.all(5),
                  color: Colors.black12,
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  widget.familyNomineeDetailsList![index].legaHeirName
                                      .toUpperCase() +
                                      ". ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              Text(
                                "( " +
                                    widget.familyNomineeDetailsList![index]
                                        .legaHeirrelationShip.relationShip +
                                    " )",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                "Date of Birth: " +
                                    widget.familyNomineeDetailsList![index].dobToStr
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(

                                      "%",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Text(
                              "Share in %",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                ),
                //aadhaar Number, Acc no

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Aadhaar No.- " +
                              widget.familyNomineeDetailsList![index].legaHeirAadhaarNumber
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Acc No.- " +
                              widget.familyNomineeDetailsList![index].legaHeiraccNo,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Address.- " +
                              widget.familyNomineeDetailsList![index].legaHeirAddress
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Relation.- " ,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future<void> deleteWorkerAttachment(int attachmentId) async{

    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    RegistrationFilterVo commonFilterVO = RegistrationFilterVo();
    commonFilterVO.attachmentId = attachmentId;
    String encodedData = convert.jsonEncode(commonFilterVO);
    var newResponse =
    await Api.deleteWorkerNominee(encodedData, headers);
    if (newResponse.statusCode == 200) {
      if (newResponse.body == 'true') {
        Fluttertoast.showToast(
          msg: "Attachment Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );

      } else {
        Fluttertoast.showToast(
          msg: "Failed To Delete Attachment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }

  }
}
