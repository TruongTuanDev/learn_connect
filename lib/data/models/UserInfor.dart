class UserInfo {
  final String id_user;
  final String username;
  final String fullName;
  final String? nickname;
  final String? birthDate;
  final String? email;
  final String? phoneCode;
  final String? gender;

  final String? nativeLanguage;
  final Map<String, String>? targetLanguages;
  final List<String>? learningGoals;
  final String? dailyTime;
  final List<String>? interestedCountries;
  final List<String>? culturalPreferences;

  final String? createdAt;
  final String? updatedAt;

  UserInfo({
    required this.id_user,
    required this.username,
    required this.fullName,
    this.nickname,
    this.birthDate,
    this.email,
    this.phoneCode,
    this.gender,
    this.nativeLanguage,
    this.targetLanguages,
    this.learningGoals,
    this.dailyTime,
    this.interestedCountries,
    this.culturalPreferences,
    this.createdAt,
    this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id_user: json['id_user'],
    username: json['username'],
    fullName: json['fullName'],
    nickname: json['nickname'],
    birthDate: json['birthDate'],
    email: json['email'],
    phoneCode: json['phoneCode'],
    gender: json['gender'],
    nativeLanguage: json['nativeLanguage'],
    targetLanguages: Map<String, String>.from(json['targetLanguages'] ?? {}),
    learningGoals: List<String>.from(json['learningGoals'] ?? []),
    dailyTime: json['dailyTime'],
    interestedCountries: List<String>.from(json['interestedCountries'] ?? []),
    culturalPreferences: List<String>.from(json['culturalPreferences'] ?? []),
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id_user': id_user,
    'username': username,
    'fullName': fullName,
    'nickname': nickname,
    'birthDate': birthDate,
    'email': email,
    'phoneCode': phoneCode,
    'gender': gender,
    'nativeLanguage': nativeLanguage,
    'targetLanguages': targetLanguages,
    'learningGoals': learningGoals,
    'dailyTime': dailyTime,
    'interestedCountries': interestedCountries,
    'culturalPreferences': culturalPreferences,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
