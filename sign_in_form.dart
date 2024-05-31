///Updated on 19/12/2022 by Arsha

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/model/login_request.dart';
import 'package:obocwwb/model/login_response.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/model/one_time_registration.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/application_details.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';
import 'dart:convert' as convert;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../sign_in_screen.dart';

class SignInForm extends StatefulWidget {
 final  ApplicationDetailVo initiate = ApplicationDetailVo();
  SignInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);
  final GlobalKey formKey;

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  RegistrationVO registrationGeneralDetails = RegistrationVO();
  ApplicationDetailVo regApplication = ApplicationDetailVo();
  bool otp = false;

  @override
  void initState() {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionState);
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }
  bool isObscure = true;
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error Occurred: ${e.toString()} ");
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionState(result);
  }

  Future<void> _updateConnectionState(ConnectivityResult result) async {
    if (result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi) {
      showStatus(result, true);
    } else {
      showStatus(result, false);
    }
  }

  void showStatus(ConnectivityResult result, bool status) {
    final snackBar = SnackBar(
        content: Text("${status ? 'ONLINE' : 'OFFLINE'}"),
        backgroundColor: status ? Colors.green : Colors.red);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

  }

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1. Username
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Username',
                    style: TextStyle(
                      fontSize: AppDigits.titleSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: AppDigits.titleSize,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: _usernameController,
                ),
                SizedBox(
                  height: 20,
                ),
                //Request otp
                Visibility(
                  visible: !otp,
                  child: ElevatedButton(
                    onPressed: () {
                      generateOtp();
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          AppColor.primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Get OTP',
                        style: TextStyle(fontSize: AppDigits.titleSize),
                      ),
                    ),
                  ),
                ),
                //2. Password
                Visibility(
                  visible: otp,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TweenAnimationBuilder<Duration>(
                          duration: Duration(minutes: 3),
                          tween: Tween(
                              begin: Duration(minutes: 2), end: Duration.zero),
                          onEnd: () {
                            print('Timer ended');
                          },
                          builder: (BuildContext context, Duration value,
                              Widget? child) {
                            final minutes = value.inMinutes;
                            final seconds = value.inSeconds % 60;
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text(
                                    'OTP is sent to your registered mobile number $minutes:$seconds',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.blue[900], fontSize: AppDigits.fontSize)));
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'OTP',
                          style: TextStyle(
                            fontSize: AppDigits.titleSize,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextFormField(
                        obscureText: isObscure,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: AppDigits.titleSize,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isPassword = !isPassword;
                                isObscure = !isObscure;
                              });
                            },
                            icon: Icon( isObscure ? Icons.visibility : Icons.visibility_off,
                              // Based on passwordVisible state choose the icon

                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            loginFunction();
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primaryColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Sign In',
                              style: TextStyle(fontSize: AppDigits.titleSize),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]));
  }

 loginFunction() async {
    if ((_usernameController.text != "") && (_passwordController.text != "")) {
      LoginRequest loginRequest = LoginRequest();
      loginRequest.userName = _usernameController.text;
      loginRequest.passwd = _passwordController.text;
      Map<String, String> headers = {'content-type': 'application/json'};
      String encodedData = convert.jsonEncode(loginRequest);
      var response = await Api.getLoginService(encodedData, headers);
      if (response != null) {
        authenticateLoginAlertBox();
        if (response.statusCode == 200) {
          LoginResponse loginResponse = LoginResponse();
          loginResponse =
              LoginResponse.fromJson(convert.jsonDecode(response.body));
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString("token", loginResponse.token!);
          pref.setInt("otrID", loginResponse.otrID!);
          pref.setString('uname', loginResponse.uname!);

          OneTimeRegistration oneTimeRegistration = OneTimeRegistration();
          oneTimeRegistration.id = loginResponse.otrID!;

          String? token = pref.getString("token");
          Map<String, String> headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
          };
          String encodedData = convert.jsonEncode(oneTimeRegistration);
          var res =
              await Api.getOneTimeRegistrationDetails(encodedData, headers);
          if (res != null) {
            if (res.statusCode == 200) {
              OneTimeRegistration oneTimeRegistrations = OneTimeRegistration();
              oneTimeRegistrations =
                  OneTimeRegistration.fromJson(convert.jsonDecode(res.body));
              SharedPreferences prefss = await SharedPreferences.getInstance();
              prefss.setString("firstName", oneTimeRegistrations.firstName!);
              prefss.setString("lastName", oneTimeRegistrations.lastName!);
              prefss.setString("mobileNo", oneTimeRegistrations.mobileNo!);
              prefss.setString("gender", oneTimeRegistrations.gender!);
              if (oneTimeRegistrations.alreadyRegistred != null) {
                prefss.setString("alreadyRegistered",
                    oneTimeRegistrations.alreadyRegistred!);
              }
              if (oneTimeRegistrations.registrationNumber != null) {
                prefss.setString("registrationNumber",
                    oneTimeRegistrations.registrationNumber!);
              }
              prefss.setString("urn", oneTimeRegistrations.urn!);
              prefss.setString("otp", oneTimeRegistrations.otp!);
              prefss.setString("otpStatus", oneTimeRegistrations.otpStatus!);
              prefss.setString("enteredOn", oneTimeRegistrations.enteredOn!);

              createRegistrationApplicationByOtrId();
              _successLogin();

              SharedPreferences prefs = await SharedPreferences.getInstance();
              setState(() {

                prefs.setString('token', loginResponse.token!);
              });
            }
          } else {
            Fluttertoast.showToast(
                msg: "Something went wrong. Please check your internet connection and try again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blueGrey,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          _wrongUserPass('Invalid username or password');
        }
      } else {
        _wrongUserPass(
            "Unable to established internet connection. Please check internet connection and try again...!!!");
      }
    } else if ((_usernameController.text == '') &&
        (_passwordController.text == '')) {
      _wrongUserPass(
          "Fields cannot be empty. Please enter username and password");
    } else if (_usernameController.text == '') {
      _wrongUserPass(
        "Field cannot be empty. Please enter username",
      );
    } else if (_passwordController.text == '') {
      _wrongUserPass("Field cannot be empty. Please enter password");
    }
    return CircularProgressIndicator();
  }

  void navigateToWelcomePage(BuildContext context) async {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => HomePage())));
  }

  void navigateToRegistrationPage(BuildContext context) async {
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => ApplicationDetails( ))));
  }

  Future<void> _wrongUserPass(String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new AlertDialog(
              contentPadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.all(15.0),
                child: new Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              content: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignInScreen()));
                  },
                  style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppColor.primaryColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      'Try Again',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ));
  }

  authenticateLoginAlertBox() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(1.0))),
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            content: Container(
              height: 100.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: CircularProgressIndicator(),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Text(
                      "Authenticating, Please Wait...!!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          letterSpacing: 2.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _successLogin() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                new Image.asset(
                  'assets/images/login_success.png',
                  height: 50.0,
                  width: 50.0,
                ),
                new SizedBox(width: 10.0),
                Expanded(
                  child: new Text(
                    'Authentication Successful...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        color: Colors.green),
                  ),
                ),
              ],
            ),
            new SizedBox(height: 10.0),
            new Text(
              'It will automatically redirect to Automation Solution for OB&OCWWB Home',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15.0),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getWorkerDetails() async {
    RegistrationVO registration = RegistrationVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    registration.oneTimeRegistration = OneTimeRegistration();
    registration.oneTimeRegistration!.id = pref.getInt("otrID");


    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(registration);
    var response = await Api.getWorkerRegistrationDetails(encodedData, headers);
    //Checking condition whether response is null or not
    if (response.statusCode == 200) {
      registrationGeneralDetails =
          RegistrationVO.fromJson(convert.jsonDecode(response.body));
      setState(() {
      });
    } else {}
  }

  Future<void> generateOtp() async {

    Map<String, String> headers = {'content-type': 'application/json'};
    String encodedData = (_usernameController.text);
    var response = await Api.generateOtp(encodedData, headers);
    if (response != null) {
      if (response.statusCode == 200) {
        setState(() {

          otp = true;

        });
      }
    }
  }

  Future<void> createRegistrationApplicationByOtrId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    int? otrId = prefs.getInt("otrID");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = (otrId!.toString());
    var response = await Api.createRegistrationApplicationByOtrId(encodedData, headers);
    if (response.statusCode == 200) {
      regApplication = ApplicationDetailVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        prefs.setString('encryptedWorkerId', regApplication.worker!.idEncrypted!);
        prefs.setInt("workerId", regApplication.worker!.id!);
        prefs.setString("encryptedOtrId", regApplication.otr!.idEncrypted!);
        prefs.setString("status", regApplication.status!);
        prefs.setInt("applicationId", regApplication.id!);
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
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}