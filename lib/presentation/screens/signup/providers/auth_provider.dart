import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

// Mô hình dữ liệu đăng ký
class SignUpModel {
  final String email;
  final String password;
  final String name;

  SignUpModel({required this.email, required this.password, required this.name});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "name": name,
    };
  }
}

// Trạng thái đăng ký
enum SignUpStatus { initial, loading, success, error }

// Provider lưu trạng thái đăng ký
class SignUpState {
  final SignUpStatus status;
  final String? errorMessage;

  SignUpState({this.status = SignUpStatus.initial, this.errorMessage});

  SignUpState copyWith({SignUpStatus? status, String? errorMessage}) {
    return SignUpState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Provider quản lý đăng ký
class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier() : super(SignUpState());

  final Dio _dio = Dio();


  Future<void> signUp(SignUpModel model) async {
    state = state.copyWith(status: SignUpStatus.loading); // Đang xử lý

    try {
      final response = await _dio.post(
        'https://5000/signup', // API đk
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        state = state.copyWith(status: SignUpStatus.success);
      } else {
        state = state.copyWith(status: SignUpStatus.error, errorMessage: "Đăng ký thất bại");
      }
    } catch (e) {
      state = state.copyWith(status: SignUpStatus.error, errorMessage: "Lỗi: ${e.toString()}");
    }
  }
}

// Provider Riverpod quản lý trạng thái đăng ký
final signUpProvider = StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  return SignUpNotifier();
});