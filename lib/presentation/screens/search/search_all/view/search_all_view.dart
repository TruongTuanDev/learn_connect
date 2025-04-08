import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/search/search_all/provider/search_all_history_provider.dart';
import 'package:learn_connect/presentation/screens/search/widgets/search_box.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchHistory = ref.watch(searchHistoryProvider);
    final searchHistoryNotifier = ref.read(searchHistoryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          "SEARCH",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SearchBox(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Gần đây",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Xem tất cả",
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: searchHistory.isEmpty
                  ? const Center(child: Text("Không có lịch sử tìm kiếm"))
                  : ListView.builder(
                itemCount: searchHistory.length,
                itemBuilder: (context, index) {
                  final history = searchHistory[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        history.keyWord,
                        style: const TextStyle(fontSize: 14),
                      ),
                      IconButton(
                        onPressed: () =>
                            searchHistoryNotifier.deleteSearchHistory(history),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black54,
                        ),
                      ),
                    ],
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
