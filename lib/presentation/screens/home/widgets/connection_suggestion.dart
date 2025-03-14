import 'package:flutter/material.dart';

class ConnectionSuggestionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Text(
            "Gợi ý kết nối",
            style: TextStyle(
              color: Color(0xFF202244),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 28),
          child: Text(
            "Xem tất cả",
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Column(
          children: [
            _buildUserItem(
              "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4649e61d-c677-44c7-9a1e-fe3a26b7c1e6",
              "Trúc Cute",
            ),
            _buildUserItem(
              "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/6a393e58-4b97-4fa9-bb22-7f982f00e5e0",
              "Nguyễn A",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUserItem(String imageUrl, String name) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 5),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              imageUrl,
              width: 51,
              height: 51,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: Color(0xFF000000),
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Kết bạn",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
