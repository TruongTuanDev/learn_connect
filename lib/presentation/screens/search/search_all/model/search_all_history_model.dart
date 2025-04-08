import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@immutable
class SearchHistory{
  final String keyWord;
  final DateTime timestamp;

  const SearchHistory({required this.keyWord, required this.timestamp});

  //json dont have datetime type, change it to string
  Map<String, dynamic> toJson() => {'keyWord' : keyWord, 'timestamp': timestamp.toIso8601String()};

  factory SearchHistory.fromJson(Map<String, dynamic> json){
    return switch(json) {
      {'keyWord' : String keyWord, 'timestamp' : String timestamp} => SearchHistory(
        keyWord: keyWord,
        timestamp: DateTime.parse(timestamp)
      ),
    _ => throw const FormatException('Failed to load search_all history')
    };
  }
}

class SearchHistoryModel{

  final List<SearchHistory> _searchHistory = [
    SearchHistory(keyWord: "Flutter Provider", timestamp: DateTime.now()),
    SearchHistory(keyWord: "Dart Async", timestamp: DateTime.now().subtract(Duration(days: 1))),
    SearchHistory(keyWord: "State Management", timestamp: DateTime.now().subtract(Duration(days: 2))),
  ];
  final dio = Dio();

  Future<List<SearchHistory>> fetchSearchHistory() async{
    /*final response = await dio.get("path");

    if(response.statusCode == 200){
      final List<dynamic> jsonList = response.data;
      return jsonList.map((json)=> SearchHistory.fromJson(json)).toList();
    }else {
      throw Exception('Failed to load search_all history');
    }*/
    return List<SearchHistory>.from(_searchHistory);
  }

  Future<void> saveSearchHistory(SearchHistory history) async {
      await dio.post("path", data: history.toJson());
  }

  Future<void> deleteSearchHistory(String keyWord) async {
      // await dio.delete("path/$keyWord");
  }
}