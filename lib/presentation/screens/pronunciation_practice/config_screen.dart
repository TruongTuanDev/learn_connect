import 'package:flutter/material.dart';

class ConfigScreen extends StatelessWidget {
  final String selectedLanguage;
  final String selectedTopic;
  final String selectedLevel;
  final List<String> languages;
  final List<String> topics;
  final List<String> levels;
  final Function(String) onLanguageChanged;
  final Function(String) onTopicChanged;
  final Function(String) onLevelChanged;
  final VoidCallback onStartQuiz;
  final bool isLoading;

  const ConfigScreen({
    Key? key,
    required this.selectedLanguage,
    required this.selectedTopic,
    required this.selectedLevel,
    required this.languages,
    required this.topics,
    required this.levels,
    required this.onLanguageChanged,
    required this.onTopicChanged,
    required this.onLevelChanged,
    required this.onStartQuiz,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              'Tạo bài kiểm tra',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
                height: 1.2,
              ),
            ),
            Text(
              'Tùy chỉnh trải nghiệm học tập của bạn',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.shade100.withOpacity(0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildConfigSection(
                    title: 'Ngôn ngữ',
                    icon: Icons.language_rounded,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      value: selectedLanguage,
                      items: languages
                          .map(
                            (lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(
                            lang,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (val) => onLanguageChanged(val!),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.indigo.shade800,
                        size: 28,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                      dropdownColor: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildConfigSection(
                    title: 'Chủ đề',
                    icon: Icons.category_rounded,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      value: selectedTopic,
                      items: topics
                          .map(
                            (topic) => DropdownMenuItem(
                          value: topic,
                          child: Text(
                            topic,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (val) => onTopicChanged(val!),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.indigo.shade800,
                        size: 28,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                      dropdownColor: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _buildConfigSection(
                    title: 'Mức độ khó',
                    icon: Icons.bar_chart_rounded,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(color: Colors.indigo.shade200, width: 1.5),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                      value: selectedLevel,
                      items: levels
                          .map(
                            (lvl) => DropdownMenuItem(
                          value: lvl,
                          child: Text(
                            lvl,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                      )
                          .toList(),
                      onChanged: (val) => onLevelChanged(val!),
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.indigo.shade800,
                        size: 28,
                      ),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade800,
                      ),
                      dropdownColor: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 36),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : onStartQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 5,
                    shadowColor: Colors.indigo.shade300,
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  child: isLoading
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text('Đang tạo...'),
                    ],
                  )
                      : const Text('Bắt đầu bài kiểm tra'),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigSection({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: Colors.indigo.shade700,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        child,
      ],
    );
  }
}