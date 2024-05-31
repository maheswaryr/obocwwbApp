///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';


class CustomRadioButtonn extends StatefulWidget {
  const CustomRadioButtonn({Key? key}) : super(key: key);

  @override
  State<CustomRadioButtonn> createState() => _CustomRadioButtonnState();
}

class _CustomRadioButtonnState extends State<CustomRadioButtonn> {
  int _groupValue = 1;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Column(
          children: [
            //Whether the applicant is a nominee of the deceased registered construction worker for whose death the funeral assistance is sought ?
            Row(
              children: [
                Expanded(
                    child: MyCustomText().textWithPadding(
                        "StringsEn().areYouARegisteredConstructionWorker",
                        Colors.black)),
                MyCustomText()
                    .textWithoutPadding("*", Colors.red),
              ],
            ),
            //Radio Button [Yes/No]
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomRadioButton(
                    text: "Yes",
                    value: 1,
                    groupValue: _groupValue,
                    onChanged: (newValue)  => setState(
                            ()=>_groupValue = newValue
                    ),
                  )
                ),
                Expanded(
                  child: CustomRadioButton(
                    text: "No",
                    value: 2,
                    groupValue: _groupValue,
                    onChanged: (newValue)=>setState(
                            ()=>_groupValue = newValue
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
