import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false; // Thêm biến riêng cho "Nhập lại mật khẩu"

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
                  Image.asset(
                    'assets/Logo.png',
                    height: 100,
                  ),
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
              TextField(
                decoration: InputDecoration(
                  labelText: 'Tên người dùng',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                    child: Icon(
                      isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: !isConfirmPasswordVisible, // Sử dụng biến riêng cho "Nhập lại mật khẩu"
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isConfirmPasswordVisible = !isConfirmPasswordVisible;
                      });
                    },
                    child: Icon(
                      isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  Text('Nhớ đăng nhập'),
                  Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('Quên mật khẩu?'),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        'Đăng nhập',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.arrow_forward, color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text('Hoặc'),
              SizedBox(height: 10),
              Row(
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
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bạn chưa có tài khoản? '),
                  TextButton(
                    onPressed: () {},
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
