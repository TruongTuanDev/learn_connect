import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/user_information//view/UserInterestsScreen.dart';

import '../view/LanguageInfoPage.dart';
class ContinueButton extends StatelessWidget {
  final Map<String, dynamic> formData;

  // Nhận formData từ UserInfoScreen
  ContinueButton({required this.formData});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LanguageInfoScreen()),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Tiếp tục', style: TextStyle(fontSize: 16)),
          SizedBox(width: 10),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(title, style: TextStyle(color: Colors.black)),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}