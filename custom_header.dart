///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';

import '../constants.dart';

class MyCustomHeader {
  headerCard(String headerText) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(headerText,
                style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: AppDigits.titleSize,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                )),
            Divider(
              color: AppColor.primaryColor.withOpacity(0.9),
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }

  subHeaderCard(String headerText) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(headerText,
            style: TextStyle(
                color: AppColor.primaryColor,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  headerCenterCard(String headerText) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(headerText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            )),
      ),
    );
  }

}
