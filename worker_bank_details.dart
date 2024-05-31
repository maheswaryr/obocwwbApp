///Updated on 19/12/2022 by Arsha

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_button/custom_button.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/bank_account_details_vo.dart';
import 'package:obocwwb/model/bank_details_vo.dart';
import 'package:obocwwb/model/filter_vo.dart';
import 'package:obocwwb/model/model_class/registration_vo.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/registration_supporting_form.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_other_details.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../model/application_detail_vo.dart';
import '../../strings_en.dart';

import 'dart:convert' as convert;

class WorkerBankDetails extends StatefulWidget {
  final ApplicationDetailVo initiate = ApplicationDetailVo();
  WorkerBankDetails({Key? key}) : super(key: key);

  @override
  _WorkerBankDetailsState createState() => _WorkerBankDetailsState();
}

class _WorkerBankDetailsState extends State<WorkerBankDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List bankList = [];
  BankAccountDetailsVo bankDetails = BankAccountDetailsVo();
  BankAccountDetailsVo bankDetailsVo = BankAccountDetailsVo();
  String? bankId;
  String? dropdownValueBankDetails;
  TextEditingController nameOfBranch = TextEditingController();
  TextEditingController _ifsc_ = TextEditingController();
  TextEditingController accountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController conAccountNumber = TextEditingController();
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getBankList();
    getWorkerBankDetails();
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                StringsEn().Return,
                style: TextStyle(fontSize: AppDigits.titleSize),
              ),
              content: Text(
                StringsEn().doYouReallyWantToExit,
                style: TextStyle(fontSize: AppDigits.fontSize),
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    StringsEn().no,
                    style: TextStyle(
                        color: Colors.black, fontSize: AppDigits.fontSize),
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
                    style: TextStyle(
                        color: Colors.black, fontSize: AppDigits.fontSize),
                  ),
                ),
              ],
            ),
          ) ??
          false;
    }

    return StatefulBuilder(builder: (BuildContext cont, StateSetter state) {
      return WillPopScope(
        onWillPop: showExitPopup,
        child: Scaffold(
          key: _scaffoldKey,
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
                          headerCard(StringsEn().bankDetails),
                          SizedBox(height: AppDigits.size),
                          MyCustomTextField()
                              .textWithTextControllerTextFieldWithoutImpMark(
                                  TextInputType.text,
                                  StringsEn().accountHolderName,
                                  accountHolderName,
                                  false),
                          SizedBox(height: AppDigits.size),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(0),
                                    border: Border.all(color: Colors.black12)),
                                child: bankDropDown(cont, state),
                              )),
                          SizedBox(height: AppDigits.size),
                          MyCustomTextField()
                              .textWithTextControllerTextFieldWithoutImpMark(
                                  TextInputType.text,
                                  StringsEn().branchName,
                                  nameOfBranch,
                                  false),
                          SizedBox(height: AppDigits.size),
                          MyCustomTextField()
                              .textWithTextControllerTextFieldWithoutImpMarkIfsc(
                                  TextInputType.text,
                                  StringsEn().ifsc,
                                  _ifsc_,
                                  false),
                          SizedBox(height: AppDigits.size),
                          MyCustomTextField()
                              .textWithTextFieldForAccountMobileNumber(
                                  TextInputType.phone,
                                  StringsEn().accountNumber,
                                  accountNumber,
                                  false),
                          SizedBox(height: AppDigits.size),
                          MyCustomTextField()
                              .textWithTextFieldForAccountMobileNumber(
                                  TextInputType.phone,
                                  StringsEn().confirmBankAccountNumber,
                                  conAccountNumber,
                                  false),
                          //Save
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (accountNumber.text !=
                                        conAccountNumber.text) {
                                      Fluttertoast.showToast(
                                        msg: "Account number must be same ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                      );
                                    }
                                  });
                                  if (accountNumber.text ==
                                          conAccountNumber.text &&
                                      accountHolderName.text != "" &&
                                      nameOfBranch.text != "" &&
                                      _ifsc_.text ==
                                          RegExp("^[A-Z]{4}[0][0-9]{6}\$")
                                              .hasMatch(_ifsc_.text) &&
                                      bankId != "") {
                                    Fluttertoast.showToast(
                                      msg: StringsEn().saved,
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                    );
                                    saveWorkerBankAccountDetails();
                                  } else if (_ifsc_.text.isEmpty ||
                                      !RegExp("^[A-Z]{4}[0][0-9]{6}\$")
                                          .hasMatch(_ifsc_.text)) {
                                    Fluttertoast.showToast(
                                        msg:  StringsEn().checkIfscCode,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blueGrey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  /*  _scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                StringsEn().checkIfscCode)));*/
                                  } else if (nameOfBranch.text == "") {
                                    Fluttertoast.showToast(
                                        msg: StringsEn()
                                            .makeSureAllTheMandatoryFieldsAreFilled,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blueGrey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                    /*_scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                            content: Text(StringsEn()
                                                .makeSureAllTheMandatoryFieldsAreFilled)));*/
                                  } else if (accountHolderName.text == "") {
                                    Fluttertoast.showToast(
                                        msg: StringsEn()
                                            .checkAccountHolderName,
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blueGrey,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                   /* _scaffoldKey.currentState!.showSnackBar(
                                        SnackBar(
                                            content: Text(StringsEn()
                                                .checkAccountHolderName)));*/
                                  } else {
                                    saveWorkerBankAccountDetails();
                                  }
                                },
                                child: MyCustomButton()
                                    .buttonTextWidget(StringsEn().save),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColor.primaryColor)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
                MyCustomText().textInformation(),
                MyCustomContainer().getBottomLayout(
                  context,
                  WorkerOtherDetails(),
                  RegistrationSupportingDocuments(),
                  "7",
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  bankDropDown(BuildContext context, StateSetter setState) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 5.0, right: 10, left: 10),
        child: DropdownButton<String>(
            underline: SizedBox(),
            value: bankId,
            hint: Text(
              StringsEn().selectBank,
              style: TextStyle(fontSize: AppDigits.fontSize),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            isExpanded: true,
            items: bankList.map((item) {
              return DropdownMenuItem(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item['bankName'].toString(),
                    style: TextStyle(fontSize: AppDigits.fontSize),
                  ),
                ),
                value: item['bankId'].toString(),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                bankId = newValue;
              });
            }));
  }

  Future<void> getBankList() async {
    FilterVO bankDetailsVo = FilterVO();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    bankDetailsVo.status = "Y";

    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(bankDetailsVo);

    var response = await Api.getAllActiveBankDetails(encodedData, headers);
    if (response.statusCode == 200) {
      var responseBody = json.decode(response.body);
      setState(() {
        bankList = responseBody;
      });
    } else {}
  }

  Future<void> getWorkerBankDetails() async {
    BankAccountDetailsVo bankAccountDetailsVo = BankAccountDetailsVo();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bankAccountDetailsVo.registrationVO = RegistrationVO();
    bankAccountDetailsVo.registrationVO!.id = prefs.getInt('workerId');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(bankAccountDetailsVo);
    var response = await Api.getWorkerBankDetails(encodedData, headers);
    if (response.statusCode == 200) {
      bankDetails =
          BankAccountDetailsVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        loading = false;
        if (bankDetails.accountHolderName != null) {
          accountHolderName.text = bankDetails.accountHolderName!;
        }
        if (bankDetails.accNo != null) {
          accountNumber.text = bankDetails.accNo!;
        }
        _ifsc_.text = bankDetails.ifscCode!;
        if (bankDetails.branchName != null) {
          nameOfBranch.text = bankDetails.branchName!;
        }
        if (bankDetails.bankName!.bankId != null) {
          bankId = bankDetails.bankName!.bankId.toString();
        }
        if (bankDetails.accNo != null) {
          conAccountNumber.text = bankDetails.accNo!;
        }
      });
    }
  }

  void saveWorkerBankAccountDetails() async {
    BankAccountDetailsVo bankAccountDetailsVo = BankAccountDetailsVo();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString('token');
    bankAccountDetailsVo.registrationVO = RegistrationVO();
    bankAccountDetailsVo.registrationVO!.id = preferences.getInt('workerId');
    bankAccountDetailsVo.accountHolderName = accountHolderName.text;
    bankAccountDetailsVo.accNo = accountNumber.text;
    bankAccountDetailsVo.ifscCode = _ifsc_.text;
    bankAccountDetailsVo.branchName = nameOfBranch.text;
    bankAccountDetailsVo.bankName = BankDetailsVo();
    bankAccountDetailsVo.id = int.parse(bankId!);
    bankAccountDetailsVo.bankName!.bankId = int.parse(bankId!);
    bankAccountDetailsVo.accNo = accountNumber.text;
    bankAccountDetailsVo.conAccNO = conAccountNumber.text;
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    String encodedData = convert.jsonEncode(bankAccountDetailsVo);
    var response = await Api.saveWorkerBankAccountDetails(encodedData, headers);
    if (response.statusCode == 200) {
      bankDetailsVo =
          BankAccountDetailsVo.fromJson(convert.jsonDecode(response.body));
      setState(() {
        Fluttertoast.showToast(
            msg:
            'Saved!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blueGrey,
            textColor: Colors.white,
            fontSize: 16.0);
   /*     _scaffoldKey.currentState!
            .showSnackBar(SnackBar(content: Text('Saved!')));*/
        loading = false;
      });
    }
  }
}
