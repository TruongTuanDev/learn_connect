import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/chatting/provider/chat_screen_provider.dart';
import 'package:learn_connect/presentation/screens/messenger/model/message_model.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/services/socket_service.dart';

class ChatItem extends ConsumerWidget {
  final Messenger messenger;

  const ChatItem({super.key, required this.messenger});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onlineUsers = ref.watch(onlineUsersProvider);
    final isOnline = onlineUsers.contains(messenger.id);
    print(onlineUsers);
    return Card(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(40),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.chat,
            arguments: {
              'id': messenger.id,
              'name': messenger.name,
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage("assets/images/none_avatar.png"),
                    // NetworkImage(messenger.avatarUrl),
                  ),
                  if (isOnline)
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      messenger.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      messenger.message,
                      style:
                      TextStyle(color: Colors.grey[600], fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  if (messenger.unread > 0)
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      child: Text(messenger.unread.toString()),
                    ),
                  SizedBox(height: 4),
                  Text(
                    messenger.time,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
