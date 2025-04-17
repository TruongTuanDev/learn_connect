import 'package:flutter/material.dart';
import '../../../../routes/routes.dart';
import '../widgets/signin_form.dart';
import '../widgets/social_login_buttons.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F9FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/Logo.png', height: 100),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bridge to English',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                      Text(
                        'LEARN FROM HOME',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 60),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hãy đăng nhập',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 30),
              SignInForm(), // Form nhập liệu
              SizedBox(height: 10),
              Text('Hoặc'),
              SizedBox(height: 10),
              SocialLoginButtons(), // Các nút đăng nhập social
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bạn chưa có tài khoản? '),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                    child: Text('Đăng ký', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
