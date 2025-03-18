import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:learn_connect/presentation/screens/home/UserInfoScreen.dart';
import 'package:learn_connect/presentation/screens/home/UserInterestsScreen.dart';
import 'package:learn_connect/presentation/screens/profile/view/ProfileScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:learn_connect/presentation/screens/Flashcard/view/flashcard_screen.dart';


import 'package:learn_connect/presentation/screens/home/UserInfoScreen.dart';
import 'package:learn_connect/presentation/screens/home/view/home.dart';

import 'package:learn_connect/presentation/screens/search/flash_card_search/flash_card_search_view.dart';
import 'package:learn_connect/presentation/screens/search/search/search_history_model.dart';
import 'package:learn_connect/presentation/screens/search/search/search_view.dart';
import 'package:learn_connect/presentation/screens/search/search/search_history_view_model.dart';

import 'package:learn_connect/presentation/screens/notify/view/notify.dart';
import 'package:learn_connect/presentation/screens/friends_profile/view/friend_profile.dart';

import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/signup/view/signupscreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugPrint("Starting App...");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("Firebase Initialized!");
  runApp(ProviderScope(child: MyApp()));


  void main() {
    // runApp(MyApp());
    //
    //
    // runApp(
    //   ChangeNotifierProvider(
    //     create: (context) => SearchHistoryViewModel(SearchHistoryModel()),
    //     child:  MyApp(),
    //   ),
    // );
    // runApp(ProviderScope(child: MyApp()));

  }

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home:SignUpScreen(),

    );
  }
}



