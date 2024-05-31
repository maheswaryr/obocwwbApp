///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/model/marriage_model/application_detail_vo.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/ragistration%20_number.dart';
import 'package:obocwwb/obocwwb_ui/funeral_expenses/ragistration_number_funeral.dart';
import 'package:obocwwb/obocwwb_ui/terms_and_conditions.dart';

import '../constants.dart';
import '../strings_en.dart';
import 'components/sign_in_form.dart';

class SignInScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  ApplicationDetailVo initiate = ApplicationDetailVo();
  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Return',style: TextStyle(fontSize: AppDigits.titleSize),),
          content: Text(StringsEn().doYouReallyWantToExit,style: TextStyle(fontSize: AppDigits.fontSize),),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'No',
                style: TextStyle(color: Colors.black,fontSize: AppDigits.fontSize),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInScreen /*WelcomePage*/ (),
                ),
              ),
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.black,fontSize: AppDigits.fontSize),
              ),
            ),
          ],
        ),
      ) ??
          false;
    }
    // But still same problem, let's fixed it
    return WillPopScope(
      onWillPop: showExitPopup ,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: AppDigits.defaultPadding,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign In",
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TermsAndConditions(),
                        ),
                      ),
                      child: Text(
                        "Sign Up!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppDigits.defaultPadding),
                Container(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    'assets/images/nirmansramik.png',
                  ),
                ),
                SizedBox(height: AppDigits.defaultPadding * 2),
                SignInForm(formKey: _formKey, ),
                SizedBox(height: AppDigits.defaultPadding * 2),

                Align(
                  alignment: Alignment.centerRight,
                  child:  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FuneralRegistrationNumberPage(),
                      ),
                    ),
                    child: Text(
                      "[Apply for Grant of Funeral Expenses]",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child:  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeathRegistrationNumberPage(),
                      ),
                    ),
                    child: Text(
                      "[Apply for Death Benefit]",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child:  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TermsAndConditions(),
                      ),
                    ),
                    child: Text(
                      "[Pay Annual Contribution]",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
