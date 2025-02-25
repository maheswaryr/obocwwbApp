import 'package:flutter/material.dart';

class TimeErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/16_Time Error.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.14,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 25,
                    color: Color(0xFF59618B).withOpacity(0.37),
                  ),
                ],
              ),
              child: TextButton(
                /*color: Color(0xFF6371AA),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),*/
                onPressed: () {},
                child: Text(
                  "Retry".toUpperCase(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
