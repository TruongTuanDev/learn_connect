import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: TopicGridScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class TopicGridScreen extends StatefulWidget {
  const TopicGridScreen({Key? key}) : super(key: key);

  @override
  State<TopicGridScreen> createState() => _TopicGridScreenState();
}

class _TopicGridScreenState extends State<TopicGridScreen> {
  final List<Map<String, String>> topics = const [
    {'title': 'Comunication', 'image': 'assets/images/comunication.png'},
    {'title': 'Work', 'image': 'assets/images/comunication.png'},
    {'title': 'Food', 'image': 'assets/images/comunication.png'},
    {'title': 'Technology', 'image': 'assets/images/comunication.png'},
    {'title': 'Comunication1', 'image': 'assets/images/comunication.png'},
    {'title': 'Work1', 'image': 'assets/images/comunication.png'},
    {'title': 'Food1', 'image': 'assets/images/comunication.png'},
    {'title': 'Technology1', 'image': 'assets/images/comunication.png'},
    {'title': 'Comunication2', 'image': 'assets/images/comunication.png'},
    {'title': 'Work2', 'image': 'assets/images/comunication.png'},
    {'title': 'Food2', 'image': 'assets/images/comunication.png'},
    {'title': 'Technology2', 'image': 'assets/images/comunication.png'}
  ];

  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  List<Map<String, String>> get filteredTopics {
    if (_searchText.isEmpty) return topics;
    return topics
        .where(
          (topic) =>
              topic['title']!.toLowerCase().contains(_searchText.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom AppBar with back button and search box
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Container(
                width: double.infinity, // chiếm toàn bộ chiều ngang
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.12),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                ), // không margin ngang
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 20,
                ), // padding trong cho đẹp
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30),
                      onPressed: () {
                        Navigator.of(context).maybePop();
                      },
                    ),
                    Expanded(
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black, width: 2),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  setState(() {
                                    _searchText = value;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(24),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24,
                  crossAxisSpacing: 24,
                  childAspectRatio: 1,
                ),
                itemCount: filteredTopics.length,
                itemBuilder: (context, index) {
                  final topic = filteredTopics[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        // Bóng xiên chỉ ở cạnh phải và dưới
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.18),
                          spreadRadius: 0,
                          blurRadius: 18,
                          offset: const Offset(10, 10), // bóng xiên phải-dưới
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Image.asset(
                              topic['image']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Flexible(
                          flex: 2,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              topic['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
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
          ],
        ),
      ),
    );
  }
}
