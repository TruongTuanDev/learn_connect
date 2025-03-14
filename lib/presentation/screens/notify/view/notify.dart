import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/notify/widgets/header_section.dart';
import 'package:learn_connect/presentation/screens/notify/widgets/notification_list.dart';
class Notify extends StatefulWidget {
  const Notify({super.key});

  @override
  NotifyState createState() => NotifyState();
}

class NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color(0xFFFFFFFF),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: const Color(0xFFFFFFFF),
                  width: double.infinity,
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HeaderSection(),
                        const NotificationList(),
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