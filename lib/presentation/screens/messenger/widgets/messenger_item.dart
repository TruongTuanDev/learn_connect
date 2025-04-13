import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/messenger/model/message_model.dart';
class ChatItem extends StatelessWidget {
  final Messenger messenger;

  ChatItem({required this.messenger});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(40),
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                backgroundImage: NetworkImage(messenger.avatarUrl),
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
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
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


