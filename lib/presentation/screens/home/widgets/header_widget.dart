import 'package:flutter/material.dart';
import 'package:learn_connect/routes/routes.dart';


class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.only(top: 50, right: 30, bottom: 40),
        color: Color(0xFFF4F8FE),
        width: double.infinity,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 0, right: 6, bottom: 0),
              margin: const EdgeInsets.only(right: 4, left: 7),
              width: 38,
              height: 38,
              child: Image.asset(
                "assets/images/logo.png",
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 125),
            // Expanded(
            //   child: Text(
            //     "Bridge to global",
            //     style: TextStyle(
            //       color: Color(0xFF332DA1),
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            _buildIcon("assets/images/mesenger.png",() {
              Navigator.pushNamed(context, AppRoutes.messengers);
            },),
            SizedBox(width: 16),
            _buildIcon("assets/images/notyfication.png",() {
              print("Bạn vừa nhấn vào biểu tượng!");
              // Thêm chức năng khác tại đây (chuyển trang, hiển thị popup, v.v.)
            },),
            SizedBox(width: 16),
            _buildIcon("assets/images/avartar.png",() {
              print("Bạn vừa nhấn vào biểu tượng!");
              // Thêm chức năng khác tại đây (chuyển trang, hiển thị popup, v.v.)
            },),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String url, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(url),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
