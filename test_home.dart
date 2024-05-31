///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:obocwwb/model/family_details.dart';
import 'package:obocwwb/model/nominee_details.dart';
import 'package:obocwwb/obocwwb_ui/applicant_application/applicant_application.dart';
import 'package:obocwwb/strings_en.dart';

import '../../constants.dart';

class HomeTest extends StatefulWidget {
  const HomeTest({Key? key}) : super(key: key);

  @override
  _HomeTestState createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest>
    with SingleTickerProviderStateMixin {
  List stateList = [];
  List districts = [];
  List blocks = [];
  String? value1;
  String? id;
  String? idForDistrictM;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsEn().homeApplication),
      ),
      body: ApplicantApplication(),
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
              fontSize: AppDigits.fontSize,
              fontWeight: FontWeight.bold)),
    ),
  );
}

subHeaderCard(String headerText) {
  return Container(
    width: double.infinity,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(headerText,
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
    ),
  );
}

textWithPadding(String text, Color colors) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 10.0),
    child: Text(text,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: colors)),
  );
}

textWithPaddingForProfile(String text, Color colors) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 15),
    child: Text(text,
        style: TextStyle(
            fontSize: AppDigits.fontSize,
            color: colors,
            fontWeight: FontWeight.w600)),
  );
}

textCard(
  String text,
) {
  return Text(
    text,
    style: TextStyle(
        color: AppColor.primaryColor,
        fontSize: AppDigits.titleSize,
        fontWeight: FontWeight.bold),
  );
}

textCardLite(String text) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black,
        fontSize: AppDigits.fontSize,
        fontWeight: FontWeight.w500),
  );
}

textCardLiteV1(String text) {
  return Text(
    text,
    style: TextStyle(
        fontSize: AppDigits.fontSize,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic),
  );
}

textWithoutPadding(String text, Color colors) {
  return Text(
    text,
    style: TextStyle(
        fontSize: AppDigits.fontSize,
        fontWeight: FontWeight.w500,
        color: colors),
  );
}

loadingCard(String text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(
          height: 20.0,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

textWithoutFontWeight(String text, Color colors) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: AppDigits.fontSize,
                fontWeight: FontWeight.normal,
                color: colors),
          ),
        ),
      ),
    ],
  );
}

textAddress(String text, Color colors) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_box_outline_blank, color: Colors.black),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.normal, color: colors),
            ),
          ),
        ),
      ],
    ),
  );
}

textWithTextField(TextInputType text, String hintText) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: TextFormField(
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter(RegExp("[0-9.]"), allow: true),
      ],
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
      ),
    ),
  );
}

textWithSuffix(TextInputType text, String hintText) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: TextFormField(
      keyboardType: text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black12),
            borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.file_upload,
            color: AppColor.primaryColor,
          ),
        ),
      ),
    ),
  );
}

// Initial Selected Value
String? blockValue;
String? districtValue;
String? stateValue;
String? dropdownValue3;
String? dropdownValueStateList;
String? dropdownValueDistrictList;
String? dropdownValueBlockLisPermanentAddressForMat;
String? dropdownValueStateListPresentAddress;
String? dropdownValueDistrictListPresentAddress;
String? dropdownValueBlockListPresentAddress;
String? dropdownValueBlockListPermanentAddressForMrg;
String? dropdownValueBlockListPresentAddressForMrg;

String? id;
String? id2;

// List of items in our dropdown menu
var items = [
  'DropDown 1',
  'DropDown 2',
  'DropDown 3',
  'DropDown 4',
  'DropDown 5',
];

stateListDropDownForMarriage(List stateList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueStateList,
      hint: Text(
        StringsEn().selectState,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: stateList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['stateName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        dropdownValueStateList = newValue!;
      },
    ),
  );
}

stateListDropDownForPresentMaternity(List districtList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueStateListPresentAddress,
      hint: Text(
        StringsEn().selectDistrict,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: districtList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['districtName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        dropdownValueStateListPresentAddress = newValue!;
      },
    ),
  );
}

stateListDropDown(List stateList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: stateValue,
      hint: Text(
        StringsEn().selectState,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: stateList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['stateName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        stateValue = newValue!;
        districtValue = null;
        blockValue = null;
        print(stateValue);
      },
    ),
  );
}

