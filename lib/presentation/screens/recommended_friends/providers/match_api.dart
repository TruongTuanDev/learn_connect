import 'package:learn_connect/data/models/UserInfor.dart';
import 'package:learn_connect/presentation/screens/recommended_friends/providers/ApiClient.dart';
import '../models/match_model.dart';

class MatchApi {
  final ApiClient _apiClient;

  MatchApi({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<Match>> getMatches(String userId) async {
    final response = await _apiClient.get('api/matches/$userId');

    // Parse response thành list of Match
    return (response as List)
        .map((matchJson) => Match.fromJson(matchJson))
        .toList();
  }
}