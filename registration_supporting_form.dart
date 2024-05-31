///Updated on 19/12/2022 by Arsha

import 'dart:convert';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:obocwwb/api/api.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';
import 'package:obocwwb/model/attachmentVo.dart';
import 'package:obocwwb/model/filter_vo.dart';

import 'package:obocwwb/model/funeral_expenses/filter_vo.dart';
import 'package:obocwwb/model/scheme_attachment_vo.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/test_home.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/payment_details.dart';
import 'package:obocwwb/obocwwb_ui/application_for_registration/worker_bank_details.dart';
import 'package:obocwwb/strings_en.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'dart:convert' as convert;

class RegistrationSupportingDocuments extends StatefulWidget {
  const RegistrationSupportingDocuments({Key? key}) : super(key: key);

  @override
  RegistrationSupportingDocumentsState createState() =>
      RegistrationSupportingDocumentsState();
}

class RegistrationSupportingDocumentsState
    extends State<RegistrationSupportingDocuments> {
  PlatformFile? fileUpload;
  PlatformFile? deathCertificateUpload;
  DateTime newDate = DateTime.now();
  DateFormat formatDate = DateFormat('dd-MM-yyyy');

  List<SchemeAttachmentVo> schemeAttachmentList = [
    SchemeAttachmentVo(
        attachmentName: "Aadhaar Linked Bank Passbook Front Page Copy"),
    SchemeAttachmentVo(attachmentName: "Aadhaar Card"),
    SchemeAttachmentVo(attachmentName: "Employment Certificate"),
    SchemeAttachmentVo(attachmentName: "Passport Size Photo"),
    SchemeAttachmentVo(attachmentName: "Signature of Applicant"),
  ];
  /* List<AttachmentVO> schemeAttachmentList = [
    AttachmentVO(
        attachmentName: "Aadhaar Linked Bank Passbook Front Page Copy"),
    AttachmentVO(attachmentName: "Aadhaar Card"),
    AttachmentVO(attachmentName: "Employment Certificate"),
    AttachmentVO(attachmentName: "Passport Size Photo"),
    AttachmentVO(attachmentName: "Signature of Applicant"),
  ];*/
  List<AttachmentVO> attachmentVOList = [];
  bool loading = true;
  AttachmentVO saveAttachmentVO = AttachmentVO();
  bool? isChecked = false;

  @override
  void initState() {
    getWorkerUploadedDocumentsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsEn()
              .applicationForRegistrationOfBuildingAndConstructionWorkers),
          backgroundColor: AppColor.primaryColor,
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*loading
                  ? Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 20.0,
                            ),
                            Text(
                              'Loading, Please Wait...',
                              style: TextStyle(
                                  fontSize: AppDigits.fontSize,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    )
                  :*/
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          headerCard(StringsEn().listOfSupportingDocuments),
                          schemeAttachmentList.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10.0, right: 10.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: schemeAttachmentList.length,
                                    //itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        dense: true,
                                        contentPadding: EdgeInsets.all(0.0),
                                        title: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black26),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(10.0),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      (index + 1).toString() +
                                                          ". ",
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: AppDigits
                                                              .fontSize,
                                                          fontWeight:
                                                              FontWeight.w800),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        schemeAttachmentList[
                                                                index]
                                                            .attachmentName!,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: AppDigits
                                                              .fontSize,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    schemeAttachmentList[
                                                                    index] /*id*/
                                                                .attachment ==
                                                            null
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                getSelectFile((schemeAttachmentList[
                                                                            index]
                                                                        .attachmentName!)
                                                                    .toString());
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .file_copy_outlined,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  Text(
                                                                    StringsEn()
                                                                        .browse,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          AppDigits
                                                                              .fontSize,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10.0),
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors
                                                                  .grey[200],
                                                            ),
                                                          ),
                                                    SizedBox(width: 10.0),
                                                  ],
                                                ),
                                              ),
                                              schemeAttachmentList[index]
                                                          .attachment ==
                                                      null
                                                  ? Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Text(
                                                        StringsEn()
                                                            .noFileSelected,
                                                        style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: AppDigits
                                                              .fontSize,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      alignment:
                                                          Alignment.center,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  schemeAttachmentList[
                                                                          index]
                                                                      .attachment!
                                                                      .attachmentPath
                                                                      .toString() /*.attachmentPath.toString()*/,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        AppDigits
                                                                            .fontSize,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 5.0,
                                                                ),
                                                                Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                              .grey[
                                                                          100],
                                                                      borderRadius:
                                                                          BorderRadius.all(
                                                                              Radius.circular(20))),
                                                                  child: schemeAttachmentList[index]
                                                                              .attachment!
                                                                              .attachedOn !=
                                                                          null
                                                                      ? Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            StringsEn().attachedOn +
                                                                                schemeAttachmentList[index].attachment!.attachedOn.toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black87,
                                                                              fontSize: AppDigits.fontSize,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          ))
                                                                      : Padding(
                                                                          padding: const EdgeInsets.all(
                                                                              5.0),
                                                                          child:
                                                                              Text(
                                                                            StringsEn().attachedOn,
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black87,
                                                                              fontSize: AppDigits.fontSize,
                                                                              fontWeight: FontWeight.w500,
                                                                            ),
                                                                          )),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                int attachmentId =
                                                                    schemeAttachmentList[
                                                                            index]
                                                                        . /*id!*/
                                                                        attachment!
                                                                        .id!;
                                                                deleteWorkerAttachment(
                                                                    attachmentId);
                                                              });
                                                            },
                                                            child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(5.0),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Column(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .delete_outline_outlined,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  Text(
                                                                    StringsEn()
                                                                        .delete,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          AppDigits
                                                                              .fontSize,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(width: 10.0),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  child:
                                      Center(child: Text("No data available")),
                                ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyCustomText().textInformationSupportingDocument(),
              MyCustomContainer().getBottomLayout(
                context,
                WorkerBankDetails(),
                PaymentDetails(),
                "8",
              ),
            ],
          ),
        ),
      ),
    );
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

  //server request to get all list of save supporting documents for death benefits
  Future<void> getWorkerUploadedDocumentsList() async {
    // DateFormat formatDate = DateFormat('dd-MM-yyyy','hh:mm');
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    int? workerRegId = preferences.getInt('workerId');
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    /*CommonFilterVo*/ FilterVO commonFilterVO = FilterVO /*CommonFilterVo*/ ();
    commonFilterVO.workerRegId = workerRegId;
    try {
      String encodedData = convert.jsonEncode(commonFilterVO);
      var response =
          await Api.getWorkerUploadedDocumentsTest(encodedData, headers);
      if (response.statusCode == 200) {
        setState(() {
          print((attachmentVOList.length).toString());
          attachmentVOList = (json.decode(response.body) as List)
              .map((i) => AttachmentVO.fromJson(i))
              .toList();
          //merging attachmentList with schemeAttachmentList.
          for (int i = 0; i < attachmentVOList.length; i++) {
            for (int j = 0; j < schemeAttachmentList.length; j++) {
              if (attachmentVOList[i].attachmentName ==
                  schemeAttachmentList[j].attachmentName) {
                schemeAttachmentList[j].attachment = AttachmentVO();
                schemeAttachmentList[j].attachment!.id = attachmentVOList[i].id;
                schemeAttachmentList[j].attachment!.applicationId =
                    attachmentVOList[i].applicationId;
                schemeAttachmentList[j].attachment!.workerId =
                    attachmentVOList[i].workerId;
                schemeAttachmentList[j].attachment!.attachmentName =
                    attachmentVOList[i].attachmentName;
                schemeAttachmentList[j].attachment!.attachmentPath =
                    attachmentVOList[i].attachmentPath;
                schemeAttachmentList[j].attachment!.deleteStatus =
                    attachmentVOList[i].deleteStatus;

                DateTime newDate =
                    DateTime.tryParse(attachmentVOList[i].attachedOn!)!;

                schemeAttachmentList[j].attachment!.attachedOn =
                    formatDate.format(newDate);
              }
            }
          }
/*        loading = false;*/
        });
      } else {
        if (response.statusCode == 401) {
          MyCustomText().alertDialogBox1(context);
        } else if (response.statusCode == 404) {
          MyCustomText().alertDialogBox2(context);
        } else if (response.statusCode == 500) {
          MyCustomText().alertDialogBox(context);
        }
        throw Exception('Failed to load jobs from API');
      }
    } catch (e) {
      print(e);
    }
  }

  // select File{pdf, jpg, png} from phone storage-download and save the selected file in server
  getSelectFile(String supportingDocumentName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);

    if (result != null) {
      AttachmentVO attachmentVO = AttachmentVO();

      attachmentVO.workerId = preferences.getInt("workerId");
      attachmentVO.applicationId = preferences.getInt("applicationId");
      attachmentVO.attachmentName = supportingDocumentName;
      attachmentVO.deleteStatus = "N";
      print((attachmentVO.workerId).toString() +
          (attachmentVO.applicationId).toString() +
          (attachmentVO.attachmentName).toString() +
          (attachmentVO.deleteStatus).toString());
      /*   saveAttachment(attachmentVO);*/
      String? token = preferences.getString("token");
      String attach = convert.jsonEncode(attachmentVO);
      File fileNew = File(result.files.first.path!);
      int sizeInBytes = fileNew.lengthSync();
      //int sizeInBytes = 9000000;
      attachmentVO.attachmentPath = result.files.first.path!;
      if (sizeInBytes < 4000000) {
        var res = await Api.saveWorkerAttachmentsTest(
            fileNew, attach, token!, result.files.first.name);
        var newResponse = await Response.fromStream(res);
        if (newResponse.statusCode == 200) {
          if (newResponse.body == 'success') {
            Fluttertoast.showToast(
              msg: StringsEn().attachmentUploadedSuccessfully,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RegistrationSupportingDocuments()));
          } else {
            Fluttertoast.showToast(
              msg: StringsEn().failedToUploadAttachment,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
            );
          }
        }
      } else {
        _validationAlertDialog(result.files.first.name.toString() +
            StringsEn().CannotBeSelectednMaxSize4MBAllowed);
      }
    }
  }

  //method to delete attachments
  Future<void> deleteWorkerAttachment(int attachmentId) async {
    //Get Token from SharedPreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");
    Map<String, String> headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    CommonFilterVo commonFilterVO = CommonFilterVo();
    commonFilterVO.attachmentId = attachmentId;
    String encodedData = convert.jsonEncode(commonFilterVO);
    var newResponse =
        await Api.deleteWorkerAttachmentTest(encodedData, headers);
    if (newResponse.statusCode == 200) {
      if (newResponse.body == 'true') {
        Fluttertoast.showToast(
          msg: "Attachment Deleted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegistrationSupportingDocuments()));
      } else {
        Fluttertoast.showToast(
          msg: StringsEn().failedToUploadAttachment,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    }
  }

  //alert dialog
  Future<void> _validationAlertDialog(String text) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => new AlertDialog(
              contentPadding: EdgeInsets.zero,
              title: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, top: 5.0, bottom: 10.0),
                    child: new Text(
                      StringsEn().validationAlert.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: new Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: AppDigits.fontSize),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                RegistrationSupportingDocuments()));
                  },
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
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
                      style: TextStyle(fontSize: AppDigits.fontSize),
                    ),
                  ),
                ),
              ),
            ));
  }
}
