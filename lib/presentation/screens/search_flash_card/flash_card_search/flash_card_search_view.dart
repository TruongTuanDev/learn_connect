import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/provider/search_all_history_provider.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/provider/search_flash_card_provider.dart';

class CombinedSearchScreen extends ConsumerStatefulWidget {
  const CombinedSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CombinedSearchScreen> createState() =>
      _CombinedSearchScreenState();
}

class _CombinedSearchScreenState extends ConsumerState<CombinedSearchScreen> {
  bool isSearchActive = false; // Trạng thái hiển thị danh sách hoặc lịch sử

  void _toggleSearch() {
    setState(() {
      isSearchActive = !isSearchActive;
    });
  }
  void _onSearch() {
    setState(() {
      isSearchActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashCardsAsync = ref.watch(flashCardsProvider);
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
      body: GestureDetector(
        onTap: () {
          if (isSearchActive) _toggleSearch(); // Ẩn lịch sử tìm kiếm và hiện flashcards
          print("parent");
        }, // Đảm bảo chỉ xử lý vùng trống
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextField(
                  onTap: _onSearch,
                  decoration: const InputDecoration(
                    hintText: "Tìm kiếm",
                    prefixIcon: Icon(Icons.search, color: Colors.blue),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (isSearchActive) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Gần đây",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {print("con");},
                      child: const Text(
                        "Xem tất cả",
                        style: TextStyle(fontSize: 14, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchHistory.length,
                    itemBuilder: (context, index) {
                      final history = searchHistory[index];
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent, // Đảm bảo không kích hoạt onTap vùng trống
                        onTap: () {
                          // Xử lý sự kiện nhấn vào phần tử trong lịch sử tìm kiếm
                          print("Đã chọn: ${history.keyWord}");
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              history.keyWord,
                              style: const TextStyle(fontSize: 14),
                            ),
                            IconButton(
                              onPressed: () => searchHistoryNotifier
                                  .deleteSearchHistory(history),
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ] else ...[
                Expanded(
                  child: flashCardsAsync.when(
                    data: (flashCards) => GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: flashCards.length,
                      itemBuilder: (context, index) {
                        final flashcard = flashCards[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.pink[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                flashcard.flash_card_type,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    loading: () =>
                    const Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text("Lỗi: $error")),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}