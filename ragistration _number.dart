import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/model/funeral_expenses/registration_vo.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/application_details.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/registration_details_page.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert' as convert;
import '../../model/application_detail_vo.dart';

class DeathRegistrationNumberPage extends StatefulWidget {
  const DeathRegistrationNumberPage({Key? key}) : super(key: key);


  @override
  State<DeathRegistrationNumberPage> createState() => _DeathRegistrationNumberPageState();
}

class _DeathRegistrationNumberPageState extends State<DeathRegistrationNumberPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  bool? secondCheck = false;
  TextEditingController registrationNumberController = TextEditingController();

  ApplicationDetailVo initiate = ApplicationDetailVo();

  ApplicationDetailVo regApplication = ApplicationDetailVo();

  RegistrationVo registrationResponse = RegistrationVo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(StringsEn()
            .deathBenefits),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(

            children: [
              Expanded(child: SingleChildScrollView(
               child:Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    StringsEn().registrationNumberOfTheMember,
                    style: TextStyle(
                      fontSize: AppDigits.titleSize,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                TextFormField(
                  inputFormatters: [UpperCaseTextFormatter()],
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp("^[A-Z]{4}[0][0-9]{9}\$").hasMatch(value)) {
                      return "Enter valid Ifsc code";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                    fontSize: AppDigits.titleSize,
                    fontWeight: FontWeight.bold,
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

                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  controller: registrationNumberController,

                ),
                SizedBox(height: 20,),

                ElevatedButton(
                  onPressed: () {
                    if (/*_formKey.currentState!.validate()*/registrationNumberController.text !="" /*&&
                    registrationNumberController.text ==
                        RegExp("^[A-Z]{5}[0-9]{9}")
                            .hasMatch(
                            registrationNumberController
                                .text)*/
                    ){
                      GoToDeathBenefitFormFunction();
                    }
                    else{
                      Fluttertoast.showToast(
                          msg: "Something went wrong",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueGrey,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }

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
                      StringsEn().proceed,
                      style: TextStyle(fontSize: AppDigits.titleSize),
                    ),
                  ),
                )
            ],
          )

              ))
            ],
          ),
        ),
      ),
    );
  }

  GoToDeathBenefitFormFunction() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

 /*   DeathBenefitVO deathBenefitVO = DeathBenefitVO();
    deathBenefitVO.worker  = RegistrationVo();
    deathBenefitVO.worker!.licenseNumber = registrationNumberController.text;*/
    RegistrationVo deathBenefitVO= RegistrationVo();
    deathBenefitVO.licenseNumber = registrationNumberController.text;
    String encodedData = convert.jsonEncode(deathBenefitVO);
     Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    var res = await Api.checkRegistrationDetails(encodedData, headers);
    if (res.statusCode == 200) {
      registrationResponse =
          RegistrationVo.fromJson(convert.jsonDecode(res.body));
        setState(() {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RegistrationConstructionWorkerDetailsDeathBenefitsForm(
                  registrationResponse: registrationResponse,

                )),
          );
        });


      Fluttertoast.showToast(
        msg: "Saved Successfully  ",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );
    }else {
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
  }/*
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
            : RegistrationConstructionWorkerDetailsDeathBenefitsForm( initiate: initiate,);
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
  }*/
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

  /*void NavigateToRegPage(BuildContext context, DeathBenefitVO checkdeathBenefitVO) async{
    Timer(
        Duration(seconds: 3),
            () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => RegistrationConstructionWorkerDetailsDeathBenefitsForm(initiate: initiate, ))));
  }*/
}
