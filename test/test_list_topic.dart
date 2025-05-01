import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: TopicGridScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class TopicGridScreen extends StatelessWidget {
  const TopicGridScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> topics = const [
    {
      'title': 'Comunication',
      'image': 'https://img.icons8.com/color/96/000000/conference.png',
    },
    {
      'title': 'Work',
      'image': 'https://img.icons8.com/color/96/000000/working-with-laptop.png',
    },
    {
      'title': 'Food',
      'image': 'https://img.icons8.com/color/96/000000/grocery-bag.png',
    },
    {
      'title': 'Technology',
      'image': 'https://img.icons8.com/color/96/000000/robot-2.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 24,
            crossAxisSpacing: 24,
            childAspectRatio: 1,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            final topic = topics[index % topics.length];
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.18),
                    spreadRadius: 2,
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Image.network(
                        topic['image']!,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        topic['title']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