districtDropDownForPresentMarriage(List districtList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueDistrictListPresentAddress,
      hint: Text(
        StringsEn().selectDistrict,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: districtList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['districtName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        dropdownValueDistrictListPresentAddress = newValue!;
      },
    ),
  );
}

districtDropDownForMarriage(
  List districtList,
) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueDistrictList,
      hint: Text(
        StringsEn().selectDistrict,
        style: TextStyle(fontSize: 12.0),
      ),

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: districtList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['districtName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        id = newValue;
        dropdownValueDistrictList = newValue!;
      },
    ),
  );
}

districtDropDown(List districtList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: districtValue,
      hint: Text(
        StringsEn().selectDistrict,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: districtList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['districtName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        districtValue = newValue!;
        blockValue = null;
        print(districtValue);
      },
    ),
  );
}

blockDropDownForMarriagePresentAddress(List blockList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueBlockListPresentAddress,
      hint: Text(
        StringsEn().selectBlock,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: blockList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['blockName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        dropdownValueBlockListPresentAddress = newValue!;
      },
    ),
  );
}

blockDropDown(List blockList, StateSetter state) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: blockValue,
      hint: Text(
        StringsEn().selectBlock,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: blockList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['blockName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        blockValue = newValue!;
      },
    ),
  );
}

blockDropDownForMarriagePresentAddressForMrg(List blockList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueBlockListPresentAddressForMrg,
      hint: Text(
        StringsEn().selectBlock,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: blockList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['blockName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        dropdownValueBlockListPresentAddressForMrg = newValue!;
      },
    ),
  );
}

blockDropDownForMarriagePermanentAddressAddressForMrg(List blockList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: dropdownValueBlockListPermanentAddressForMrg,
      hint: Text(
        StringsEn().selectBlock,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: blockList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['blockName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        dropdownValueBlockListPermanentAddressForMrg = newValue!;
      },
    ),
  );
}

ulbDropDown(List ulbList) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, bottom: 5.0, right: 10.0),
    child: DropdownButton<String>(
      // Initial Value
      value: blockValue,
      hint: Text(
        StringsEn().selectBlock,
        style: TextStyle(fontSize: 12.0),
      ),
      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      // Array list of items
      items: ulbList.map((item) {
        return DropdownMenuItem(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(item['ulbName'].toString()),
          ),
          value: item['id'].toString(),
        );
      }).toList(),
      // After selecting the desired option,it will
      // change button value to selected value
      onChanged: (String? newValue) {
        blockValue = newValue!;
      },
    ),
  );
}

