import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/Flashcard/view/flashcard_screen.dart';

import 'package:learn_connect/presentation/screens/chatting/provider/chat_screen_provider.dart';
import 'package:learn_connect/presentation/screens/chatting/view/chat_screen.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInfoScreen.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInterestsScreen.dart';
import 'package:learn_connect/presentation/screens/home/view/home.dart';
import 'package:learn_connect/presentation/screens/messenger/view/messenger_list_view.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/view/search_flash_card_view.dart';
import 'package:learn_connect/presentation/screens/swipe_friend/view/swipe_friend.dart';
import 'package:learn_connect/presentation/screens/boot_screen/view/boot_screen_app.dart';
import 'package:learn_connect/presentation/screens/boot_screen/view/login_option_screen.dart';
import '../presentation/screens/signin/view/signinscreen.dart';
import '../presentation/screens/signup/view/signupscreen.dart';
import 'package:learn_connect/presentation/screens/user_information/view/LanguageInfoPage.dart';

class AppRoutes {
  //0
  static const String loadscreen = '/load';
  //1
  static const String signup = '/signup';

  //2
  static const String information = '/signup/information';


  static const String sigin_social  = '/signup/sigin_social';
 //3
  static const String interest = '/signup/information/interest';

  //4
  static const String signin = '/signin';

  //5
  static const String home = '/home';

  //6
  static const String search = '/home/search';
  static const String flascard = '/home/flascard';

  static const String swipe_friend = '/home/swipe_friend';


  static const String flascard_item = '/home/flascard/flashcard_item';


  //7
  static const String chat = '/chat';

  //8
  static const String messengers = '/messengers';
  //9

  static Route<dynamic> generateRoute(RouteSettings settings) {
    debugPrint('Route name: ${settings.name}');
    debugPrint('Arguments: ${settings.arguments}');
    debugPrint('Type of arguments: ${settings.arguments.runtimeType}');
    switch (settings.name) {
      case loadscreen:
        return MaterialPageRoute(builder: (_) => BootScreenApp());
      case signup:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case sigin_social:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case information:
        return MaterialPageRoute(builder: (_) => UserInfoScreen(),settings: settings,);
      case interest:
        return MaterialPageRoute(builder: (_) => UserInterestsScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case search:
        return MaterialPageRoute(builder: (_) => CombinedSearchScreen());
      case swipe_friend:
        return MaterialPageRoute(builder: (_) => SwipePage());
      case flascard:
        return MaterialPageRoute(builder: (_) => CombinedSearchScreen());
      case flascard_item:
        return MaterialPageRoute(builder: (_) => FlashcardScreen(), settings: settings,);


      case chat:
        print("Nav to chat");
        final receivedId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ChatScreen(receivedId: receivedId),
        );
      case messengers:
        return MaterialPageRoute(builder: (_)=> MessengerListScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
