import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/chatting/provider/chat_screen_provider.dart';
import 'package:learn_connect/presentation/screens/messenger/provider/messenger_provider.dart';
import 'package:learn_connect/presentation/screens/messenger/widgets/messenger_item.dart';

class MessengerListScreen extends ConsumerWidget {
  const MessengerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageList = ref.watch(messagingListProvider);
    ref.watch(socketServiceProvider);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Tin nhắn",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          titleSpacing: 0.0,
          actions: [
            Container(
              margin: EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add your search action here
                  print('Search button pressed');
                },
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text("Nhắn"),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.green),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {},
                      child: const Text("Gọi"),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          Colors.indigo.shade100,
                        ),
                        foregroundColor: WidgetStateProperty.all(Colors.black),
                        minimumSize: WidgetStateProperty.all(
                          Size(double.infinity, 50),
                        ),
                        textStyle: WidgetStateProperty.all(
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref
                      .read(messagingListProvider.notifier)
                      .fetchMessengerList(),
                  child: ListView.builder(
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return ChatItem(messenger: messageList[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}