class MyWidget {
  List<FamilyDetailsVO> strFamilyDetailsList = [
    FamilyDetailsVO(1, "fam mem 1", 1541257894, "02-12-92", "Son"),
    FamilyDetailsVO(2, "fam mem 2", 5556664879, "02-12-92", "Daughter")
  ];
  List<NomineeDetailsVO> strNomineeDetailsList = [
    NomineeDetailsVO(1, "fam mem 1", 1541257894, "abc", "02-12-1992", "Son", 50,
        "State Bank of India", "Azara", "SBIN000036", 9508459730, 123456789012),
    NomineeDetailsVO(
        2,
        "fam mem 2",
        1541257235,
        "xyz",
        "02-12-1990",
        "Daughter",
        50,
        "State Bank of India",
        "Azara",
        "SBIN000036",
        9508459730,
        123456789012)
  ];
  //application details
  card1ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().applicationDetails),
            Row(
              children: [
                textWithPadding(
                    StringsEn().areYouAaRegisteredMember, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            Row(
              children: [
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
                        StringsEn().yes,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        StringsEn().no,
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

  //application details
  card2ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().applicationDetails),
            //First Name
            Row(
              children: [
                textWithPadding(StringsEn().firstName, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourFirstName),

            //Surname
            Row(
              children: [
                textWithPadding(StringsEn().surName, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourSurnameName),

            //Sex
            Row(
              children: [
                textWithPadding(StringsEn().sex, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /* dropDown(),*/

            //Aadhaar Linked Mobile Number
            Row(
              children: [
                textWithPadding(
                    StringsEn().aadhaarLinkedMobileNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourAadhaarLinkedMobileNumber),

            //Aadhaar Number
            Row(
              children: [
                textWithPadding(StringsEn().aadhaarNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourAadhaarNumber),

            //Date of Birth
            Row(
              children: [
                textWithPadding(StringsEn().dateOfBirth, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourDateOfBirth),

            //Father Name
            Row(
              children: [
                textWithPadding(StringsEn().fatherName, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourFatherName),

            //Martial Status
            Row(
              children: [
                textWithPadding(StringsEn().maritalStatus, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*     dropDown(),*/

            //Spouse's Name
            Row(
              children: [
                textWithPadding(StringsEn().spouseName, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourSpousesName),

            //Nature of work
            Row(
              children: [
                textWithPadding(StringsEn().natureOfWork, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*   dropDown(),*/

            //Educational details
            Row(
              children: [
                textWithPadding(StringsEn().educationalDetails, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourEducationalDetails),

            //Training details (if any)
            Row(
              children: [
                textWithPadding(StringsEn().trainingDetailsIfAny, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourTrainingDetailsIfAny),

            //Are you a migrant worker ?
            Row(
              children: [
                textWithPadding(StringsEn().areYouAMigrantWorker, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    /*onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => NavigationHomeScreen()),
                        );
                      },*/
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
                        StringsEn().yes,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        StringsEn().no,
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

  //Address details
  card3ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().addressDetails),

            subHeaderCard(StringsEn().permanentAddress),
            //Address
            Row(
              children: [
                textWithPadding(StringsEn().address, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourAddress),

            //State
            Row(
              children: [
                textWithPadding(StringsEn().state, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*     dropDown(),*/

            //District
            Row(
              children: [
                textWithPadding(StringsEn().district, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),

            //Block/ULB
            Row(
              children: [
                textWithPadding(StringsEn().blockOrUlb, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourBlockUlb),

            //Gram Panchayat
            Row(
              children: [
                textWithPadding(StringsEn().gramPanchayat, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourGramPanchayat),

            //Village
            Row(
              children: [
                textWithPadding(StringsEn().village, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourVillage),

            //Pincode
            Row(
              children: [
                textWithPadding(StringsEn().pincode, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourPincode),

            subHeaderCard(StringsEn().presentAddress),

            //declaration 2
            textAddress(StringsEn().checkIfPresentAddressSameAsPermanentAddress,
                Colors.black),

            //Address
            Row(
              children: [
                textWithPadding(StringsEn().address, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourAddress),

            //District
            Row(
              children: [
                textWithPadding(StringsEn().district, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),

            //Block/ULB
            Row(
              children: [
                textWithPadding(StringsEn().blockOrUlb, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*    dropDown(),*/

            //Gram Panchayat
            Row(
              children: [
                textWithPadding(StringsEn().gramPanchayat, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourGramPanchayat),

            //Village
            Row(
              children: [
                textWithPadding(StringsEn().village, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourVillage),

            //Pincode
            Row(
              children: [
                textWithPadding(StringsEn().pincode, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourPincode),
          ],
        ),
      ),
    );
  }

  //Family & Nominee details
  card4ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().familyAndNomineeDetails),
            subHeaderCard(StringsEn().familyDetails),
            //Name
            Row(
              children: [
                textWithPadding(StringsEn().name, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourName),

            //Aadhaar Number
            Row(
              children: [
                textWithPadding(StringsEn().aadhaarNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourAadhaarNumber),

            //Date of Birth
            Row(
              children: [
                textWithPadding(StringsEn().dateOfBirth, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourDateOfBirth),

            //Relationship
            Row(
              children: [
                textWithPadding(StringsEn().relationship, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
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
                      StringsEn().addMember,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            subHeaderCard(StringsEn().listOfFamilyDetails),

            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: strFamilyDetailsList.length,
              //itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strFamilyDetailsList[index].id.toString() + ". ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      strFamilyDetailsList[index]
                                              .name!
                                              .toUpperCase() +
                                          ". ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "( " +
                                          strFamilyDetailsList[index]
                                              .relationship! +
                                          " )",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().aadhaarNo,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strFamilyDetailsList[index]
                                          .aadhaarNumber!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().dateofBirth,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strFamilyDetailsList[index]
                                          .dateOfBirth!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Divider(height: 0.1, color: Colors.grey[600]),
                );
              },
            ),

            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: new Divider(height: 0.1, color: Colors.grey[600]),
            ),

            //Nominee Details
            subHeaderCard(StringsEn().nomineeDetails),

            //Name
            Row(
              children: [
                textWithPadding(StringsEn().name, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourName),

            //Aadhaar number
            Row(
              children: [
                textWithPadding(StringsEn().aadhaarNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourAadhaarNumber),

            //Address
            Row(
              children: [
                textWithPadding(StringsEn().address, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourAddress),

            //Date of Birth
            Row(
              children: [
                textWithPadding(StringsEn().dateOfBirth, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourDateOfBirth),

            //Relationship
            Row(
              children: [
                textWithPadding(StringsEn().relationship, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /* dropDown(),*/

            //Share in percentage
            Row(
              children: [
                textWithPadding(StringsEn().shareInPercentage, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourShareInPercentage),

            //Bank Name
            Row(
              children: [
                textWithPadding(StringsEn().bankName, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*dropDown(),*/

            //Name of Branch
            Row(
              children: [
                textWithPadding(StringsEn().nameOfBranch, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourNameOfBranch),

            //IFSC
            Row(
              children: [
                textWithPadding(StringsEn().ifsc, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourIFSC),

            //Aadhaar linked bank account number
            Row(
              children: [
                textWithPadding(
                    StringsEn().aadhaarLinkedBankAccountNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourAadhaarLinkedBankAccountNumber),

            //Confirm bank account number
            Row(
              children: [
                textWithPadding(
                    StringsEn().confirmBankAccountNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourConfirmBankAccountNumber),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
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
                      StringsEn().addDetails,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.0),

            subHeaderCard(StringsEn().listOfNomineeDetails),

            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: strNomineeDetailsList.length,
              //itemCount: 3,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            strNomineeDetailsList[index].id.toString() + ". ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      strNomineeDetailsList[index]
                                              .name!
                                              .toUpperCase() +
                                          ". ",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "( " +
                                          strNomineeDetailsList[index]
                                              .relationship! +
                                          " )",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().accountNo,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strNomineeDetailsList[index]
                                          .confirmBankAccountNumber!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().aadhaarNo,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strNomineeDetailsList[index]
                                          .aadhaarNumber!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().dateofBirth,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strNomineeDetailsList[index]
                                          .dateOfBirth!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().shareInPercentages,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strNomineeDetailsList[index]
                                              .shareInPercentage!
                                              .toString() +
                                          " %",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      StringsEn().address1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                      strNomineeDetailsList[index]
                                          .address!
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_right),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: new Divider(height: 0.1, color: Colors.grey[600]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  //Details of the establishment(s) where the applicant worked during last one year
  card5ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn()
                .detailsOfTheEstablishmentsWhereTheApplicantWorkedDuringLastOneYear),
            //Name of Organization/Office
            Row(
              children: [
                textWithPadding(
                    StringsEn().nameOfOrganizationOffice, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourNameOfOrganizationOffice),
            //Registration Number
            Row(
              children: [
                textWithPadding(StringsEn().registrationNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourRegistrationNumber),
            //Contact Number
            Row(
              children: [
                textWithPadding(StringsEn().contactNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourContactNumber),
            //Whether the Establishment is Govt/Private
            Row(
              children: [
                textWithPadding(
                    StringsEn().whetherTheEstablishmentIsGovtPrivate,
                    Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*   dropDown(),*/
            //Nature of job
            Row(
              children: [
                textWithPadding(StringsEn().natureOfJob, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourNatureOfJob),
            //State
            Row(
              children: [
                textWithPadding(StringsEn().state, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*   dropDown(),*/
            //District
            Row(
              children: [
                textWithPadding(StringsEn().district, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*   dropDown(),*/
            //Block/ULB
            Row(
              children: [
                textWithPadding(StringsEn().blockOrUlb, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourBlockUlb),
            //Gram Panchayat
            Row(
              children: [
                textWithPadding(StringsEn().gramPanchayat, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourGramPanchayat),
            //Village
            Row(
              children: [
                textWithPadding(StringsEn().village, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourVillage),
            //Pincode
            Row(
              children: [
                textWithPadding(StringsEn().pincode, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourPincode),
            //Period from
            Row(
              children: [
                textWithPadding(StringsEn().periodFrom, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourPeriodFrom),
            //Period upto
            Row(
              children: [
                textWithPadding(StringsEn().periodUpTo, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourPeriodUpTo),
          ],
        ),
      ),
    );
  }

  //Other details
  card6ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().otherDetails),
            //Ration Card Details
            Row(
              children: [
                textWithPadding(StringsEn().rationCardDetails, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*  dropDown(),*/
            //NFSA or SFSS Card No. (If available)
            Row(
              children: [
                textWithPadding(
                    StringsEn().nFSAOrSFSSCardNoIfAvailable, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourNFSAOrSFSSCardNoIfAvailable),
            //Category
            Row(
              children: [
                textWithPadding(StringsEn().category, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*   dropDown(),*/
            //Religion
            Row(
              children: [
                textWithPadding(StringsEn().religion, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /* dropDown(),*/
            //Physically challenged
            Row(
              children: [
                textWithPadding(StringsEn().physicallyChallenged, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*dropDown(),*/
          ],
        ),
      ),
    );
  }

  //Bank details
  card7ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().bankDetails),
            //Bank Name
            Row(
              children: [
                textWithPadding(StringsEn().bankName, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            /*    dropDown(),*/
            //Name of Branch
            Row(
              children: [
                textWithPadding(StringsEn().nameOfBranch, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(
                TextInputType.text, StringsEn().enterYourNameOfBranch),
            //IFSC
            Row(
              children: [
                textWithPadding(StringsEn().ifsc, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().enterYourIFSC),
            //Aadhaar Linked Bank Account Number
            Row(
              children: [
                textWithPadding(
                    StringsEn().aadhaarLinkedBankAccountNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourAadhaarLinkedBankAccountNumber),
            //Confirm bank account number
            Row(
              children: [
                textWithPadding(
                    StringsEn().confirmBankAccountNumber, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text,
                StringsEn().enterYourConfirmBankAccountNumber),
          ],
        ),
      ),
    );
  }

  //Supporting Documents
  card8ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().supportingDocuments),
            SizedBox(height: 10.0),
            //Bank Passbook Front Page Copy
            textWithSuffix(
                TextInputType.text, StringsEn().bankPassbookFrontPageCopy),
            //Passport Size Photo
            textWithSuffix(TextInputType.text, StringsEn().passportSizePhoto),
            //Aadhaar Card
            textWithSuffix(TextInputType.text, StringsEn().aadhaarCard),
            //Signature of Applicant
            textWithSuffix(
                TextInputType.text, StringsEn().signatureOfApplicant),
            //Employment Certificate
            textWithSuffix(
                TextInputType.text, StringsEn().employmentCertificate),
          ],
        ),
      ),
    );
  }

  //Payment details
  card9ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().paymentDetails),
            //Total Amount
            Row(
              children: [
                textWithPadding(StringsEn().totalAmount, Colors.black),
                textWithoutPadding("*", Colors.red),
              ],
            ),
            textWithTextField(TextInputType.text, StringsEn().totalAmount),
            //space
            SizedBox(
              height: 10.0,
            ),
            //Pay- Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                        StringsEn().payNow,
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

  //Declarations
  card10ApplicationDetails() {
    return Card(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerCard(StringsEn().declarations),
            //declaration 1
            textWithoutFontWeight(
                "I hereby declare that I have not been enrolled my name in any other district/state as beneficiary under Building & Other Construction Worker Worker [RE & CS] Rule 2002.",
                Colors.black),
            //declaration 2
            textWithoutFontWeight(
                "I hereby declare that I am not an registered number of EPFO & ESIC.",
                Colors.black),
            //declaration 3
            textWithoutFontWeight(
                "I hereby declare that I am not a member of any of the welfare fund established under any law for the time being in force [U/S 264 of OB&OCW (RE & CS)] Rule 2002.",
                Colors.black),
            //declaration 4
            textWithoutFontWeight(
                "I hereby declare that the particular given above are true to the best of my knowledge & belief.",
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
                        StringsEn().save.toUpperCase(),
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
                        StringsEn().submit.toUpperCase(),
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
                        StringsEn().preview.toUpperCase(),
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
