///Updated on 19/12/2022 by Arsha

import 'package:obocwwb/constants.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'components/sign_up_form.dart';

class SignUpScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // But still same problem, let's fixed it
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Create Account",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                children: [
                  Text("Already have an account?"),
                  TextButton(

                    onPressed: () =>

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          )),


                    child: Text(
                      "Sign In!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Text(
                "Add your phone number. we'll send you a verification code so we know you're real",
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              SignUpForm(formKey: _formKey, ),
            ],
          ),
        ),
      ),
    );
  }
}
