import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/friends_profile/widgets/header_section.dart';
import 'package:learn_connect/presentation/screens/friends_profile/widgets/interests_section.dart';


class FriendProfile extends StatefulWidget {
  const FriendProfile({super.key});

  @override
  FriendProfileState createState() => FriendProfileState();
}

class FriendProfileState extends State<FriendProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Color(0xFFFFFFFF),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderSection(),
                        Container(
                          margin: const EdgeInsets.only(bottom: 22, left: 27),
                          child: Text(
                            "Sở thích",
                            style: TextStyle(
                              color: Color(0xFF202244),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InterestsSection(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
