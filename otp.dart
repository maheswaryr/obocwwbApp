///Updated on 19/12/2022 by Arsha

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_items/custom_text_with_text_fields.dart';
import 'package:obocwwb/custom_widgets/custom_list.dart';

import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/model/common_Models/obocwwb_ui_Models/dropdown_common_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/application_details.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class Otp extends StatefulWidget {
 final ApplicationDetailVo initiate = ApplicationDetailVo();
 final OneTimeRegistration saveOtr;

  Otp({Key? key,required this.saveOtr,});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  OneTimeRegistration otrResponse = OneTimeRegistration();
  String? typeOfGenderChoose;
  List<DropDownVO>?typeOfGenderList=MyCustomList().sexList.cast<DropDownVO>();
  TextEditingController firstNameController=TextEditingController();
  TextEditingController surnameController=TextEditingController();
  TextEditingController mobileNoController=TextEditingController();
  TextEditingController _clr1 = TextEditingController();
  TextEditingController _clr2 = TextEditingController();
  TextEditingController _clr3 = TextEditingController();
  TextEditingController _clr4 = TextEditingController();
  ApplicationDetailVo regApplication = ApplicationDetailVo();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xfff7f6fb),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back,
                  size: 32,
                  color: Colors.black54,
                ),
              ),
            ),
            SizedBox(
              height: AppDigits.defaultPadding,
            ),
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/images/illustration-3.png',
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              'Verification',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),

            CustomItems().customTextNew("Enter your OTP number", AppDigits.defaultPadding, TextAlign.center),
            SizedBox(
              height: 28,
            ),
            Container(
              padding: EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _textFieldOTP(first: true, last: false, ctrlr: _clr1),
                      _textFieldOTP(first: false, last: false, ctrlr: _clr2),
                      _textFieldOTP(first: false, last: false, ctrlr: _clr3),
                      _textFieldOTP(first: false, last: true, ctrlr: _clr4),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        checkOneTimePassword();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                        shape:
                        MaterialStateProperty.all<RoundedRectangleBorder>(
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
              height: 18,
            ),
            Text(
              "Didn't you receive any code?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Resend New Code",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void checkOneTimePassword() async {
    OneTimeRegistration oneTimeRegistration = OneTimeRegistration();
    oneTimeRegistration.id=widget.saveOtr.id;
    oneTimeRegistration.firstName=widget.saveOtr/*.oneTimeRegistration!*/.firstName;
    oneTimeRegistration.otp=_clr1.text + _clr2.text + _clr3.text + _clr4.text;
    String encodeData=convert.jsonEncode(oneTimeRegistration);
    Map<String, String> headers = {'content-type': 'application/json'};
    var response = await Api.checkOneTimePassword(encodeData, headers);
    if(response.statusCode==200){
      if(response!=null){
        otrResponse=OneTimeRegistration.fromJson(convert.jsonDecode(response.body));
        if(otrResponse != null && otrResponse.urn != null){
          SharedPreferences prefs= await SharedPreferences.getInstance();
        prefs.setString("urn",otrResponse.urn!);
        prefs.setInt("otrId",otrResponse.id!);
          otpSuccessDialog();
        } else {
          print("Something went wrong!");
        }
      }
    }
    else
      {
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

  Widget _textFieldOTP({required bool first, last, required TextEditingController ctrlr}) {
    return Container(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          controller: ctrlr,
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: AppColor.primaryColor),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }

  otpSuccessDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('One Time Registration'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(child: Text(StringsEn().yourAccountHasBeenSuccessfullyCreated)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text('Username:'),
                Text(
                  otrResponse.urn!,
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor),
                  onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInScreen())),
                  child: Text(
                    'OK',
                    style: TextStyle(color: Colors.white),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    ) ??
        false;
  }

  Future<void> createRegistrationApplicationByOtrId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String?token=prefs.getString("token");
    int?otrId=prefs.getInt("otrId");
    Map<String,String> headers={
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = (otrId!.toString());
    var response =
    await Api.createRegistrationApplicationByOtrId(encodedData, headers);
    if (response.statusCode == 200) {
      regApplication =
          ApplicationDetailVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        regApplication.status == "I"
            ? navigateToRegistrationPage(context)
            : navigateToWelcomePage(context);
      });
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

  void navigateToRegistrationPage(BuildContext context) async {
    Timer(
        Duration(seconds: 3),
            () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ApplicationDetails())));
  }

  void navigateToWelcomePage(BuildContext context) async {
    Timer(
        Duration(seconds: 3),
            () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomePage())));
  }


}