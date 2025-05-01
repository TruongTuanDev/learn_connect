// match_card.dart
import 'package:flutter/material.dart';

class MatchCard extends StatelessWidget {
  final dynamic match;
  final VoidCallback onTap;

  const MatchCard({required this.match, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Text(match['username'][0].toUpperCase()),
                    radius: 24,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          match['username'],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Ngôn ngữ: ${match['nativeLanguage']}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(
                      '${(match['match_score'] * 100).toStringAsFixed(0)}%',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
              SizedBox(height: 12),
              if (match['targetLanguages'] != null)
                Wrap(
                  spacing: 4,
                  children: (match['targetLanguages'] as Map<String, dynamic>)
                      .entries
                      .map((e) => Chip(
                    label: Text('${e.key}: ${e.value}'),
                    backgroundColor: Colors.blue[50],
                  ))
                      .toList(),
                ),
              SizedBox(height: 8),
              if (match['culturalPreferences'] != null)
                Wrap(
                  spacing: 4,
                  children: (match['culturalPreferences'] as List<dynamic>)
                      .map((pref) => Chip(
                    label: Text(pref),
                    backgroundColor: Colors.green[50],
                  ))
                      .toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}