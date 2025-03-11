import 'package:flutter/material.dart';

class FriendActivityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xFFF3F3F3),
      ),
      padding: const EdgeInsets.only(top: 16, bottom: 62),
      margin: const EdgeInsets.only(bottom: 18),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 21, left: 20),
            child: Text(
              "Hoạt động bạn bè",
              style: TextStyle(
                color: Color(0xFF202244),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          _buildFriendAvatars(),
        ],
      ),
    );
  }

  Widget _buildFriendAvatars() {
    List<String> imageUrls = [
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/3e7b2b72-3306-4614-9067-758baec16d3e",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/4bd53245-4902-4d2c-95c6-b4a83f264998",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/10dfd615-5f33-4bd0-81e6-e9939aae3b82",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/46469780-42c0-4f09-aecf-f4bc0b81ff95",
      "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/a99cafc1-4b1e-4a6c-8a92-85afc218fc61"
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: imageUrls.map((url) {
        return Container(
          margin: const EdgeInsets.only(right: 33),
          width: 51,
          height: 51,
          child: Image.network(url, fit: BoxFit.fill),
        );
      }).toList(),
    );
  }
}
