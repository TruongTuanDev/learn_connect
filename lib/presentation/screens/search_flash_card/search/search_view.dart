import 'package:flutter/material.dart';

import 'package:learn_connect/presentation/screens/search_flash_card/coponents/search_box.dart';
import 'package:provider/provider.dart';

import 'search_history_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => context.read<SearchHistoryViewModel>().init());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchHistoryViewModel>();


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

              child:
                  viewModel.searchHistory.isEmpty
                      ? const Center(child: Text("Không có lịch sử tìm kiếm"))
                      : ListView.builder(
                        itemCount: viewModel.searchHistory.length,
                        itemBuilder: (context, index) {
                          final history = viewModel.searchHistory[index];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                history.keyWord,
                                style: const TextStyle(fontSize: 14),
                              ),
                              IconButton(
                                onPressed:
                                    () =>
                                        viewModel.deleteSearchHistory(history),
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
