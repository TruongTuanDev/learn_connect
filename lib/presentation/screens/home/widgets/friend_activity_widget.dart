import 'package:flutter/material.dart';

class FriendActivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF3F3F3),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      margin: const EdgeInsets.only(bottom: 18),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Hoạt động bạn bè",
              style: TextStyle(
                color: Color(0xFF202244),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildFriendAvatars(),
        ],
      ),
    );
  }

  Widget _buildFriendAvatars() {
    List<String> imageUrls = [
      "assets/images/phuc.jpg",
      "assets/images/avartar.png",
      "assets/images/tam.jpg",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/46469780-42c0-4f09-aecf-f4bc0b81ff95",
      "assets/images/truc.jpg",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/a99cafc1-4b1e-4a6c-8a92-85afc218fc61"
    ];
    List<String> names = [
      "An Nhiên",
      "Minh Khoa",
      "Bảo Hân",
      "Hữu Tín",
      "Merry",
      "Gia Hưng"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: imageUrls.map((url) {
            return Container(
              margin: const EdgeInsets.only(right: 20),
              width: 51,
              height: 51,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.5),
                child: Image.asset(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.grey[600]),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
