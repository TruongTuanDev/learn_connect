import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/match_provider.dart';
import '../models/match_model.dart';

class MatchScreen extends StatelessWidget {
  final String userId;

  const MatchScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gợi ý kết bạn'),
      ),
      body: Consumer<MatchProvider>(
        builder: (context, matchProvider, child) {
          if (matchProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (matchProvider.error != null) {
            return Center(
              child: Text('Lỗi: ${matchProvider.error}'),
            );
          }

          if (matchProvider.matches.isEmpty) {
            return const Center(
              child: Text('Không tìm thấy kết quả phù hợp'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: matchProvider.matches.length,
            itemBuilder: (context, index) {
              final match = matchProvider.matches[index];
              return _buildMatchCard(match, context);
            },
          );
        },
      ),
    );
  }

  Widget _buildMatchCard(Match match, BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  child: Text(match.user.username[0].toUpperCase()),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match.user.username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Ngôn ngữ: ${match.user.nativeLanguage}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(
                    '${(match.matchScore * 100).toStringAsFixed(0)}%',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (match.user.targetLanguages!.isNotEmpty)
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: match.user.targetLanguages!.entries.map((entry) {
                  return Chip(
                    label: Text('${entry.key}: ${entry.value}'),
                    backgroundColor: Colors.blue[50],
                  );
                }).toList(),
              ),
            const SizedBox(height: 8),
            if (match.user.culturalPreferences!.isNotEmpty)
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: match.user.culturalPreferences!.map((pref) {
                  return Chip(
                    label: Text(pref),
                    backgroundColor: Colors.orange[50],
                  );
                }).toList(),
              ),
            if (match.matchReasons != null && match.matchReasons!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  const Text(
                    'Lý do phù hợp:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...match.matchReasons!.map((reason) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text('- $reason'),
                    );
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}