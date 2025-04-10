import 'package:flutter/material.dart';
import 'dart:async';
import 'package:learn_connect/presentation/screens/boot_screen/view/login_option_screen.dart';
import 'package:learn_connect/routes/routes.dart';

class BootScreenApp extends StatefulWidget {
  const BootScreenApp({super.key});

  @override
  State<BootScreenApp> createState() => _BootScreenAppState();
}

class _BootScreenAppState extends State<BootScreenApp> {
  @override
  void initState() {
    super.initState();

    // Set timer to navigate after 2 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRoutes.sigin_social);
    });
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Container trắng bao bọc bên ngoài
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20), // Bo góc cho đẹp
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20), // Padding bên trong container trắng
              margin: const EdgeInsets.symmetric(horizontal: 24), // Margin để không sát viền màn hình
              child: Container(
                height: screenHeight * 0.4,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      width: screenWidth * 0.6,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Bridge to English',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue.shade900,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Learn From Home',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],

        ),
      ),
    );
  }
}