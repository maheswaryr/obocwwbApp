///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';
import 'custom_text.dart';



class CustomDropDownWidgetForProfile extends StatefulWidget {
 final String? text;
 final String? chooseValue;
 final List? myList;
 final ValueChanged? onChanged;



  CustomDropDownWidgetForProfile(
      {
        this.text,
        this.chooseValue,
        this.myList,
        this.onChanged,

      });
  @override
  _CustomDropDownWidgetForProfileState createState() => _CustomDropDownWidgetForProfileState();
}

class _CustomDropDownWidgetForProfileState extends State<CustomDropDownWidgetForProfile> {

  late bool status;
  late bool outStatus;




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, ),
      child: Container(

        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: MyCustomText().textWithPadding(
                        widget.text.toString(), Colors.black),
                  ),

                ],
              ),
            ),
            Expanded(
              child: DropdownButton(
                underline: SizedBox(),
                value: widget.chooseValue.toString() == "null"
                    ? null
                    : widget.chooseValue.toString(),
                hint: Text("Select",style: TextStyle(fontSize: AppDigits.fontSize),),
                isExpanded: true,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Icon(Icons.arrow_drop_down),
                ),
                items: widget.myList!.map((valueItems) {
                  return DropdownMenuItem(
                    value: valueItems.value.toString(),
                    child: Text(valueItems.dropdownValue.toString(),style: TextStyle(fontSize: AppDigits.fontSize),),
                  );
                }).toList(),
                onChanged: widget.onChanged,

              ),
            ),
          ],
        ),
      ),
    );
  }
}
