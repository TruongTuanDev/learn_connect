import 'package:flutter/material.dart';

class NotificationItem extends StatelessWidget {
  final String imageUrl;
  final String text;
  const NotificationItem({super.key, required this.imageUrl, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print('Pressed');
      },
      child: IntrinsicHeight(
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0x33B4BDC4),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(18),
            color: const Color(0xFFE8F1FF),
          ),
          padding: const EdgeInsets.only(top: 21, bottom: 21, left: 18, right: 18),
          margin: const EdgeInsets.only(bottom: 12),
          width: double.infinity,
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 11),
                width: 52,
                height: 52,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Color(0xFF202244),
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
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
