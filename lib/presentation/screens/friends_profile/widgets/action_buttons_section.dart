import 'package:flutter/material.dart';

class ActionButtonsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  print('Pressed');
                },
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0x66B4BDC4),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFE8F1FF),
                    ),
                    padding: const EdgeInsets.only(top: 10, bottom: 10, left: 30, right: 30), // Giảm padding
                    margin: const EdgeInsets.only(right: 10), // Giảm margin
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Canh giữa văn bản
                      children: [
                        Text(
                          "Theo dõi",
                          style: TextStyle(
                            color: Color(0xFF202244),
                            fontSize: 16, // Giảm kích thước font
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  print('Pressed');
                },
                child: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFF0961F5),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4D000000),
                          blurRadius: 8,
                          offset: Offset(1, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10), // Giảm padding
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Canh giữa văn bản
                      children: [
                        Text(
                          "Nhắn tin",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 16, // Giảm kích thước font
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
