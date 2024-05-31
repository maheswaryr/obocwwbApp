///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/custom_widgets/custom_TextField.dart';
import 'package:obocwwb/custom_widgets/custom_container.dart';

import 'package:obocwwb/custom_widgets/custom_text.dart';

import 'package:obocwwb/obocwwb_ui/death_benefit/address_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/death_benefit/nominee_details_death_benefits.dart';
import 'package:obocwwb/obocwwb_ui/home/home_page.dart';

import '../../constants.dart';
import '../../model/application_detail_vo.dart';
import '../../strings_en.dart';


class SubscriptionDetailsDeathBenefitsForm extends StatefulWidget {
  ApplicationDetailVo initiate = ApplicationDetailVo();
  SubscriptionDetailsDeathBenefitsForm({required this.initiate}) : super();

  @override
  SubscriptionDetailsDeathBenefitsFormState createState() =>
      SubscriptionDetailsDeathBenefitsFormState();
}

class SubscriptionDetailsDeathBenefitsFormState
    extends State<SubscriptionDetailsDeathBenefitsForm> {
  //Date of payment of first subscription amount
  TextEditingController _textEditingController1 = TextEditingController();
  //Date of Payment of last subscription amount
  TextEditingController _textEditingController2 = TextEditingController();
  //Total amount of subscription
  TextEditingController _textEditingController3 = TextEditingController();
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
              Expanded(
                child: SingleChildScrollView(
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         headerCard(StringsEn().subscriptionDetails),
                          SizedBox(height: 10.0),
                          //Date of Payment of first subscription amount
                          MyCustomTextField().readOnlyText(
                              TextInputType.datetime,
                              StringsEn().dateOfPaymentOfFirstSubscriptionAmount,
                           ""),
                          SizedBox(
                            height: AppDigits.size,
                          ),

                          //Date of Payment of last subscription amount
                          MyCustomTextField().readOnlyText(
                            TextInputType.datetime,
                            StringsEn().dateOfPaymentOfLastSubscriptionAmount,
                          "",
                          ),
                          SizedBox(
                            height: AppDigits.size,
                          ),

                          //Total amount of subscription
                          MyCustomTextField().readOnlyText(
                            TextInputType.number,
                            StringsEn().totalAmountOfSubscription,
                            "",
                          ),

                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              MyCustomText().textInformation(),
              MyCustomContainer().getBottomLayout(
                context,
                AddressDetailsDeathBenefitsForm(initiate: widget.initiate),
                NomineeDetailsDeathBenefitsForm(initiate: widget.initiate),
                "3",
              ),
            ],
          ),
        ),
      ),
    );
  }

  getFetch() {}

  getSave() {

    String ec_1 = _textEditingController1.text.toString();
    String ec_2 = _textEditingController2.text.toString();
    String ec_3 = _textEditingController3.text.toString();

    print(ec_1 + " " + ec_2 + " " + ec_3);
  }
}
