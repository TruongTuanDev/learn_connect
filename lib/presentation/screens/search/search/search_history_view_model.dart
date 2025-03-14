import 'package:flutter/cupertino.dart';
import 'package:learn_connect/presentation/screens/search/search/search_history_model.dart';

class SearchHistoryViewModel extends ChangeNotifier{
  final SearchHistoryModel searchHistoryModel;
  List<SearchHistory> searchHistory = [];
  SearchHistoryViewModel(this.searchHistoryModel);
  String? errorMessage;
  Future<void> init() async {
    try {
      searchHistory = (await searchHistoryModel.fetchSearchHistory());
    } catch (e) {
      errorMessage = 'Could not initialize counter';
    }
    notifyListeners();
  }

  Future<void> saveSearchHistory(SearchHistory history) async{
    await searchHistoryModel.saveSearchHistory(history);
  }

  Future<void> deleteSearchHistory(SearchHistory history) async{
    await searchHistoryModel.deleteSearchHistory(history.keyWord);
    searchHistory.remove(history);
    notifyListeners();
  }
}