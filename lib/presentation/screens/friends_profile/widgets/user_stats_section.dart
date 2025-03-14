
import 'package:flutter/material.dart';
class UserStatsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: const EdgeInsets.only(bottom: 20, left: 35, right: 35),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10, left: 14, right: 14),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "26",
                      style: TextStyle(
                        color: Color(0xFF202244),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "30",
                      style: TextStyle(
                        color: Color(0xFF202244),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "20",
                      style: TextStyle(
                        color: Color(0xFF202244),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IntrinsicHeight(
              child: Container(
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          "Bạn bè",
                          style: TextStyle(
                            color: Color(0xFF545454),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 150),
                      child: Text(
                        "Ngày",
                        style: TextStyle(
                          color: Color(0xFF545454),
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      "Bài học",
                      style: TextStyle(
                        color: Color(0xFF545454),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}