///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';

import 'custom_checkBox/custom_checkBox.dart';

class CustomNomineeDetailsWidget extends StatefulWidget {

final  List? nomineeDetailsListNew;

  CustomNomineeDetailsWidget({
    this.nomineeDetailsListNew,

  });

  @override
  _CustomNomineeDetailsWidgetState createState() =>
      _CustomNomineeDetailsWidgetState();
}

class _CustomNomineeDetailsWidgetState
    extends State<CustomNomineeDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: widget.nomineeDetailsListNew!.length,

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
                                  widget.nomineeDetailsListNew![index].name!
                                      .toUpperCase() +
                                      ". ",
                                  style: TextStyle(
                                      fontSize: AppDigits.titleSize/*20*/,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black)),
                              Text(
                                "( Relationship- " +
                                    widget.nomineeDetailsListNew![index]
                                        .relationship!.relationShip.toString() +
                                    " )",
                                //widget.nomineeDetailsList![index].relationship!.relationShip.toString(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: AppDigits.fontSize/*10*/,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.italic),
                              ),
                              Text(
                                "DoB: " +
                                    widget.nomineeDetailsListNew![index].dobToString
                                        .toString(),
                                style: TextStyle(
                                    fontSize: AppDigits.fontSize,
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
                                  widget.nomineeDetailsListNew![index].shareAmount
                                      .toString() +
                                      "%",
                                  style: TextStyle(
                                      fontSize:AppDigits.fontSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Text(
                              "Share in %",
                              style: TextStyle(
                                  fontSize: AppDigits.fontSize,
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
                              widget.nomineeDetailsListNew![index].aadhaarNumber!
                                  .toString(),
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: AppDigits.fontSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Acc No.- " +
                                widget.nomineeDetailsListNew![index].nomAccNo
                                    .toString(),
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize:AppDigits.fontSize /*12*/,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Address
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 5, bottom: 5),
                  child: Text(
                    "Address.- " +
                        widget.nomineeDetailsListNew![index].address!.toString(),
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: AppDigits.fontSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                //checkbox it not alive
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.black26),
                    ),
                  ),
                  child: LabeledCheckbox(
                    label: "Check if not alive.",

                    value: widget.nomineeDetailsListNew![index].isSelectedAlive,
                    mainAxisAlignment: MainAxisAlignment.start,
                    fontSize:AppDigits.titleSize,
                    onChanged: (newValue) {
                      setState(() {

                        widget.nomineeDetailsListNew![index].isSelectedAlive = !widget.nomineeDetailsListNew![index].isSelectedAlive;

                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
