///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/nominee.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/family_and_nominee_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class FamilyMemberDetailsListWidget extends StatefulWidget {

 final List? familyMemberDetailsList;

  FamilyMemberDetailsListWidget({
    this.familyMemberDetailsList,

  });

  @override
  FamilyMemberDetailsListWidgetState createState() =>
      FamilyMemberDetailsListWidgetState();
}

class FamilyMemberDetailsListWidgetState
    extends State<FamilyMemberDetailsListWidget> {


  NomineeDetailsVO nomineeDetails = NomineeDetailsVO();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.familyMemberDetailsList!.length,
      //itemCount: 3,
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
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text((1+index).toString()+". "),
                                  Text(
                                      widget.familyMemberDetailsList![index].name
                                          .toUpperCase(),
                                      style: TextStyle(
                                          fontSize: AppDigits.fontSize,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                    " ( " +
                                        widget.familyMemberDetailsList![index]
                                            .relationship!.relationShip +
                                        " )",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: AppDigits.fontSize,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                         GestureDetector(onTap: (){
                           navigateToDeleteWorkerFamilyMember(widget.familyMemberDetailsList![index].id!);
                         },
                             child: Icon(Icons.delete,color: Colors.red,))

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Aadhaar No. : " + "  " +
                            widget.familyMemberDetailsList![index].aadhaarNumber
                                .toString(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ),
                      SizedBox(height: AppDigits.size,),
                      Text(
                        "Relation : " +"  " +
                            widget.familyMemberDetailsList![index].relationship!.relationShip,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ),
                      SizedBox(height: AppDigits.size,),
                      widget.familyMemberDetailsList![index].dob != null ?  Text(
                        "DOB : " +"  " +
                            DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.familyMemberDetailsList![index].dob).toUtc()),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text(   "DOB : " +"  ",  style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      ),),
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

  Future<void> navigateToDeleteWorkerFamilyMember(int? id) async {
    FilterVO registrationFilterVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    registrationFilterVo.workerFamilyMemberId = id;

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registrationFilterVo);
    var response = await Api.deleteWorkerFamilyMember(encodedData, headers);

    /*nomineeDetails =
        NomineeDetailsVO.fromJson(convert.jsonDecode(response.body));*/
    if (response.statusCode == 200) {

        Fluttertoast.showToast(
          msg: "Attachment Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FamilyAndNomineeDetails()));
        });


      } else {
        Fluttertoast.showToast(
          msg: "Failed To Delete Attachment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }


  }}
