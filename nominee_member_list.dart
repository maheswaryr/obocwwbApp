import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/family_and_nominee_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
class NomineeMemberDetailsListWidget extends StatefulWidget {
  final List? nomineeDetailsList;
  NomineeMemberDetailsListWidget({
    this.nomineeDetailsList,
  });

  @override
  NomineeMemberDetailsListWidgetState createState() =>
      NomineeMemberDetailsListWidgetState();
}

class NomineeMemberDetailsListWidgetState
    extends State<NomineeMemberDetailsListWidget> {
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
                //Nominee name, share in percentage, relationship, DoB
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
                                      widget.nomineeDetailsList![index].name.toString()/*.toUpperCase()*/ ,
                                      style: TextStyle(
                                          fontSize: AppDigits.fontSize,
                                          fontWeight: FontWeight.w500)),
                                  widget.nomineeDetailsList![index]
                                      .relationship != null ?       Text(
                                    " ( " +
                                        widget.nomineeDetailsList![index]
                                            .relationship!.relationShip +
                                        " )",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: AppDigits.fontSize,
                                        fontWeight: FontWeight.w500),
                                  ):Text(" ( " +  " )"),
                                ],
                              ),
                              GestureDetector(
                                onTap: (){
                                  navigateToDeleteNomineeDetailsList(widget.nomineeDetailsList![index].id!);
                                },
                                  child:  Icon(Icons.delete,color: Colors.red,))
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
                      widget.nomineeDetailsList![index].aadhaarNumber != null ?   Text(
                        "Aadhaar No. : " +"  " +
                            widget.nomineeDetailsList![index].aadhaarNumber
                                .toString(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text("Aadhaar No. : ", style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      )),
                      SizedBox(height: AppDigits.size,),
                      widget.nomineeDetailsList![index].relationship != null ?
                      Text(
                        "Relation : " +"  " +
                            widget.nomineeDetailsList![index].relationship!.relationShip,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text("Relation : ", style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      )),
                      SizedBox(height: AppDigits.size,),
                      widget.nomineeDetailsList![index].dob != null ?
                      Text(
                        "DOB : " +"  " +
                            DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.nomineeDetailsList![index].dob).toUtc()),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),

                         ):Text("DOB : ", style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      ),),
                      SizedBox(height: AppDigits.size,),
                      Text(
                        "Address : " +"  " +
                            widget.nomineeDetailsList![index].address,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ),
                      SizedBox(height: AppDigits.size,),
                      Text(
                        "Share in % : " +"  " +
                            widget.nomineeDetailsList![index].shareAmount.toString(),
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ),
                      SizedBox(height: AppDigits.size,),
                      widget.nomineeDetailsList![index].nomBankName != null ?
                      Text(
                        "Bank name : " +"  " +
                            widget.nomineeDetailsList![index].nomBankName!.bankName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text(  "Bank name : " ,style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      )),
                      SizedBox(height: AppDigits.size,),
                      widget.nomineeDetailsList![index].nomBranchName != null ?
                      Text(
                        "Branch name : " +"  " +
                            widget.nomineeDetailsList![index].nomBranchName,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text( "Branch name : ",   style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      )),
                      SizedBox(height: AppDigits.size,),
                      widget.nomineeDetailsList![index].nomIfscCode != null ?
                      Text(
                        "IFSC : " +"  " +
                            widget.nomineeDetailsList![index].nomIfscCode,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text("IFSC : ",   style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      )),
                      SizedBox(height: AppDigits.size,),
                      widget.nomineeDetailsList![index].nomAccNo != null ?
                      Text(
                        "Account no : " +"  " +
                            widget.nomineeDetailsList![index].nomAccNo,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text( "Account no : ", style: TextStyle(
                        color: Colors.black87,
                        fontSize: AppDigits.fontSize,
                      )),
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
  Future<void> navigateToDeleteNomineeDetailsList(int? id) async {
    FilterVO registrationFilterVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    registrationFilterVo.workerNomineeId = id;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registrationFilterVo);
    var response = await Api.deleteWorkerNominee(encodedData, headers);
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
}
}
