///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/payment_details_vo.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/registration_supporting_form.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';

import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class PaymentDetails extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  PaymentDetails({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentDetailsState createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  PaymentDetailsVO paymentDetailsVO = PaymentDetailsVO();
  TextEditingController textPayment = TextEditingController();
  TextEditingController _controller = new TextEditingController();
  bool? checkBox1 = false;
  bool? checkBox2 = false;
  bool? checkBox3 = false;
  bool? checkBox4 = false;

  @override
  void initState() {
    super.initState();
    getPaymentDetails();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(StringsEn().Return),
              content: Text(StringsEn().doYouReallyWantToExit),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    StringsEn().no,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  ),
                  child: Text(
                    StringsEn().yes,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    _controller.text = '20';

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
            title: Text(StringsEn()
                .applicationForRegistrationOfBuildingAndConstructionWorkers),
            backgroundColor: AppColor.primaryColor),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Card(
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headerCard(StringsEn().payment),
                        SizedBox(height: AppDigits.fontSize),
                        MyCustomTextField().textWithTextControllerForPayment(
                            TextInputType.phone,
                            StringsEn().registrationFee,
                            _controller,
                            true),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                              onPressed: () {
                                /*   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                InAppWebView()));*/
                              },
                              child: MyCustomButton()
                                  .buttonTextWidget(StringsEn().payNow),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor)),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
              MyCustomText().textInformation(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(0),
                    border: Border.all(color: Colors.black12)),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      RegistrationSupportingDocuments()),
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primaryColor),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              children: [
                                Icon(Icons.arrow_back, size: 16.0),
                                /*  SizedBox(width: 5.0),*/
                                Text(StringsEn().previous,
                                    style: TextStyle(
                                        fontSize: AppDigits.titleSize)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 100.0,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.blue[200],
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            "9",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            _onNextAlertDialog();
                          },
                          style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(
                                AppColor.primaryColor),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(StringsEn().next,
                                    style: TextStyle(
                                        fontSize: AppDigits.titleSize)),
                                SizedBox(width: 5.0),
                                Icon(Icons.arrow_forward_rounded, size: 16.0),
                              ],
                            ),
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
      ),
    );
  }

  headerCard(String headerText) {
    return Container(
      width: double.infinity,
      color: AppColor.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(headerText,
            style: TextStyle(
                color: Colors.white,
                fontSize: AppDigits.fontSize,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Future<void> getPaymentDetails() async {
    FilterVO filterVO = FilterVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    filterVO.status = preferences.getString('encryptedWorkerId');
    filterVO.workerRegId = preferences.getInt('workerId');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(filterVO);
    var response = await Api.getPaymentDetails(encodedData, headers);
    if (response.statusCode == 200) {
      paymentDetailsVO =
          PaymentDetailsVO.fromJson(convert.jsonDecode(response.body));
      setState(() {
        textPayment.text = paymentDetailsVO.amountPaid.toString();
      });
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBoxSessionTimeOut(context);
      }
    }
  }

  void savePaymentDetails() async {
    PaymentDetailsVO paymentDetails = PaymentDetailsVO();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");

    paymentDetails.paymentStatus = "Y";
    paymentDetails.amountPaid = int.parse(textPayment.text);

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(paymentDetails);
    var response = await Api.savePayment(encodedData, headers);

    if (response.statusCode == 200) {
      paymentDetailsVO =
          PaymentDetailsVO.fromJson(convert.jsonDecode(response.body));
      setState(() {});
    } else {
      if (response.statusCode == 401) {
        MyCustomText().alertDialogBoxSessionTimeOut(context);
      }
    }
  }

  Future _onNextAlertDialog() {
    return showModalBottomSheet(
      context: context,
      builder: (vc) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return Stack(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Declaration Form",
                            style: TextStyle(
                                color: AppColor.primaryColor,
                                fontSize: AppDigits.titleSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    card10DeclarationForm(context, setState),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ]);
        });
      },
    );
  }

  //Declaration form
  card10DeclarationForm(BuildContext context, StateSetter setState) {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //declaration
            CheckboxListTile(
              title: Text(
                  "I am aware that if a person enter Aadhaar number of any other person and attempt to impersonate another person, dead or alive, real or imaginary, he/she shall be punishable with imprisonment for a term which may extend up to three years and shall also be liable to a fine which may extend to ten thousand rupees as per provisions of Aadhaar act.",
                  style: TextStyle(fontSize: AppDigits.fontSize)),
              value: checkBox1,
              onChanged: (bool? value) {
                setState(() {
                  checkBox1 = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                "I hereby declare that my application will be rejected if it is found that I have provided wrong Aadhaar number or Aadhaar number of someone else’s.",
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
              value: checkBox2,
              onChanged: (bool? value) {
                setState(() {
                  checkBox2 = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                  "I hereby declare that for any wrong entry in bank account details by me, the OB&OCWW Board will not be responsible for mis-credit and I will be held responsible for the same.",
                  style: TextStyle(fontSize: AppDigits.fontSize)),
              value: checkBox3,
              onChanged: (bool? value) {
                setState(() {
                  checkBox3 = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text(
                  "I hereby declare that the particulars given above are true to the best of my knowledge and belief.",
                  style: TextStyle(fontSize: AppDigits.fontSize)),
              value: checkBox4,
              onChanged: (bool? value) {
                setState(() {
                  checkBox4 = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            //space
            SizedBox(
              height: AppDigits.fontSize,
            ),
            //Save, Submit, Preview- Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Submit- Button
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (checkBox1 == true &&
                          checkBox2 == true &&
                          checkBox3 == true &&
                          checkBox4 == true) {
                        _onSubmitAlertDialog();
                      } else {
                        _validationAlertDialog();
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        StringsEn().sUBMIT,
                        style: TextStyle(fontSize: AppDigits.fontSize),
                      ),
                    ),
                  ),
                ),
                //Preview- Button
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.orange),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        StringsEn().pREVIEW,
                        style: TextStyle(fontSize: AppDigits.fontSize),
                      ),
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

  Future<void> _validationAlertDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 0),
                child: new Text(
                  StringsEn().validationAlert.toUpperCase(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDigits.titleSize),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(
                color: AppColor.primaryColor.withOpacity(0.9),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                StringsEn()
                    .clickCheckboxToAgreeOurTermsAndConditionBeforeSubmitting,
                style: TextStyle(
                    fontSize: AppDigits.fontSize,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
        content: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                StringsEn().tRYAGAIN,
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _successfulSubmitAlertDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.done_all_sharp,
                      size: 50,
                      color: Colors.green,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "Success !",
                  style: TextStyle(
                      fontSize: AppDigits.titleSize,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  StringsEn().yourSubmissionHasBeenSent,
                  style: TextStyle(
                      fontSize: AppDigits.fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        content: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage())),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                StringsEn().goToAppliedBenefitList,
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _failedSubmitAlertDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Container(
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      size: 50,
                      color: Colors.red,
                    ),
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  StringsEn().failed,
                  style: TextStyle(
                      fontSize: AppDigits.titleSize,
                      fontWeight: FontWeight.w800,
                      color: Colors.red),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  StringsEn().yourSubmissionHasBeenFailedPleaseTryAgain,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: AppDigits.titleSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        content: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                StringsEn().tryAgain,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onSubmitAlertDialog() {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => new AlertDialog(
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 20, bottom: 0),
                child: new Text(
                  StringsEn().confirmation.toUpperCase(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: AppDigits.titleSize),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Divider(
                color: AppColor.primaryColor.withOpacity(0.9),
                thickness: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Text(
                StringsEn().areYouSureYouWantToSubmitThisApplication,
                style: TextStyle(
                    fontSize: AppDigits.titleSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Text(
                "Preview your information before submitting. Once applications is submitted no information will be change",
                style: TextStyle(
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: AppDigits.fontSize),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              submitRegForm();
            },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                ),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                StringsEn().sUBMIT,
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void submitRegForm() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    ApplicationDetailVo applicationDetailVo = ApplicationDetailVo();
    applicationDetailVo.status = "S";
    applicationDetailVo.id = preferences.getInt("applicationId");

    String encodedData = convert.jsonEncode(applicationDetailVo);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var res = await Api.submitApplication(encodedData, headers);

    if (res.body != null) {
      if (res.statusCode == 200) {
        applicationDetailVo =
            ApplicationDetailVo.fromJson(convert.jsonDecode(res.body));
        Fluttertoast.showToast(
          msg: "Submitted Successfully = ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        _successfulSubmitAlertDialog();
      } else {
        _failedSubmitAlertDialog();
      }
    } else {
      if (res.statusCode == 401) {
        MyCustomText().alertDialogBox1(context);
      } else if (res.statusCode == 404) {
        MyCustomText().alertDialogBox2(context);
      } else if (res.statusCode == 500) {
        MyCustomText().alertDialogBox(context);
      }
      throw Exception('Failed to load jobs from API');
    }
  }
}
