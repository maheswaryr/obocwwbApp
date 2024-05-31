///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));


}

// I will explain it later

  String emailError = 'Enter a valid email address';
  String requiredField = "This field is required";

  final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: 'password is required'),
      MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'passwords must have at least one special character')
    ],
  );


class AppColor {
  static Color textColor = Color(0xFF35364F);
  static Color backgroundColor = Color(0xFFE6EFF9);
  static Color redColor = Color(0xFFE85050);
  static Color primaryColor = HexColor("#105e55");
  static Color blackColor = Color(0xff3d3d3d);
  Color blue = HexColor("#01458e");
  Color black = HexColor("#313131");
}

class AppDigits {
  static double defaultPadding = 16.0;
  static double fontSize = 12.0;

  static double titleSize = 14.0;
  static double welcomeFont = 20;
  static double size = 10.0;
  static double largeSize = 100.0;
}




