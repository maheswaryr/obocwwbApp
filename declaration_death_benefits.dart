///Updated on 19/12/2022 by Arsha

import 'dart:async';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/constants.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/application_detail_vo.dart';
import 'package:obocwwb/obocwwb_ui/home/benefits_page.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class DeclarationDeathBenefitsForm extends StatefulWidget {
  ApplicationDetailVo initiate = ApplicationDetailVo();
  DeclarationDeathBenefitsForm({required this.initiate}) : super();

  @override
  DeclarationDeathBenefitsFormState createState() =>
      DeclarationDeathBenefitsFormState();
}

class DeclarationDeathBenefitsFormState
    extends State<DeclarationDeathBenefitsForm> {
  StreamSubscription? internetConnection;
  bool isOffline = false;
  bool _isLoading = true;
  PDFDocument? document;
  bool checked = false;

  @override
  void initState() {
    internetConnection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      // when every connection status is changed.
      if (result == ConnectivityResult.none) {
        //there is no any connection
        setState(() {
          isOffline = true;
        });
      } else if (result == ConnectivityResult.mobile) {
        //connection is mobile data network
        setState(() {
          isOffline = false;
        });
      } else if (result == ConnectivityResult.wifi) {
        //connection is from wifi
        setState(() {
          isOffline = false;
        });
      }
    });
    changePDF();
    super.initState();
  }

  @override
  void dispose() {
    internetConnection!.cancel();
    super.dispose();
  }

  changePDF() async {
    setState(() => _isLoading = true);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    int? workerId = preferences.getInt("workerId");
    var url = Api.getNomineeBaseUrl() +
        "worker/getWorkerRegistrationReports/" +
        workerId.toString();
    Map<String, String> headers = {'Authorization': 'Bearer $token'};
    document = await PDFDocument.fromURL(url, headers: headers);
    setState(() => _isLoading = false);
    return document;
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
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsEn().deathBenefitApplicationForm),
          backgroundColor: AppColor.primaryColor,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: errMsg("No Internet Connection Available", isOffline),
              ),
           Padding(padding: EdgeInsets.only(right: 4,top: 4,left: 4),
           child: headerCard(StringsEn().declaration),),
           /*   MyCustomHeader().*/
              Expanded(
                child: Container(
                  child: Center(
                    child: _isLoading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Text(
                                 StringsEn().loadingPleaseWait,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )
                        : PDFViewer(
                            document: document!,
                            zoomSteps: 1,
                            lazyLoad: false,
                            showNavigation: false,
                            showPicker: false,
                          ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.green,
                      value: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value!;
                        });
                      },
                    ),

                    Expanded(
                      child: Text(
                        "I hereby solemnly declare that the facts mentioned above are true to the best of my knowledge and belief. In case, any information submitted by me is found wrong. I shall be liable to refund the same with interest to the Board immediately",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    print(widget.initiate.id.toString());

                    checked == true
                        ? _onSubmitAlertDialog()
                        : _validationAlertDialog();
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(StringsEn().sUBMIT, style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget errMsg(String text, bool show) {
    //error message widget.
    if (show == true) {
      //if error is true then show error message box
      return Container(
        padding: EdgeInsets.all(10.00),
        margin: EdgeInsets.only(bottom: 10.00),
        color: Colors.red,
        child: Row(children: [
          Container(
            margin: EdgeInsets.only(right: 6.00),
            child: Icon(Icons.info, color: Colors.white),
          ), // icon for error message

          Text(text, style: TextStyle(color: Colors.white)),
          //show error message text
        ]),
      );
    } else {
      return Container();
      //if error is false, return empty container.
    }
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              StringsEn().Return,
              style: TextStyle(fontSize: AppDigits.titleSize),
            ),
            content: Text(
              StringsEn().doYouWantToReturnToHomePage,
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
                    builder: (context) => HomePage(),
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
                  "Confirmation...!!!".toUpperCase(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
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
                "Are you sure you want to submit this application ?",
                style: TextStyle(
                    fontSize: 16,
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
                    fontSize: 12.0),
              ),
            ),
          ],
        ),
        content: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              submitLoading();
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
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

  submitLoading() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    ApplicationDetailVo applicationDetailVo = ApplicationDetailVo();
    applicationDetailVo.status = "S";
    applicationDetailVo.id = widget.initiate.id;

    String encodedData = convert.jsonEncode(applicationDetailVo);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var res = await Api.submitApplication(encodedData, headers);
    if (res.body != null) {
      if (res.statusCode == 200) {
        ApplicationDetailVo applicationDetailVo = ApplicationDetailVo();
        applicationDetailVo =
            ApplicationDetailVo.fromJson(convert.jsonDecode(res.body));
        Fluttertoast.showToast(
          msg: "Submitted Successfully = " + applicationDetailVo.id.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        _successfulSubmitAlertDialog();
      }
    } else {
      /*Fluttertoast.showToast(
        msg: "Failed To Submit Death Benefit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
      );*/
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
                  "Validation Alert...!!!".toUpperCase(),
                  style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
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
                "Click checkbox to agree our terms and condition before submitting",
                style: TextStyle(
                    fontSize: 16,
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
                'TRY AGAIN',
                style: TextStyle(fontSize: 20),
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
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  "Your submission has been sent.",
                  style: TextStyle(
                      fontSize: 18,
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
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BenefitsPage())),
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
                'Go to Applied Benefit list ->',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
