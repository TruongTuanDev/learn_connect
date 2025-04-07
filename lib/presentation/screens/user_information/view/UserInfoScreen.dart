import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/user_information//widgets/ProfileAvatar.dart';
import 'package:learn_connect/presentation/screens/user_information//widgets/ContinueButton.dart';
import 'package:learn_connect/presentation/screens/user_information//widgets/UserInfoForm.dart';
class UserInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Thông tin'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(),
            SizedBox(height: 20),
            UserInfoForm(),
            SizedBox(height: 20),
            ContinueButton(),
          ],
        ),
      ),
    );
  }
}
