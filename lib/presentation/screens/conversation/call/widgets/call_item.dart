import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/conversation/call/model/status_call.dart';

class CallItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String callStatus;
  final String time;

  CallItem({
    required this.avatarUrl,
    required this.name,
    required this.callStatus,
    required this.time,
  });

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
                backgroundImage: NetworkImage(avatarUrl),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        switch (CallStatus.fromString(callStatus)) {
                          // TODO: Handle this case.
                          CallStatus.receivedCall => Icon(
                            Icons.add_box_outlined,
                            color: Colors.indigo,
                          ),
                          // TODO: Handle this case.
                          CallStatus.missedCall => Icon(
                            Icons.cancel_presentation_outlined,
                            color: Colors.red,
                          ),
                          // TODO: Handle this case.
                          CallStatus.called => Icon(
                            Icons.remove_circle_outline,
                            color: Colors.green.shade600,
                          ),
                        },
                        SizedBox(width: 4),
                        Flexible(child:
                        Text(
                          CallStatus.fromString(callStatus).description +
                              " | " +
                              time,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),)
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.phone_in_talk, color: Colors.blue),
            ],
          ),
        ),
      ),
    );
  }
}
