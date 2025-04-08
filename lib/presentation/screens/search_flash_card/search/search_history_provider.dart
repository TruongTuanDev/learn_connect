import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/search_flash_card/search/search_history_model.dart';

// Provider cho SearchHistoryModel
final searchHistoryModelProvider = Provider((ref) => SearchHistoryModel());

// StateNotifier quản lý lịch sử tìm kiếm
class SearchHistoryNotifier extends StateNotifier<List<SearchHistory>> {
  final SearchHistoryModel searchHistoryModel;

  SearchHistoryNotifier(this.searchHistoryModel) : super([]) {
    _init();
  }

  Future<void> _init() async {
    try {
      state = await searchHistoryModel.fetchSearchHistory();
    } catch (e) {
      // Xử lý lỗi nếu cần
    }
  }

  Future<void> saveSearchHistory(SearchHistory history) async {
    await searchHistoryModel.saveSearchHistory(history);
    state = [...state, history]; // Cập nhật danh sách mới
  }

  Future<void> deleteSearchHistory(SearchHistory history) async {
    await searchHistoryModel.deleteSearchHistory(history.keyWord);
    state = state.where((item) => item.keyWord != history.keyWord).toList();
  }
}

// Provider cho SearchHistoryNotifier
final searchHistoryProvider =
StateNotifierProvider<SearchHistoryNotifier, List<SearchHistory>>((ref) {
  final searchHistoryModel = ref.read(searchHistoryModelProvider);
  return SearchHistoryNotifier(searchHistoryModel);
});
