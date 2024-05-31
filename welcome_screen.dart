import 'package:obocwwb/auth/sign_up_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
              child: Column(
                children: [
                  Spacer(),
                  Image.asset(
                    'assets/images/illustration-1.png',
                    width: 240,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Odisha Building & Other Construction Worker's Welfare Board",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: AppDigits.titleSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Never a better time than now to start.",
                    style: TextStyle(
                      fontSize: AppDigits.fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black38,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  // As you can see we need more padding on our btn
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(

                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor:
                        MaterialStateProperty.all<Color>(AppColor.primaryColor),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(AppDigits.defaultPadding),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(fontSize: AppDigits.fontSize),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: AppDigits.defaultPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            )),
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(AppColor.primaryColor),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(AppDigits.defaultPadding),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: AppDigits.fontSize),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppDigits.defaultPadding),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
