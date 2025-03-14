import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_connect/presentation/screens/conversation/call/call_model.dart';

final callModelProvider = Provider((ref) => CallModel());

final callProvider = FutureProvider<List<Call>>((ref) async {
  final callModel = ref.read(callModelProvider);
  return await callModel.fetchCalls();
});
