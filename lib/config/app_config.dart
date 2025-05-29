import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static const String socketServerUrl = "http://localhost:8080";
  static String userId = "680b1d44203bdd4db4fc2777";

  static String get baseUrl {
    // Sử dụng flutter_dotenv
    return dotenv.env['BASE_URL'] ?? 'http://fallback-url.com';
  }
}