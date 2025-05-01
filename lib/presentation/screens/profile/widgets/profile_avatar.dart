import 'package:flutter/material.dart';
class ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.grey[300],
      child: Icon(Icons.face, color: Colors.grey[600]),
    );
  }
}