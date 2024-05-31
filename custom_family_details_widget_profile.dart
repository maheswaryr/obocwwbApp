///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/model/registration_Models/filter_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;


class CustomFamilyNomineeDetailsWidgetProfile extends StatefulWidget {

 final List? familyNomineeDetailsList;



  CustomFamilyNomineeDetailsWidgetProfile({
    this.familyNomineeDetailsList,

  });

  @override
  _CustomFamilyNomineeDetailsWidgetProfileState createState() =>
      _CustomFamilyNomineeDetailsWidgetProfileState();
}

class _CustomFamilyNomineeDetailsWidgetProfileState
    extends State<CustomFamilyNomineeDetailsWidgetProfile> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.familyNomineeDetailsList!.length,

      itemBuilder: (context, index) {
        return Card(
          elevation: 2.0,
          child: ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0.0),
            title: Container(

              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),



              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    color: AppColor.primaryColor.withOpacity(0.2),
                    child: Row(
                     children: [
                     Expanded(
                         child: Padding(padding: EdgeInsets.all(5),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text((1+index).toString()+". "),
                           Text( widget.familyNomineeDetailsList![index].name
                               .toUpperCase() +
                               ". ",
                               style: TextStyle(
                                   fontSize: AppDigits.titleSize,
                                   fontWeight: FontWeight.w500,
                                   color: Colors.black)),
                           Text(
                             "( " +
                                 widget.familyNomineeDetailsList![index]
                                     .relationship!.relationShip +
                                 " )",
                             style: TextStyle(
                                 color: Colors.black45,
                                 fontSize: AppDigits.fontSize,
                                 fontWeight: FontWeight.w500,
                                 fontStyle: FontStyle.italic),
                           ),
                         ],
                       ),

                     )),

                     ],
                      ),



                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Aadhaar No.- " +
                              widget.familyNomineeDetailsList![index].aadhaarNumber!
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
                              widget.familyNomineeDetailsList![index].dobToString
                                  .toString(),
                          style: TextStyle(
                              fontSize: AppDigits.fontSize,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        ),
                        SizedBox(height: 4,),
                        Text(
                          "Relation.- " +
                              widget.familyNomineeDetailsList![index].relationship!.relationShip,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: AppDigits.fontSize,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
