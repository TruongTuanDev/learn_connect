import 'package:flutter/material.dart';
class UserProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 34),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              width: 120,
              height: 120,
              child: Image.network(
                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/472661bb-3649-4313-b7eb-3f9639040991",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Text(
                "Truc",
                style: TextStyle(
                  color: Color(0xFF202244),
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 11),
              child: Text(
                "Co pé ngây thơ",
                style: TextStyle(
                  color: Color(0xFF545454),
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}