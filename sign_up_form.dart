///Updated on 19/12/2022 by Arsha

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/otp.dart';

import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_dropdown/custom_dropdown_widget.dart';
import 'package:obocwwb/custom_widgets/custom_items/custom_text_with_text_fields.dart';
import 'package:obocwwb/custom_widgets/custom_list.dart';
import 'package:obocwwb/custom_widgets/custom_radio_button/custom_radio_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';

import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/strings_en.dart';
import 'dart:convert' as convert;
import '../../constants.dart';
import '../../model/application_detail_vo.dart';
import '../../obocwwb_ui/home/button_form.dart';

class SignUpForm extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  SignUpForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  String? typeOfGenderChoose;
  List<DropDownVO> typeOfGenderList = MyCustomList().sexList;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController registrationNumController = TextEditingController();
  OneTimeRegistration /*RegistrationVO*/ saveOtr =
      OneTimeRegistration /*RegistrationVO*/ ();
  int _groupValue = 1;
  var _validate = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1. FirstName
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: CustomItems().textWithTextBox(
                      'First Name',
                      TextInputType.text,
                      _validate ? 'Firstname can\'t be empty' : null,
                      firstNameController),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: CustomItems().textWithTextBox(
                      'Surname',
                      TextInputType.text,
                      _validate ? 'Surname can\'t be empty' : null,
                      surnameController),
                ),

                CustomItems().customText('Sex'),
                CustomDropDownWidget(
                  text: "Sex",
                  chooseValue: typeOfGenderChoose,
                  myList: typeOfGenderList,
                  onChanged: (newValue) =>
                      setState(() => typeOfGenderChoose = newValue),
                ),
                //4. Aadhaar Number Linked Mobile Number

                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          "Mobile number",
                          style: TextStyle(
                            fontSize: AppDigits.fontSize,
                          ),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(
                          fontSize: AppDigits.fontSize,
                        ),
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp("^[1-9][0-9]{9}\$").hasMatch(value)) {
                            return "Enter valid mobile number";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          /*  errorText: (mobileNoController.text.isEmpty || !RegExp("^[1-9][0-9]{9}\$").hasMatch(mobileNoController.text)) ?
        "Enter valid Mobile Number"
            :
        null,*/

                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          prefix: SizedBox(
                            width: 50,
                            child: Center(
                              child: Text(
                                "+91",
                                style: TextStyle(fontSize: AppDigits.fontSize),
                              ),
                            ),
                          ),
                        ),
                        controller: mobileNoController,
                      ),
                    ],
                  ), /* CustomItems().textWithPhoneNumber('Mobile Number',  TextInputType.number,
    (mobileNoController.text.isEmpty || !RegExp("^[1-9][0-9]{9}\$").hasMatch(mobileNoController.text)) ?
    "Enter valid Mobile Number"
        :
    null,  '+91', mobileNoController)*/
                ),

                SizedBox(
                  height: AppDigits.size,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        border: Border.all(color: Colors.black12)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: MyCustomText().textWithPadding(
                                    StringsEn()
                                        .areYouARegisteredConstructionWorker,
                                    Colors.black)),
                            MyCustomText().textWithoutPadding("*", Colors.red),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomRadioButton(
                                text: "Yes",
                                value: 2,
                                groupValue: _groupValue,
                                onChanged: (newValue) =>
                                    setState(() => _groupValue = newValue),
                              ),
                            ),
                            Expanded(
                              child: CustomRadioButton(
                                text: "No",
                                value: 1,
                                groupValue: _groupValue,
                                onChanged: (newValue) =>
                                    setState(() => _groupValue = newValue),
                              ),
                            ),
                          ],
                        ),
                        _groupValue == 2
                            ? Column(
                                children: [
                                  MyCustomTextField()
                                      .textWithTextControllerTextField(
                                          TextInputType.text,
                                          StringsEn().registrationNumber,
                                          registrationNumController,
                                          false),
                                  SizedBox(
                                    height: AppDigits.size,
                                  )
                                ],
                              )
                            : Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: AppDigits.size,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        firstNameController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        surnameController.text.isEmpty
                            ? _validate = true
                            : _validate = false;

                        mobileNoController.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                      });

                      if (firstNameController.text != "" &&
                          surnameController.text != "" &&
                          mobileNoController.text.length == 10 &&
                          typeOfGenderChoose != "") {
                        saveOneTimeRegistration();
                      } else if (mobileNoController.text.isEmpty ||
                          !RegExp("^[1-9][0-9]{9}\$")
                              .hasMatch(mobileNoController.text)) {
                        Fluttertoast.showToast(
                          msg: "Please check the mobile number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: "Make sure all the mandatory fields are filled?",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                        );
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Proceed',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: AppDigits.defaultPadding,
          ),
        ],
      ),
    );
  }

  String? validateName(String? value) {
    if (value?.length != 11) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  void navigateToWelcomePage(BuildContext context) async {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => WelcomePage())));
  }

  void saveOneTimeRegistration() async {
    OneTimeRegistration oneTimeRegistration = OneTimeRegistration();
    oneTimeRegistration.firstName = firstNameController.text;
    oneTimeRegistration.lastName = surnameController.text;
    oneTimeRegistration.mobileNo = mobileNoController.text;
    oneTimeRegistration.gender = typeOfGenderChoose;
    oneTimeRegistration.alreadyRegistred = "N";
    String encodeData = convert.jsonEncode(oneTimeRegistration);
    Map<String, String> headers = {'content-type': 'application/json'};
    var response = await Api.saveOneTimeRegistration(encodeData, headers);
    if (response.statusCode == 200) {
      if (response != null) {
        saveOtr = OneTimeRegistration /*RegistrationVO*/ .fromJson(
            convert.jsonDecode(response.body));

        setState(() {
          /* oneTimeRegistration.firstName = saveOtr.workerFirstName.toString();
              oneTimeRegistration.lastName = saveOtr.workerLastName.toString();
              oneTimeRegistration.lastName = saveOtr.mobileNumber.toString();
              oneTimeRegistration.gender = saveOtr.gender.toString();*/
        });
        if (saveOtr != null) {
          setState(() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => Otp(saveOtr: saveOtr)));
          });
        }
      }
    } else {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueGrey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}

class TextFieldName extends StatelessWidget {
  const TextFieldName({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppDigits.defaultPadding / 3),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
      ),
    );
  }
}
