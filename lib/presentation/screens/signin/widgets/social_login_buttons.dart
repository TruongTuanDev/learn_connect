import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(8),
            child: Image.asset('assets/google.png', width: 40, height: 40),
          ),
        ),
        SizedBox(width: 10),
        InkWell(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: EdgeInsets.all(8),
            child: Image.asset('assets/apple.png', width: 40, height: 40),
          ),
        ),
      ],
    );
  }
}
