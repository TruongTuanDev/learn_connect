import 'package:flutter/material.dart';
class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey.shade300,
      child: Icon(Icons.edit, color: Colors.green),
    );
  }
}