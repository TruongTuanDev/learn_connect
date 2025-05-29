import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:learn_connect/config/app_config.dart';
import '../../../providers/providers.dart';
import 'package:learn_connect/services/add_friend.dart';
class PartnerFinderScreen extends ConsumerWidget {
  const PartnerFinderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchedPartners = ref.watch(userPartnersProvider);
    final filteredPartners = ref.watch(filteredPartnersProvider);
    final searchController = ref.watch(searchControllerProvider);
    final selectedLanguage = ref.watch(selectedLanguageProvider);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Đối tác ngôn ngữ'),
        backgroundColor: Colors.blue,
        elevation: 10,
        shadowColor: Colors.blue.withOpacity(0.5),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt, color: Colors.white),
            onPressed: () => _showFilterDialog(context, ref),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Box với thiết kế đẹp
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm đối tác...',
                  prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                onChanged: (query) => _filterPartners(ref, query),
              ),
            ),
          ),
          Expanded(
            child: filteredPartners.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/no-partners.png', width: 150),
                  const SizedBox(height: 20),
                  const Text(
                    'Không tìm thấy đối tác phù hợp',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
                : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: filteredPartners.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final partner = filteredPartners[index];
                return _buildPartnerCard(context, ref, partner);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _filterPartners(WidgetRef ref, String query) {
    ref.read(searchControllerProvider).text = query;
    ref.read(filteredPartnersProvider.notifier).filterPartners(query);
  }

  void _showFilterDialog(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.read(selectedLanguageProvider);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.indigo],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Lọc theo ngôn ngữ',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.deepPurple,
                    value: selectedLanguage,
                    items: ['Tất cả', 'Tiếng Anh', 'Tiếng Nhật', 'Tiếng Hàn']
                        .map((lang) => DropdownMenuItem(
                      value: lang,
                      child: Text(
                        lang,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      ref.read(selectedLanguageProvider.notifier).state = value!;
                      ref.read(filteredPartnersProvider.notifier).filterByLanguage(value);
                      Navigator.pop(context);
                    },
                    underline: const SizedBox(),
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: const Text(
                    'Áp dụng',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPartnerDetail(BuildContext context, dynamic partner) {
    final isFemale = partner['gender'] == 'Nữ';

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isFemale
                  ? [Colors.pink.shade200, Colors.purple.shade300]
                  : [Colors.blue.shade200, Colors.teal.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          partner['avatarUrl'] ??
                              (isFemale
                                  ? 'https://www.w3schools.com/howto/img_avatar2.png'
                                  : 'https://www.w3schools.com/howto/img_avatar.png'),
                        ),
                      ),
                    ),
                  ),
                  if (_isPartnerActive(partner))
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                partner['nickname'] ?? partner['username'],
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isFemale ? Icons.female : Icons.male,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  if (partner['isVip'] ?? false)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.amber, Colors.orange],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'VIP',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              _buildDetailRow('Ngôn ngữ mẹ đẻ', partner['nativeLanguage'] ?? ''),
              _buildDetailRow('Ngôn ngữ mục tiêu',
                  partner['targetLanguages']?.keys.first ?? ''),
              _buildDetailRow('Trình độ',
                  partner['targetLanguages']?.values.first ?? ''),
              _buildDetailRow('Tuổi', _calculateAge(partner['birthDate'])),
              _buildDetailRow('Thời gian học/ngày', partner['dailyTime'] ?? ''),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: TextButton(
                  onPressed: () async {

                    String result = await AddFriendService().addFriend(
                      idUser: AppConfig.userId,
                      idFriend: partner['id_user'],
                      nameFriend: partner['fullName'],
                      avatar: partner['avatarUrl'],
                    );
                    // Thực hiện sự kiện ở đây
                    print('Đã nhấn Kết nối ngay');
                    // Ví dụ: Navigator.push(...);
                  },
                  child: Text(
                    'Kết nối ngay',
                    style: TextStyle(
                      color: isFemale ? Colors.pink : Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _calculateAge(String? birthDate) {
    if (birthDate == null) return '';
    try {
      final birth = DateFormat('yyyy-MM-dd').parse(birthDate);
      final now = DateTime.now();
      final age = now.year - birth.year - ((now.month < birth.month || (now.month == birth.month && now.day < birth.day)) ? 1 : 0);
      return age.toString();
    } catch (_) {
      return '';
    }
  }

  bool _isPartnerActive(dynamic partner) {
    return partner['isOnline'] == true;
  }

  String _getLearningGoalsText(dynamic goals) {
    if (goals == null) return '';
    if (goals is List) {
      return goals.join(', ');
    }
    return goals.toString();
  }

  List<String> _generateTags(dynamic partner) {
    final tags = <String>[];
    if (partner['country'] != null) tags.add(partner['country']);
    if (partner['interests'] is List) tags.addAll(List<String>.from(partner['interests']));
    return tags;
  }

  Widget _buildPartnerCard(BuildContext context, WidgetRef ref, dynamic partner) {
    final targetLanguage = partner['targetLanguages']?.keys.first ?? 'Ngôn ngữ mục tiêu';
    final level = partner['targetLanguages']?.values.first ?? '';
    final age = _calculateAge(partner['birthDate']);
    final dailyTime = partner['dailyTime'] ?? '';
    final isFemale = partner['gender'] == 'Nữ';
    final isVip = partner['isVip'] ?? false;

    // Màu sắc theo giới tính
    final genderColor = isFemale ? Colors.pink : Colors.blue;
    final gradientColors = isFemale
        ? [Colors.pink.shade200, Colors.purple.shade300]
        : [Colors.blue.shade200, Colors.teal.shade300];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => _showPartnerDetail(context, partner),
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      // Ảnh đại diện với border đẹp
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 3,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              partner['avatarUrl'] ??
                                  (isFemale
                                      ? 'https://www.w3schools.com/howto/img_avatar2.png'
                                      : 'https://www.w3schools.com/howto/img_avatar.png'),
                            ),
                          ),
                        ),
                      ),
                      if (_isPartnerActive(partner))
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                partner['nickname'] ?? partner['username'],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            if (isVip)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Colors.amber, Colors.orange],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'VIP',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 8),
                            Icon(
                              isFemale ? Icons.female : Icons.male,
                              size: 20,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '${partner['nativeLanguage']} → $targetLanguage ($level)',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (age.isNotEmpty || dailyTime.isNotEmpty)
                          Row(
                            children: [
                              if (age.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$age tuổi',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              if (age.isNotEmpty && dailyTime.isNotEmpty)
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  child: Icon(
                                    Icons.circle,
                                    size: 4,
                                    color: Colors.white,
                                  ),
                                ),
                              if (dailyTime.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    '$dailyTime/ngày',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _getLearningGoalsText(partner['learningGoals']),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _generateTags(partner)
                              .map((tag) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Các providers
final searchControllerProvider = Provider<TextEditingController>((ref) => TextEditingController());
final selectedLanguageProvider = StateProvider<String>((ref) => 'Tất cả');
final filteredPartnersProvider = StateNotifierProvider<FilteredPartnersNotifier, List<dynamic>>((ref) {
  final partners = ref.watch(userPartnersProvider);
  return FilteredPartnersNotifier(partners);
});

class FilteredPartnersNotifier extends StateNotifier<List<dynamic>> {
  final List<dynamic> allPartners;

  FilteredPartnersNotifier(this.allPartners) : super(allPartners);

  void filterPartners(String query) {
    state = allPartners.where((partner) {
      final name = partner['nickname'] ?? partner['username'] ?? '';
      return name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  void filterByLanguage(String language) {
    if (language == 'Tất cả') {
      state = allPartners;
    } else {
      state = allPartners.where((partner) {
        return partner['targetLanguages']?.keys.contains(language) ?? false;
      }).toList();
    }
  }
}