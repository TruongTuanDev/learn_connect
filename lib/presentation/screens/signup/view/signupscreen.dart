import 'package:flutter/material.dart';
import '../widgets/signup_form.dart';
import '../widgets/social_buttons.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 20,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/Logo.png', height: 70),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bridge to English',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.blue)),
                    Text('LEARN FROM HOME',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            SignUpForm(),  // Form nhập liệu
            SizedBox(height: 20),
            Text('Hoặc',
                style: TextStyle(color: Color(0xFF545454), fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            SocialButtons(),  // Các nút đăng ký bằng Google, Apple
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bạn đã có tài khoản? '),
                TextButton(
                  onPressed: () {},
                  child: Text('Đăng nhập', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
