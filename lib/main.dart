import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


import 'package:learn_connect/routes/routes.dart';

import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/signup/view/signupscreen.dart';
import '../routes/routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Starting App...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("Firebase Initialized!");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learn Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // home:SignUpScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loadscreen, // Màn hình khởi động
      onGenerateRoute: AppRoutes.generateRoute, // Quan trọng
    );
  }
}



