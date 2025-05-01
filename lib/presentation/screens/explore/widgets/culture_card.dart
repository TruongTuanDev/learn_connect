import 'package:flutter/material.dart';

import '../data/culture_data.dart';
import '../view/VanHoaPage.dart';

class CultureCard extends StatelessWidget {
  final String culture_name;
  final String imagePath;

  CultureCard({required this.culture_name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              final culture = cultures.firstWhere(
                    (element) => element['name'] == culture_name,
              );
              return VanHoaPage(
                title: culture['name'],
                cultureData: {
                  'sections': culture['sections'],
                  'galleryImages': culture['galleryImages'],
                },
              );
            },
          ),
        );

      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), // Bo tròn góc trên bên trái
                  topRight: Radius.circular(15), // Bo tròn góc trên bên phải
                ),
                child: Image.asset(
                  imagePath,  // Hiển thị hình ảnh văn hóa
                  height: 150,
                  width: double.infinity,  // Giúp hình ảnh lấp đầy khung ngang
                  fit: BoxFit.fill,  // Lấp đầy khung mà không bị co kéo
                ),
              ),
              SizedBox(height: 10),
              Text(
                culture_name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, String item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(item),
          content: Text('Chi tiết về $item'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
