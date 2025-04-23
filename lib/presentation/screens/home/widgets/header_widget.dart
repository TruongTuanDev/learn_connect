import 'package:flutter/material.dart';
import 'package:learn_connect/routes/routes.dart';


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
                "assets/images/logo.png",
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
            _buildIcon("assets/images/mesenger.png",() {
              Navigator.pushNamed(context, AppRoutes.messengers);
            },),
            _buildIcon("assets/images/notyfication.png",() {
              print("Bạn vừa nhấn vào biểu tượng!");
              // Thêm chức năng khác tại đây (chuyển trang, hiển thị popup, v.v.)
            },),
            _buildIcon("assets/images/avartar.png",() {
              print("Bạn vừa nhấn vào biểu tượng!");
              // Thêm chức năng khác tại đây (chuyển trang, hiển thị popup, v.v.)
            },),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String url , VoidCallback onTap) {
      return GestureDetector(
      onTap: onTap,
      child: Image.asset(
      url,
      width: 40,
      height: 40,
      fit: BoxFit.fill,
      ),
      );

  }
}
