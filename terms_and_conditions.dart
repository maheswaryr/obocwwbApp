///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/auth/sign_in_screen.dart';
import 'package:obocwwb/auth/sign_up_screen.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/strings_en.dart';

class TermsAndConditions extends StatefulWidget {
  const TermsAndConditions({Key? key}) : super(key: key);

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  bool? secondCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(StringsEn()
              .termsAndConditions),
          backgroundColor: AppColor.primaryColor
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            headerCard("Eligibility criteria for registration of construction workers under Odisha Building & Other Construction Workers Welfare Board"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                      child: Text("1. Must be engaged as a 'building worker' in building or other construction work as defined U/s. 2(1)(d) of the Building & Other Construction Workers' (RE&CS) Act, 1996 and Notification No.5654 dtd.27.06.2009 and No.5985 dtd.28.07.2014 of the Labour & ESI Deptt., Govt. of Odisha for not less than 90 days during the preceding 12 months.",
                      style: TextStyle(fontSize: AppDigits.fontSize),)),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("2. Not engaged in any building or other construction work to which the provisions of the Factories Act, 1948 or the Mines Act., 1952 apply.",
                        style: TextStyle(fontSize: AppDigits.fontSize),),
                    ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("3. Completed 18 years of age, but not completed 60 years of age.",
                        style: TextStyle(fontSize: AppDigits.fontSize),)))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("4. Not a member of any other Welfare Fund established under any law.",
                        style: TextStyle(fontSize: AppDigits.fontSize),),
                    ))
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("5. I am eligible to become a member of OB&OCWW Board as per the above criteria and voluntarily declare that I am a genuine building/other construction worker as per the terms and conditions as mentioned above. I have not enrolled my name in any other district of Odisha or any other State of the country as beneficiary in any Welfare Board.",
                        style: TextStyle(fontSize: AppDigits.fontSize),),
                    ))
              ],
            ),
            CheckboxListTile(
              title: Text("I agree with the Terms & Conditions",style: TextStyle(fontSize: AppDigits.fontSize),),
              value: secondCheck, onChanged: (bool? value){
              setState(() {
                secondCheck = value;
              });

            },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            Expanded(child: SizedBox()),
            secondCheck!? Row(
              children: [

                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInScreen()));
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.red),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Close',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                    },
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(AppColor.primaryColor),
                      shape:
                      MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        'Proceed',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ):
            Align(alignment: Alignment.bottomCenter, child: Text('Click the check box')),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
  headerCard(String headerText) {
    return Container(
      width: double.infinity,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(headerText,
              style: TextStyle(
                color:Colors.black,
                fontSize: AppDigits.titleSize,
              )),
        ),
      ),
    );
  }
}
