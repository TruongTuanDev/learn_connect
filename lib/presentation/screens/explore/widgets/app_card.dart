// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
//
// class AppBannerSlider extends StatefulWidget {
//   @override
//   _AppBannerSliderState createState() => _AppBannerSliderState();
// }
//
// class _AppBannerSliderState extends State<AppBannerSlider> {
//   int _currentIndex = 0;
//
//   final List<Map<String, String>> _bannerData = [
//     {
//       'title': 'Học Tiếng Anh',
//       'image': 'https://images.unsplash.com/photo-1607746882042-944635dfe10e',
//       'icon': 'school'
//     },
//     {
//       'title': 'Khám Phá Thế Giới',
//       'image': 'https://images.unsplash.com/photo-1506744038136-46273834b3fb',
//       'icon': 'travel'
//     },
//     {
//       'title': 'Phát Triển Bản Thân',
//       'image': 'https://images.unsplash.com/photo-1503676260728-1c00da094a0b',
//       'icon': 'self_improvement'
//     },
//   ];
//
//   IconData _getIconData(String type) {
//     switch (type) {
//       case 'school':
//         return Icons.school;
//       case 'travel':
//         return Icons.travel_explore;
//       case 'self_improvement':
//         return Icons.self_improvement;
//       default:
//         return Icons.star;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider.builder(
//           itemCount: _bannerData.length,
//           options: CarouselOptions(
//             height: 220,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             viewportFraction: 0.85,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//           itemBuilder: (context, index, realIdx) {
//             final item = _bannerData[index];
//             return Stack(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 5),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     image: DecorationImage(
//                       image: NetworkImage(item['image']!),
//                       fit: BoxFit.cover,
//                       colorFilter: ColorFilter.mode(
//                           Colors.black.withOpacity(0.4), BlendMode.darken),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 30,
//                   left: 20,
//                   right: 20,
//                   child: AnimatedOpacity(
//                     opacity: 1.0,
//                     duration: Duration(milliseconds: 600),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Icon(
//                           _getIconData(item['icon']!),
//                           color: Colors.white,
//                           size: 40,
//                         ),
//                         SizedBox(height: 10),
//                         Text(
//                           item['title']!,
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               shadows: [
//                                 Shadow(
//                                     blurRadius: 10,
//                                     color: Colors.black,
//                                     offset: Offset(2, 2))
//                               ]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//         const SizedBox(height: 15),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: _bannerData.asMap().entries.map((entry) {
//             return GestureDetector(
//               onTap: () => setState(() => _currentIndex = entry.key),
//               child: Container(
//                 width: 10.0,
//                 height: 10.0,
//                 margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: _currentIndex == entry.key
//                       ? Colors.blueAccent
//                       : Colors.grey,
//                 ),
//               ),
//             );
//           }).toList(),
//         )
//       ],
//     );
//   }
// }
