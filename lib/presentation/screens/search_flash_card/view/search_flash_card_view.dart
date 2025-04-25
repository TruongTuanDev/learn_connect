import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/routes/routes.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/provider/search_flash_card_provider.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/provider/search_all_history_provider.dart';

class CombinedSearchScreen extends ConsumerStatefulWidget {
  const CombinedSearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CombinedSearchScreen> createState() =>
      _CombinedSearchScreenState();
}

class _CombinedSearchScreenState extends ConsumerState<CombinedSearchScreen> {
  bool isSearchActive = false;

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
    final flashCardsAsync = ref.watch(flashCardsProvider); // Đảm bảo xem flashcards
    final searchHistory = ref.watch(searchHistoryProvider);
    final searchHistoryNotifier = ref.read(searchHistoryProvider.notifier);
    final searchKeyword = ref.watch(searchKeywordProvider.state); // Sử dụng watch để phản hồi thay đổi từ khóa tìm kiếm
    final filteredFlashCards = ref.watch(filteredFlashCardsProvider); // Đọc lại filtered flashcards mỗi khi từ khóa thay đổi

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
          if (isSearchActive) _toggleSearch();
        },
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
                  onChanged: (value) {
                    // Cập nhật từ khóa tìm kiếm

                    ref.read(searchKeywordProvider.notifier).state = value;
                    isSearchActive = false;
                    print("list topic: $filteredFlashCards ");
                    print("Từ khóa sẽ là: $value");
                  },
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
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        print("Xem tất cả lịch sử");
                      },
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
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          print("Đã chọn: ${history.keyWord}");
                          ref.read(searchKeywordProvider.notifier).state =
                              history.keyWord;
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
                              icon: const Icon(Icons.close,
                                  color: Colors.black54),
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
                    data: (flashCards) {
                      final flashCardsToShow =
                      searchKeyword.state.trim().isEmpty
                          ? flashCards
                          : filteredFlashCards;

                      return GridView.builder(
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: flashCardsToShow.length,
                        itemBuilder: (context, index) {
                          final flashcard = flashCardsToShow[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.flascard_item,
                                arguments: flashcard,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.pink[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    flashcard.title,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
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
