///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'applicant_application_details_1_form.dart';

class ApplicantApplication extends StatefulWidget {
  const ApplicantApplication({Key? key}) : super(key: key);

  @override
  ApplicantApplicationState createState() => ApplicantApplicationState();
}

class ApplicantApplicationState extends State<ApplicantApplication> {

  @override
  Widget build(BuildContext context) {
    return ApplicantApplicationDetails1Form();
  }
}
