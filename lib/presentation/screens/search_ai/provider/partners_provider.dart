// user_partners_notifier.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPartnersNotifier extends StateNotifier<List<dynamic>> {
  UserPartnersNotifier() : super([]);

  void setPartners(List<dynamic> partners) {
    state = partners;
  }

  void clearPartners() {
    state = [];
  }
}