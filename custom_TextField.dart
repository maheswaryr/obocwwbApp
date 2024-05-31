///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../constants.dart';
import 'package:intl/intl.dart';
import 'custom_common_class/always_disabled_focus_node.dart';

class MyCustomTextField {
  String regExp = "^[A-Z]{4}[0][A-Z0-9]{6}\$";

  textWithTextFieldForAadharNumber(TextInputType text, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextFieldForMobileNumber(
    TextInputType text,
    String hintText,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: pinCodeValidateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
  textWithTextFieldForAccountMobileNumber(
      TextInputType text,
      String hintText,
      TextEditingController controllerText, bool readOnlyMode
      ) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        readOnly: readOnlyMode,
        controller: controllerText,
        validator: pinCodeValidateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(14),
        ],
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),

        ),
      ),
    );
  }
  textWithTextField(TextInputType text, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextFieldWithoutImpMark(TextInputType text, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  readOnlyTextWithoutImpMark(
      TextInputType text, String hintText, String controllerText) {
    TextEditingController textController = new TextEditingController();
    textController.text = controllerText;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ...... ';
          }
          return null;
        },
        controller: textController,
        readOnly: true,
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
              color: AppColor.blackColor, fontSize: AppDigits.titleSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  readOnlyTextWithoutImpMarkForProfile(
      TextInputType text, String hintText, String controllerText) {
    TextEditingController textController = new TextEditingController();
    textController.text = controllerText;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ...... ';
          }
          return null;
        },
        controller: textController,
        readOnly: true,
        keyboardType: text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  readOnlyText(TextInputType text, String hintText, String controllerText) {
    TextEditingController textController = new TextEditingController();
    textController.text = controllerText;

    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ...... ';
          }
          return null;
        },
        controller: textController,
        readOnly: true,
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
              color: AppColor.blackColor, fontSize: AppDigits.titleSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithSuffix(TextInputType text, String hintText) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: text,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.file_upload,
              color: AppColor.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  //for selecting date
  DateTime? _selectedDate;
  DateTime? _selectedDateNew;

  _selectDateNew(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate:
          _selectedDateNew != null ? _selectedDateNew! : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
      // currentDate: _selectedDate,
    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');
    if (newSelectedDate != null &&
        DateTime.now().difference(newSelectedDate) < Duration(days: 0)) {
      EasyLoading.showError('You should be 18 years old to register');
    } else {
      _selectedDateNew = newSelectedDate;
      _textController
        ..text = formatDate.format(_selectedDateNew!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
  _selectDateNoValidation(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
      // currentDate: _selectedDate,
    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');
    if (newSelectedDate != null ) {
      _selectedDate = newSelectedDate;
      _textController
        ..text = formatDate.format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
     /* EasyLoading.showError('You should be 18 years old to register');*/
    } else {
     /* _selectedDate = newSelectedDate;
      _textController
        ..text = formatDate.format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));*/
    }
  }
  _selectDate(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
      // currentDate: _selectedDate,
    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');
    if (newSelectedDate != null &&
        DateTime.now().difference(newSelectedDate) < Duration(days: 6570)) {
      EasyLoading.showError('You should be 18 years old to register');
    } else {
      _selectedDate = newSelectedDate;
      _textController
        ..text = formatDate.format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectDateMinAndMax(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
      // currentDate: _selectedDate,
    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');
    if (newSelectedDate != null &&
        DateTime.now().difference(newSelectedDate) < Duration(days: 6570)) {
      EasyLoading.showError('You should be 18 years old to register');
    }
    else if(newSelectedDate != null &&   DateTime.now().difference(newSelectedDate) > Duration(days: 21900)) {
      EasyLoading.showError('Max Age limit is 60 years');
    }
    else {
      _selectedDate = newSelectedDate;
      _textController
        ..text = formatDate.format(_selectedDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectDateDeathBenefit(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate! : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2040),
    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');
    _selectedDate = newSelectedDate;
    _textController
      ..text = formatDate.format(_selectedDate!)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: _textController.text.length,
          affinity: TextAffinity.upstream));
  }

  //for selecting date
  DateTime? _selectedOneYearDiffDate;

  _selectDiffDate(
      BuildContext context, TextEditingController _textController) async {
  /*  DateTime today = DateTime.now();
    var fiftyDaysFromNow = today.subtract(const Duration(days: 50));*/
    DateTime? newSelectedOneYearDiffDate = await showDatePicker(
      context: context,
      initialDate: _selectedOneYearDiffDate != null
          ? _selectedOneYearDiffDate!
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),

    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');

    if (newSelectedOneYearDiffDate != null &&
        DateTime.now().difference(newSelectedOneYearDiffDate).inDays == 365) {
      EasyLoading.showError('Only 90 Days Difference');
    } else {
      _selectedOneYearDiffDate = newSelectedOneYearDiffDate;
      _textController
        ..text = formatDate.format(_selectedOneYearDiffDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectCurrentDate(
      BuildContext context, TextEditingController _textController) async {
    DateTime? newSelectedOneYearDiffDate = await showDatePicker(
      context: context,
      initialDate: _selectedOneYearDiffDate != null
          ? _selectedOneYearDiffDate!
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    DateFormat formatDate = DateFormat('yyyy-MM-dd');
    if (newSelectedOneYearDiffDate != null &&
        DateTime.now().difference(newSelectedOneYearDiffDate).inDays <= 90) {
      EasyLoading.showError('Only 90 Days Difference');
    } else {
      _selectedOneYearDiffDate = newSelectedOneYearDiffDate;
      _textController
        ..text = formatDate.format(_selectedOneYearDiffDate!)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  textWithTextControllerDateTextFieldForProfile(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode,
      bool status,
      bool autoStatus) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        enabled: status,
        autofocus: autoStatus,
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        onTap: () {
          _selectDate(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerDateTextFieldForProfileGen(
      BuildContext context,
      String hidedText,
      String hintText,
      String textEditingController1,
      TextEditingController _textController,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        autofocus: outStatus,
        enabled: status,
        onTap: () {
          _selectDate(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hidedText,
          hintText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerDateTextFieldDeathBenefit(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDateDeathBenefit(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerDateTextFieldNoConditions(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDateNew(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerDateTextField(BuildContext context, String hintText,
      TextEditingController _textController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDate(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize /*AppDigits.fontSize*/,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerDateTextFieldWithoutAsterisks(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid date of birth";
          } else {
            return null;
          }
        },
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDate(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
  textWithTextControllerDateTextFieldWithoutAsterisksNoValidation(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid date of birth";
          } else {
            return null;
          }
        },
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDateNoValidation(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
  textWithTextControllerDateTextFieldWithoutAsterisksMInMax(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid date of birth";
          } else {
            return null;
          }
        },
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDateMinAndMax(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration( suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.star,
            size: 9.0,
            color: Colors.red,
          ),
        ),

          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerDateTextFieldOneDiff(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid date of birth";
          } else {
            return null;
          }
        },
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectDiffDate(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerDateCurrentTextFieldOneYearDiff(
      BuildContext context,
      String hintText,
      TextEditingController _textController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid date of birth";
          } else {
            return null;
          }
        },
        focusNode: AlwaysDisabledFocusNode(),
        controller: _textController,
        readOnly: readOnlyMode,
        onTap: () {
          _selectCurrentDate(context, _textController);
        },
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithNumberControllerTextField(TextInputType number, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: number,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldNumberCommon(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldCommonForProfileAccountNumberNominee(
      TextInputType text,
      String hintText,
      String hidedText,
      String? textEditingController1,
      TextEditingController textEditingController /* bool readOnlyMode*/) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: TextFormField(
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(14),
        ],
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hidedText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldCommonForProfileAccountNumber(
      TextInputType text,
      String hintText,
      String hidedText,
      String? textEditingController1,
      TextEditingController textEditingController,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: TextFormField(
        enabled: status,
        autofocus: outStatus,
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
        ],
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hidedText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldCommonForProfileIfsc(
      TextInputType text,
      String hintText,
      String hidedText,
      String? textEditingController1,
      TextEditingController textEditingController /* bool readOnlyMode*/,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: TextFormField(
        enabled: status,
        autofocus: outStatus,
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
        ],
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hidedText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldPhoneNumberCommonForProfile(
      TextInputType text,
      String hintText,
      String hidedText,
      String? textEditingController1,
      TextEditingController textEditingController /* bool readOnlyMode*/,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: TextFormField(
        enabled: status,
        autofocus: outStatus,
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hidedText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldPhoneNumberCommon(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldAccountNumberForProfile(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        enabled: status,
        autofocus: outStatus,
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldAadharNumberForProfile(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        enabled: status,
        autofocus: outStatus,
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldAccount(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: validateName,
        /*  maxLength: 12,*/
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
        ],
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldAadharNumber(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        validator: validateName,
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize /*AppDigits.fontSize*/,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextField(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle: TextStyle(
              color: AppColor.blackColor, fontSize: AppDigits.titleSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldNoImp(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle: TextStyle(
              color: AppColor.blackColor, fontSize: AppDigits.titleSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerForPayment(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldForEditingProfile(
      TextInputType text,
      String hintText,
      String hidedText,
      String textEditingController1,
      TextEditingController textEditingController /*bool readOnlyMode*/,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: TextFormField(
        keyboardType: text,
        enabled: status,
        autofocus: outStatus,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          labelText: hidedText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldImpMarkForProfile(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode,
      bool status,
      bool outStatus) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        enabled: status,
        autofocus: outStatus,
        keyboardType: text,
        controller: textEditingController,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldNewWithoutImpMark(
      TextInputType text,
      String hintText,
      var errorText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length == 0) {
            return "Field can\'t be empty";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          errorText: errorText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldWithoutImpMark(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")), ],

        validator: (value) {
          if (value!.length == 0) {
            return "Field can\'t be empty";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldDurationInMonth(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode){
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
      /*  textCapitalization: TextCapitalization.sentences,*/
        autovalidateMode: AutovalidateMode.onUserInteraction,
      /*  inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("{0-9 } ")), ],*/

     /*   validator: (value) {
          if (*//*value!.length*//*value!.isEmpty == 0) {
            return "Field can\'t be empty";
          } else {
            return null;
          }
        },*/
  validator: (value) {
  if (value!.isEmpty) {
  return "Field can\'t be empty";
  }
  return null;
  },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldWithoutImpMarkNe(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")), ],

        validator: (value) {
          if (value!.length == 0) {
            return "Field can\'t be empty";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(

          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
  textWithTextControllerTextFieldWithoutImpMarkNew(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      /*  inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("^[a-z A-Z ''][0][0-9]")), ],*/

        validator: (value) {
          if (value!.length == 0) {
            return "Field can\'t be empty";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
  textWithTextControllerTextFieldOnlyText(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-z A-Z '' ]")), ],

        validator: (value) {
          if (value!.length == 0) {
            return "Field can\'t be empty";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }


  textWithMobileNumValidationTextFieldWithoutImpMark(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        validator: (value) {
          if (value!.isEmpty || !RegExp("^[1-9][0-9]{9}\$").hasMatch(value)) {
            return "Enter valid Mobile Number";
          } else {
            return null;
          }
        },
        inputFormatters: [LengthLimitingTextInputFormatter(10)],
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerTextFieldWithoutImpMarkIfsc(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp("^[A-Z]{4}[0][0-9]{6}\$").hasMatch(value)) {
            return "Enter valid Ifsc code";
          } else {
            return null;
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(11),
          UpperCaseTextFormatter()
        ],
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          /*contentPadding: EdgeInsets.all(12.0),*/
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  String? validateName(String? value) {
    if (value?.length != 12) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }


  String? ifscValidate(String? ifsc) {
    bool? isValid = false;
    if (ifsc?.length != 12) {
      isValid = ifsc?.allMatches(regExp) as bool?;
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  String? pinCodeValidateName(String? value) {
    if (value?.length == 6) {
      return 'Pin code must be of 10 digit';
    } else {
      return null;
    }
  }

  textWithTextControllerAadhaarNewWithoutImpMark(
      TextInputType text,
      String hintText,
      var errorText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length == 0 && value.length < 12) {
            return 'Aadhaar number must be 12-digit';
          } else {
            return null;
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          errorText: errorText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerAadhaarWithoutImpMark(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length == 0 && value.length < 12) {
            return 'Aadhaar number must be 12-digit';
          } else {
            return null;
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
  textWithTextControllerAadhaarImpMark(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.length == 0 && value.length < 12) {
            return 'Aadhaar number must be 12-digit';
          } else {
            return null;
          }
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(12),
        ],
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
  suffixIcon: IconButton(
  onPressed: () {},
  icon: Icon(
  // Based on passwordVisible state choose the icon
  Icons.star,
  size: 9.0,
  color: Colors.red,
  ),
  ),
          labelText: hintText,
          labelStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
          TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
          TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }
  textWithTextControllerShareInPercentageWithoutImpMark(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid value";
          }
          return null;
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithTextControllerAccountNumberWithoutImpMark(
      TextInputType text,
      String hintText,
      TextEditingController textEditingController,
      bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty) {
            return "Enter valid account number";
          }
          return null;
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
        ),
      ),
    );
  }

  textWithMobileNumberControllerTextField(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty || !RegExp("^[1-9][0-9]{9}\$").hasMatch(value)) {
            return "Enter valid Mobile Number";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithAadharNumberControllerTextField(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty || !RegExp("^[1-9][0-9]{11}\$").hasMatch(value)) {
            return "Enter valid Aadhaar Number";
          } else {
            return null;
          }
        },
        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }

  textWithPinCodeControllerTextField(TextInputType text, String hintText,
      TextEditingController textEditingController, bool readOnlyMode) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
              inputFormatters: <TextInputFormatter>[
                LengthLimitingTextInputFormatter(6),
          FilteringTextInputFormatter.digitsOnly
        ],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value!.isEmpty || !RegExp("^[1-9][0-9]{5}\$").hasMatch(value)) {
            return "Enter valid pin code";
          } else {
            return null;
          }
        },

        keyboardType: text,
        controller: textEditingController,
        readOnly: readOnlyMode,
        style: TextStyle(
          fontSize: AppDigits.fontSize,
          fontWeight: FontWeight.w400,
        ),
        decoration: InputDecoration(
          labelText: hintText,
          labelStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          errorStyle:
              TextStyle(color: Colors.redAccent, fontSize: AppDigits.fontSize),
          helperStyle:
              TextStyle(color: Colors.black, fontSize: AppDigits.fontSize),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black12),
              borderRadius: BorderRadius.circular(0)),
          suffixIcon: IconButton(
            onPressed: () {},
            icon: Icon(
              // Based on passwordVisible state choose the icon
              Icons.star,
              size: 9.0,
              color: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
