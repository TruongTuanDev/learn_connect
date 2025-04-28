import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/user_information/widgets/ProfileAvatar.dart';
import 'package:learn_connect/presentation/screens/user_information/widgets/ContinueButton.dart';
import 'package:learn_connect/presentation/screens/user_information/widgets/UserInfoForm.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  Map<String, dynamic> formData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    final args = ModalRoute.of(context)?.settings.arguments;

    print("in cái args xem:+ $args" );

    // Chỉ set khi chưa có formData (tránh overwrite khi rebuild)
    if (formData.isEmpty) {
      setState(() {
        formData = {'username' :args }; // giữ lại tất cả, bao gồm username
      });
    }
  }

  void onFormDataChanged(Map<String, dynamic> updatedFormFields) {
    setState(() {
      formData = {
        ...formData, // giữ username và các field cũ
        ...updatedFormFields, // cập nhật field mới
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print("✅ formData bao gồm username: $formData");

    return Scaffold(
      appBar: CustomAppBar(title: 'Thông tin'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileAvatar(),
            SizedBox(height: 20),
            UserInfoForm(onFormDataChanged: onFormDataChanged),
            SizedBox(height: 20),
            ContinueButton(formData: formData),
          ],
        ),
      ),
    );
  }
}
