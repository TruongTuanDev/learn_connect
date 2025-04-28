import 'package:flutter/material.dart';

class ConnectionCard extends StatelessWidget {
  final String connectionTopic;

  ConnectionCard({required this.connectionTopic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDetails(context, connectionTopic);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        elevation: 5,
        child: Container(
          width: 160,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.people, size: 40, color: Colors.purpleAccent),
              SizedBox(height: 10),
              Text(connectionTopic, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item),
          content: Text('Chi tiết về $item'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
