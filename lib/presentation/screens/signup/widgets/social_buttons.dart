import 'package:flutter/material.dart';

class SocialButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          child: Image.asset('assets/google.png', width: 40, height: 40),
        ),
        SizedBox(width: 20),
        InkWell(
          onTap: () {},
          child: Image.asset('assets/apple.png', width: 40, height: 40),
        ),
      ],
    );
  }
}
