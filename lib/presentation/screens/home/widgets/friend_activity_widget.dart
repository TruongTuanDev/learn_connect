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
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/3e7b2b72-3306-4614-9067-758baec16d3e",
      "assets/images/avartar.png",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4bd53245-4902-4d2c-95c6-b4a83f264998",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/10dfd615-5f33-4bd0-81e6-e9939aae3b82",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/46469780-42c0-4f09-aecf-f4bc0b81ff95",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/a99cafc1-4b1e-4a6c-8a92-85afc218fc61"
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
                child: Image.network(
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
