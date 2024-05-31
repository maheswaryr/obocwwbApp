///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';


class MyCustomDropdown {
  // Initial Selected Value
  String dropdownValue = '--Select--';

  // List of items in our dropdown menu
  var items = [
    '--Select--',
    'Male',
    'Female',
    'Other',
  ];

  dropDown(String text) {
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
                  MyCustomText().textWithPadding(text, Colors.black),
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
                onChanged: (String? newValue) {
                  dropdownValue = newValue!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dropDownColumn(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyCustomText().textWithPadding_2(text, Colors.black),
                MyCustomText().textWithoutPadding("*", Colors.red),
              ],
            ),
            DropdownButton(
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
              onChanged: (String? newValue) {
                dropdownValue = newValue!;
              },
            ),
          ],
        ),
      ),
    );
  }

  dropDownModified(String hintText, List strList, var strdropdownValue) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
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
                  MyCustomText().textWithoutPadding(hintText, Colors.black),
                  MyCustomText().textWithoutPadding("*", Colors.red),
                ],
              ),
            ),
            Expanded(
              child: DropdownButton(
                underline: SizedBox(),
                // Initial Value
                value: strdropdownValue,
                hint: Text(
                  'Select',
                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black54),
                ),
                // Down Arrow Icon
                icon: const Icon(Icons.keyboard_arrow_down),
                isExpanded: true,
                // Array list of items
                items: strList.map((var items) {
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
                onChanged: (var newValue) {
                  newValue = strdropdownValue;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  dropDownColumnModified(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MyCustomText().textWithPadding_2(text, Colors.black),
                MyCustomText().textWithoutPadding("*", Colors.red),
              ],
            ),
            DropdownButton(
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
              onChanged: (String? newValue) {
                dropdownValue = newValue!;
              },
            ),
          ],
        ),
      ),
    );
  }
}
