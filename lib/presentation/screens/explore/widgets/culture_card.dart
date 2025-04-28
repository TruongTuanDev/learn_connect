import 'package:flutter/material.dart';

class CultureCard extends StatelessWidget {
  final String culture;
  final String imagePath;

  CultureCard({required this.culture, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDetails(context, culture);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10),
        elevation: 5,
        child: Container(
          width: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(imagePath, height: 60, width: 60),
              SizedBox(height: 10),
              Text(culture, textAlign: TextAlign.center),
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
