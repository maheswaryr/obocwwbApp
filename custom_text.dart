///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/strings_en.dart';


class MyCustomText {

  textWithPadding(String text, Color colors) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 10.0),
      child: Text(text,
          style: TextStyle(
              fontSize: AppDigits.fontSize, fontWeight: FontWeight.w500, color: colors)),
    );
  }

  customTextWithPadding(String text, Color colors) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 5.0, right: 10.0),
      child: Text(text,
          style: TextStyle(
              fontSize: AppDigits.fontSize, fontWeight: FontWeight.w500, color: AppColor.primaryColor)),
    );
  }

  textWithPadding_2(String text, Color colors) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 8.0, top: 5.0, bottom: 5.0, right: 10.0),
      child: Text(text,
          style: TextStyle(
              fontSize: AppDigits.fontSize, fontWeight: FontWeight.w500, color: colors)),
    );
  }

  textWithTopAndLeftPadding(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 10),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black, fontSize: AppDigits.fontSize, fontWeight: FontWeight.w800),
      ),
    );
  }

  textWithoutPadding(String text, Color colors) {
    return Padding(
      padding: const EdgeInsets.only(/*left: 7, top: 5.0, */bottom: 5.0, right: 19.0),
      child: Text(
        text,
        style:
            TextStyle(fontSize: AppDigits.fontSize, fontWeight: FontWeight.w500, color: colors),
      ),
    );
  }

  textWithoutFontWeight(String text, Color colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_box_outline_blank, color: Colors.black, size: 16.0),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15.0, bottom: 5.0, right: 10.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: AppDigits.titleSize, fontWeight: FontWeight.normal, color: colors),
            ),
          ),
        ),
      ],
    );
  }

  textDeclaration(String text, String noText, Color colors) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            noText,
            style: TextStyle(
                fontSize: AppDigits.titleSize, fontWeight: FontWeight.w500, color: colors),
          ),
          SizedBox(width: 5.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: AppDigits.titleSize, fontWeight: FontWeight.w400, color: colors),
            ),
          ),
        ],
      ),
    );
  }

  textAddress(String text, Color colors) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.check_box_outline_blank, color: Colors.black, size: 13.0),
        Padding(
          padding: const EdgeInsets.only(left: 2.0, bottom: 5.0, right: 15.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: AppDigits.fontSize, fontWeight: FontWeight.normal, color: colors),
          ),
        ),
      ],
    );
  }

  textSupportingDocuments(String text /*, ValueChanged? onChanged*/) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 5.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: MyCustomText()
                          .textWithPadding(text, Colors.black)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {

              },
              icon: Icon(
                // Based on passwordVisible state choose the icon
                Icons.file_upload,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  textInformation() {
    return Padding(
      padding: EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        top: 5.0,
        bottom: 5.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            StringsEn().note,
            style: TextStyle(
                fontSize: AppDigits.fontSize,
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  textInformationSupportingDocument() {
    return Padding(
        padding: EdgeInsets.only(
          left: 10.0,
          right: 10.0,
          top: 5.0,
          bottom: 5.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              StringsEn().imageFormat,
              style: TextStyle(
                  fontSize:AppDigits.fontSize,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ));
  }

  textSelectNominee(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 5.0, right: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.black12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: MyCustomText()
                          .textWithPadding(text, Colors.black)),
                ],
              ),
            ),
            IconButton(
              onPressed: () {

              },
              icon: Icon(
                // Based on passwordVisible state choose the icon
                Icons.file_upload,
                color: AppColor.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  alertDialogBox(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text(StringsEn().somethingWentWrong),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  alertDialogBox1(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text(StringsEn().sessionTimedOut),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  alertDialogBox2(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text(StringsEn().noInternetConnection),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  alertDialogBoxSessionTimeOut(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text(StringsEn().sessionTimedOut),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                ),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  alertLangBox(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Apply Language Changes'),
            content: Text('This app will restart with the selected language'),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'CANCEL',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
