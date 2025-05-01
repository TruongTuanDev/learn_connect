import 'package:flutter/material.dart';

class VanHoaPage extends StatelessWidget {
  final String title;
  final Map<String, dynamic> cultureData;

  const VanHoaPage({
    Key? key,
    required this.title,
    required this.cultureData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        children: [
          for (var section in cultureData['sections'])
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildSectionTitle(section['title']),
                buildImageWithText(section['imageUrl'], section['description']),
              ],
            ),

          // Hình ảnh đẹp (Gallery)
          if (cultureData['galleryImages'] != null) ...[
            buildSectionTitle('Hình ảnh đẹp'),
            SizedBox(
              height: 120,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var imgUrl in cultureData['galleryImages'])
                    buildGalleryImage(imgUrl),
                ],
              ),
            ),
          ],

          SizedBox(height: 20),

          // Nút điều hướng
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Quay lại'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Bạn có thể thêm điều hướng khám phá thêm ở đây
                  },
                  child: Text('Khám phá thêm'),
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildImageWithText(String imageUrl, String text) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildGalleryImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          imageUrl,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
