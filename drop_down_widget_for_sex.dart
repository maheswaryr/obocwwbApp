///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';


class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key}) : super(key: key);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  // Initial Selected Value
  String dropdownValue = '--Select--';

  // List of items in our dropdown menu
  var items = [
    '--Select--',
    'Male',
    'Female',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( bottom: 5.0),
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
                  MyCustomText().textWithPadding('Sex', Colors.black),
                  MyCustomText().textWithoutPadding("*", Colors.red),
                ],
              ),
            ),
            Expanded(
              child: DropdownButton(
                underline: SizedBox(),
                // Initial Value
                value: dropdownValue,
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                // Array list of items
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(items),
                    ),
                  );
                }).toList(),
                // After selecting the desired option,it will
                // change button value to selected value
                onChanged: (String? newValue) =>setState(
                    ()=>dropdownValue = newValue!
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
