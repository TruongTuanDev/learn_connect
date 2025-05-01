import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



import 'package:learn_connect/presentation/screens/profile/view/ProfileScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learn_connect/presentation/screens/Flashcard/view/flashcard_screen.dart';



import 'package:learn_connect/presentation/screens/home/view/home.dart';
import 'package:learn_connect/presentation/screens/recommended_friends/recommended_friends_screen.dart';




import 'package:learn_connect/presentation/screens/search_flash_card/flash_card_search/flash_card_search_view.dart';




import 'package:learn_connect/presentation/screens/notify/view/notify.dart';
import 'package:learn_connect/presentation/screens/friends_profile/view/friend_profile.dart';
import 'package:learn_connect/presentation/screens/signin/view/signinscreen.dart';

import 'package:learn_connect/presentation/screens/swipe_friend/view/swipe_friend.dart';

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
  runApp(
      ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget  {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Learn Connect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      // home:SignUpScreen(),
      debugShowCheckedModeBanner: false,

   
      initialRoute: AppRoutes.signup, // Màn hình khởi động

      onGenerateRoute: AppRoutes.generateRoute, // Quan trọng
    );
  }
}



