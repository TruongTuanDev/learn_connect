import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/Flashcard/view/flashcard_screen.dart';
import 'package:learn_connect/presentation/screens/boot_screen/view/boot_screen_app.dart';
import 'package:learn_connect/presentation/screens/boot_screen/view/login_option_screen.dart';

import 'package:learn_connect/presentation/screens/chatting/provider/chat_screen_provider.dart';
import 'package:learn_connect/presentation/screens/chatting/view/chat_screen.dart';
import 'package:learn_connect/presentation/screens/flasdcard_ai/view/flashcard_ai.dart';


import 'package:learn_connect/presentation/screens/home/view/home.dart';
import 'package:learn_connect/presentation/screens/messenger/view/messenger_list_view.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/view/search_flash_card_view.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInfoScreen.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInterestsScreen.dart';



import 'package:learn_connect/presentation/screens/home/view/home.dart';
import 'package:learn_connect/presentation/screens/messenger/view/messenger_list_view.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/view/search_flash_card_view.dart';
import 'package:learn_connect/presentation/screens/swipe_friend/view/swipe_friend.dart';
import 'package:learn_connect/presentation/screens/question_ai/view/question_ai.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInfoScreen.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInterestsScreen.dart';
import '../presentation/screens/boot_screen/view/boot_screen_app.dart';
import '../presentation/screens/boot_screen/view/login_option_screen.dart';

import '../presentation/screens/signin/view/signinscreen.dart';
import '../presentation/screens/signup/view/signupscreen.dart';
import '../presentation/screens/user_information/view/UserInfoScreen.dart';
import '../presentation/screens/user_information/view/UserInterestsScreen.dart';

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
  static const String flascard_ai = '/home/flascard_ai';
  static const String vocabulary = '/home/vocabulary';

  static const String swipe_friend = '/home/swipe_friend';


  static const String flascard_item = '/home/flascard/flashcard_item';


  //7
  static const String chat = 'home/messengers/chat';

  //8
  static const String messengers = 'home/messengers';
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
        return MaterialPageRoute(builder: (_) => UserInfoScreen());
      case interest:
        return MaterialPageRoute(builder: (_) => UserInterestsScreen());
      case signin:
        return MaterialPageRoute(builder: (_) => SignInScreen());
      case home:
        return MaterialPageRoute(builder: (_) => Home());
      case search:
        return MaterialPageRoute(builder: (_) => CombinedSearchScreen());
      case vocabulary:
        return MaterialPageRoute(builder: (_) => TestAiScreen());
      case swipe_friend:
        return MaterialPageRoute(builder: (_) => SwipePage());
      case flascard:
        return MaterialPageRoute(builder: (_) => CombinedSearchScreen());
      case flascard_ai:
        return MaterialPageRoute(builder: (_) => FlashcardAIScreen());
      case flascard_item:
        return MaterialPageRoute(builder: (_) => FlashcardScreen(), settings: settings,);


      case chat:
        print("Nav to chat");
        final args  = settings.arguments as Map<String, dynamic>;
        final userId = args['id'];
        final name = args['name'];
        return MaterialPageRoute(
          builder: (_) => ChatScreen(receivedId: userId, receiverName: name,),
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
