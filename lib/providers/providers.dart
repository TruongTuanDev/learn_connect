// providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/search_ai/provider/partners_provider.dart';

final userPartnersProvider = StateNotifierProvider<UserPartnersNotifier, List<dynamic>>(
      (ref) => UserPartnersNotifier(),
);