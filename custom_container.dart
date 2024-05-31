///Updated on 19/12/2022 by Arsha

import 'package:flutter/material.dart';

import '../constants.dart';

class MyCustomContainer {
  getBottomLayout(BuildContext context, Widget pageBack, Widget pageNext, String pageNo) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: Colors.black12)),
      child: Row(
        children: [
          pageBack == 0
              ? getDefaultButtonWidget(context)
              : getBackButtonWidget(context, pageBack),
          getPageNo(pageNo),
          pageNext == 0
              ? getDefaultButtonWidget(context)
              : getNextButtonWidget(context, pageNext),
        ],
      ),
    );
  }

  getBackButtonWidget(BuildContext context, Widget page) {
    return Expanded(
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page),
            );
          },
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColor.primaryColor),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Row(
              children: [
                Icon(Icons.arrow_back, size: AppDigits.titleSize),

                Text('Previous', style: TextStyle(fontSize: AppDigits.titleSize)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getPageNo(String pageNo){
    return SizedBox(
      width: 100.0,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.blue[200],
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            pageNo,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }

  getNextButtonWidget(BuildContext context, Widget page) {
    return Expanded(
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => page),
            );
          },
          style: ButtonStyle(
            foregroundColor:
                MaterialStateProperty.all<Color>(AppColor.primaryColor),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Next', style: TextStyle(fontSize: AppDigits.titleSize)),
                SizedBox(width: 5.0),
                Icon(Icons.arrow_forward, size: AppDigits.titleSize),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getDefaultButtonWidget(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(
                AppColor.primaryColor.withOpacity(0.5)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Row(
              children: [
                Icon(Icons.close, size: 16.0),
                SizedBox(width: 5.0),
                Text('No page Display', style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
