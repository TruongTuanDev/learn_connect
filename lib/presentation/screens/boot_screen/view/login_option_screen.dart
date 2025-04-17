import 'dart:io';

import 'package:flutter/material.dart';
import 'package:learn_connect/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 50, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Chào mừng Toàn",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Hãy học thật tốt nhé!!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                const CircularProgressIndicator(),

              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.7;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // Logo section
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          width: screenWidth * 0.4,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Bridge to English',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue.shade900,
                          ),
                        ),
                        const Text(
                          'Learn From Home',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    const Text(
                      'Cho phép bạn tiếp tục với',
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),

                    const SizedBox(height: 20),

                    // Google Button
                    SizedBox(
                      width: buttonWidth,
                      child: OutlinedButton(
                        onPressed: () => _showPopup(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/800px-Google_%22G%22_logo.svg.png',
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Tiếp tục với Google',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Facebook Button
                    SizedBox(
                      width: buttonWidth,
                      child: OutlinedButton(
                        onPressed: () => _showPopup(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/2023_Facebook_icon.svg/2048px-2023_Facebook_icon.svg.png',
                              height: 24,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Tiếp tục với Facebook',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                    const Text(
                      'Hoặc',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),

                    const SizedBox(height: 20),

                    // Đăng nhập
                    SizedBox(
                      width: buttonWidth,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.signin);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade900,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Đăng nhập tài khoản',
                              style: TextStyle(fontSize: 16, color: Colors.white),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // Đăng ký link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Bạn chưa có tài khoản? ',
                            style: TextStyle(color: Colors.black87)),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Đăng ký',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
