///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/strings_en.dart';

import 'applicant_application/test_home.dart';

class RegistrationDeclarationForm extends StatefulWidget {
  const RegistrationDeclarationForm({Key? key}) : super(key: key);

  @override
  State<RegistrationDeclarationForm> createState() => _RegistrationDeclarationFormState();
}

class _RegistrationDeclarationFormState extends State<RegistrationDeclarationForm> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(StringsEn()
            .declarationForm),
        backgroundColor: AppColor.primaryColor,
      ),
      body:  Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: SingleChildScrollView(
                  child: MyWidget().card10DeclarationForm(),
                )),
          ],
        ),
      ),
    );
  }
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

class MyWidget {
  //Declaration form
  card10DeclarationForm() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            headerCard(StringsEn().declaration),
            //declaration
            textWithoutFontWeight(
                "I am aware that if a person enter Aadhaar number of any other person and attempt to impersonate another person, dead or alive, real or imaginary, he/she shall be punishable with imprisonment for a term which may extend up to three years and shall also be liable to a fine which may extend to ten thousand rupees as per provisions of Aadhaar act.",
                Colors.black),
            textWithoutFontWeight(
                "I hereby declare that my application will be rejected if it is found that I have provided wrong Aadhaar number or Aadhaar number of someone else’s.",
                Colors.black),
            textWithoutFontWeight(
                "I hereby declare that for ank account details by me, the OB&OCWW Board will not be responsible for mis-credit and I will be held responsible for the same.",
                Colors.black),
            textWithoutFontWeight(
                "I hereby declare that the particulars given above are true to the best of my knowledge and belief. ",
                Colors.black),
            //space
            SizedBox(
              height: 10.0,
            ),
            //Save, Submit, Preview- Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Save- Button
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},

                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Save'.toUpperCase(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                //Submit- Button
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},

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
                        'Submit'.toUpperCase(),
                        style: TextStyle(fontSize: 16),
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
                        'Preview'.toUpperCase(),
                        style: TextStyle(fontSize: 16),
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

}