import 'package:flutter/foundation.dart';
import 'package:learn_connect/presentation/screens/recommended_friends/providers/match_api.dart';
import '../models/match_model.dart';

class MatchProvider with ChangeNotifier {
  final MatchApi _matchApi;
  List<Match> _matches = [];
  bool _isLoading = false;
  String? _error;

  MatchProvider({required MatchApi matchApi}) : _matchApi = matchApi;

  List<Match> get matches => _matches;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMatches(String userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _matches = await _matchApi.getMatches(userId);
      _error = null;
    } catch (e) {
      _error = e.toString();
      _matches = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}