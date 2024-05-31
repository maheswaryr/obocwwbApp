///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/details_of_the_establishment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;

class EstablishmentListWidget extends StatefulWidget {
 final List? establishmentDetailsList;
  EstablishmentListWidget({
     this.establishmentDetailsList,
  });

  @override
  EstablishmentListWidgetState createState() =>
      EstablishmentListWidgetState();
}

class EstablishmentListWidgetState
    extends State<EstablishmentListWidget> {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.establishmentDetailsList!.length,
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                        Text((1+index).toString()+". "),
                                  Text(
                                      widget.establishmentDetailsList![index].name.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500)),
                                  Text(
                                        widget.establishmentDetailsList![index]
                                            .govtOrPrivate == "P" ? " (Private Sector)" : " (Govt. Sector)",
                                    style: TextStyle(
                                        fontSize: 12),
                                  ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      navigateToDeleteEstablishment(widget.establishmentDetailsList![index].id!);
                                    },
                                      child: Icon(Icons.delete,color: Colors.red,))

                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //aadhaar Number, Acc no
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [ widget
                        .establishmentDetailsList![index].establishmentState != null ?
                              Text(
                                "State: " + "   "+
                                    widget
                                        .establishmentDetailsList![index].establishmentState!.stateName
                                        .toString(),
                                style: TextStyle(
                                    fontSize: AppDigits.fontSize),
                              ) : Text("State: " + "   ", style: TextStyle(
                        fontSize: AppDigits.fontSize)),
                      SizedBox(height: AppDigits.size,),
                      widget.establishmentDetailsList![index].establishmentDistrict != null ? 
                      Text(
                        "District: " +"   "+
                            widget.establishmentDetailsList![index].establishmentDistrict!.districtName! ,
                        style: TextStyle(
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text("District: " +"   ", style: TextStyle(
                          fontSize: AppDigits.fontSize)),
                      SizedBox(height: AppDigits.size,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Contact No: " +"   "+
                                  widget
                                      .establishmentDetailsList![index].contactNumber!
                                      .toString(),
                              style: TextStyle(
                                  fontSize: AppDigits.fontSize),
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: AppDigits.size,),
                      Text(
                        "Reg. No.: " +"   "+
                            widget.establishmentDetailsList![index].registrationNumber!,
                        style: TextStyle(
                          fontSize: AppDigits.fontSize,
                        ),
                      ),
                      SizedBox(height: AppDigits.size,),
                      widget.establishmentDetailsList![index].establishmentAddress != null ?
                      Text(
                        "Establishment's address: " +"   "+
                            widget.establishmentDetailsList![index].establishmentAddress!,
                        style: TextStyle(
                          fontSize: AppDigits.fontSize,
                        ),
                      ):Text( "Establishment's address: " +"   ", style: TextStyle(
                          fontSize: AppDigits.fontSize)),
                      SizedBox(height: AppDigits.size,),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Period: " +"   "+
                                  formatter.format(DateTime.parse(widget.establishmentDetailsList![index].durationFrom)) + " to " +
                                  formatter.format(DateTime.parse(widget.establishmentDetailsList![index].durationTo)),
                              style: TextStyle(
                                fontSize: AppDigits.fontSize,
                              ),
                            ),
                          ),
                        ],
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

  Future<void> navigateToDeleteEstablishment(int? id) async {
    FilterVO registrationFilterVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    registrationFilterVo.workerEstablishmentId = id;

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registrationFilterVo);
    var response = await Api.deleteWorkerEstablishment(encodedData, headers);

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
                builder: (context) => DetailsOfTheEstablishment()));
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
