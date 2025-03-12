import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(top: 49),
        color: Color(0xFFF4F8FE),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4, left: 7),
              width: 33,
              height: 34,
              child: Image.network(
                "https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/90b5ea2a-5ba8-477b-a04b-7fdc700a15f4",
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Text(
                "Bridge to English",
                style: TextStyle(
                  color: Color(0xFF332DA1),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildIcon("https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/1815c942-c0b5-44c0-bb6f-b3b729a877e4"),
            _buildIcon("https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/67bacdf9-89d2-4ac5-ad27-ce8a9616147e"),
            _buildIcon("https://figma-alpha-api.s3.us-west-2.amazonaws.com/images/f7ed61e0-19ce-48b5-b01c-722aa8ebccc6", size: 41),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String url, {double size = 22}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      width: size,
      height: size,
      child: Image.network(url, fit: BoxFit.fill),
    );
  }
}
