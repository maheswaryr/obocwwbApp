///Created by Maheswary
///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';
import 'package:obocwwb/constants.dart';
import 'package:obocwwb/obocwwb_ui/profile_page/profile_page_form.dart';
import 'package:obocwwb/strings_en.dart';

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({Key? key}) : super(key: key);

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  late bool onPressedEnglish = false;
  late bool onPressedHindi = false;
  late bool onPressedOdiya = false;

  @override
  Widget build(BuildContext context) {
    alertLangBox() async{
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(StringsEn().applyLanguageChanges,style: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.w800),),
          content: Text(StringsEn().appWillRestart),
          actions: [
            TextButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePageForm())),
              child: Text(
                'OK',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ) ??
          false;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Language",
        ),
        backgroundColor: AppColor.primaryColor,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 3.0,
        mainAxisSpacing: 3.0,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      onPressedEnglish = !onPressedEnglish;
                      onPressedHindi = false;
                      onPressedOdiya = false;
                    });
                    alertLangBox();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:Alignment.centerRight,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Icon(Icons.check_circle,
                                            color: (onPressedEnglish)
                                                ? Colors.green
                                                : Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFFCFD8DC),
                                        child: Text(
                                          'A',
                                          style: TextStyle(
                                              color: AppColor().blue,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text('English',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      onPressedOdiya = !onPressedOdiya;
                      onPressedEnglish = false;
                      onPressedHindi = false;
                    });
                    alertLangBox();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Icon(Icons.check_circle,
                                            color: (onPressedOdiya)
                                                ? Colors.green
                                                : Colors.grey)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFFFCE4EC),
                                        child: Text(
                                          'ଅ',
                                          style: TextStyle(
                                              color: Color(0xFFF06292),
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text('Odia',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsets.only( left: 40, right: 40),
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      onPressedHindi = !onPressedHindi;
                      onPressedEnglish = false;
                      onPressedOdiya = false;
                    });
                    alertLangBox();
                  },
                  child: Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Icon(Icons.check_circle,
                                            color: (onPressedHindi)
                                                ? Colors.green
                                                : Colors.grey)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: CircleAvatar(
                                        backgroundColor: Color(0xFFE8F5E9),
                                        child: Text(
                                          'अ',
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.w600),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text('Hindi',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
