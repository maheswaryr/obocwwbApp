///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/model/registration_Models/filter_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;


class CustomEditNomineeDetailsWidgetProfile extends StatefulWidget {

final  List? nomineeDetailsList;

  CustomEditNomineeDetailsWidgetProfile({
    this.nomineeDetailsList,

  });

  @override
  _CustomEditNomineeDetailsWidgetProfileState createState() =>
      _CustomEditNomineeDetailsWidgetProfileState();
}

class _CustomEditNomineeDetailsWidgetProfileState
    extends State<CustomEditNomineeDetailsWidgetProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.nomineeDetailsList!.length,

      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    padding: EdgeInsets.all(5),
                    color: AppColor.primaryColor.withOpacity(0.2),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text((1+index).toString()+". "),

                        Text(
                            widget.nomineeDetailsList![index].name
                                .toUpperCase() +
                                ". ",
                            style: TextStyle(
                                fontSize: AppDigits.titleSize,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        Text(
                          "( " +
                              widget.nomineeDetailsList![index]
                                  .relationship.relationShip +
                              " )",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: AppDigits.fontSize,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    )
                ),
                Padding(  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Aadhaar No.- " +
                            widget.nomineeDetailsList![index].aadhaarNumber
                                .toString(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Acc No.- " +
                            widget.nomineeDetailsList![index].nomAccNo,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Address.- " +
                            widget.nomineeDetailsList![index].address
                                .toString(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Date of Birth: " +
                            widget.nomineeDetailsList![index].dobToString
                                .toString(),
                        style: TextStyle(
                            fontSize: AppDigits.fontSize,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Relation.- " +
                            widget.nomineeDetailsList![index].relationship.relationShip,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4,),
                      Text(
                        "Share in %.- " +
                            widget.nomineeDetailsList![index].shareAmount.toString(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                    ],
                  ),)

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
