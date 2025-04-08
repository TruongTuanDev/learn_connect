import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/Flashcard/view/flashcard_screen.dart';
import 'package:learn_connect/presentation/screens/home/UserInfoScreen.dart';
import 'package:learn_connect/presentation/screens/home/UserInterestsScreen.dart';
import 'package:learn_connect/presentation/screens/home/view/home.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/search/search_view.dart';
import '../presentation/screens/signin/view/signinscreen.dart';
import '../presentation/screens/signup/view/signupscreen.dart';

class AppRoutes {
  //1
  static const String signup = '/signup';
  //2
  static const String information = '/signup/information';
  //3
  static const String interest = '/signup/information/interest';
  //4
  static const String signin = '/signin';
  //5
  static const String home = '/home';
  //6
  static const String search = '/home/search';
  static const String flascard = '/home/flascard';
  //7
  //8
  //9

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case information:
        return MaterialPageRoute(builder: (_) => UserInfoScreen());
      case interest:
        return MaterialPageRoute(builder: (_) => UserInterestsScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case search:
        return MaterialPageRoute(builder: (_) => SearchScreen());
      case flascard:
        return MaterialPageRoute(builder: (_) => FlashcardScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
