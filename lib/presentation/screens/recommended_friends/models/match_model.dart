import 'package:learn_connect/data/models/UserInfor.dart';

class Match {
  final UserInfo user;
  final double matchScore;
  final List<String>? matchReasons;

  Match({
    required this.user,
    required this.matchScore,
    this.matchReasons,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      user: UserInfo.fromJson(json),
      matchScore: json['match_score'],
      matchReasons: json['match_reasons'] != null
          ? List<String>.from(json['match_reasons'])
          : null,
    );
  }
}