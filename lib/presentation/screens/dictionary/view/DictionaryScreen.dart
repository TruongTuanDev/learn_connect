import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DictionaryScreen extends StatefulWidget {
  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();
  Timer? _debounce;

  String _definition = '';
  String _wordType = '';
  String _example = '';
  String _audioUrl = '';
  String _errorMessage = '';
  bool _isLoading = false;

  List<String> _history = [];
  List<String> _suggestions = [];
  String _selectedLanguage = 'ko'; // Default language

  final List<Map<String, String>> languages = [
    {'code': 'en', 'name': 'Tiếng Anh', 'flag': 'gb'},
    {'code': 'es', 'name': 'Tiếng Tây Ban Nha', 'flag': 'es'},
    {'code': 'fr', 'name': 'Tiếng Pháp', 'flag': 'fr'},
    {'code': 'de', 'name': 'Tiếng Đức', 'flag': 'de'},
    {'code': 'it', 'name': 'Tiếng Ý', 'flag': 'it'},
    {'code': 'ja', 'name': 'Tiếng Nhật', 'flag': 'jp'},
    {'code': 'ko', 'name': 'Tiếng Hàn', 'flag': 'kr'},
    {'code': 'zh', 'name': 'Tiếng Trung', 'flag': 'cn'},
    {'code': 'vi', 'name': 'Tiếng Việt', 'flag': 'vn'},
  ];

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), () {
      final word = _controller.text.trim();
      if (word.isNotEmpty) {
        fetchDefinition(word);
        fetchSuggestions(word);
      }
    });
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _history = prefs.getStringList('history') ?? [];
    });
  }

  Future<void> _saveToHistory(String word) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_history.contains(word)) {
      _history.insert(0, word);
      if (_history.length > 20) _history = _history.sublist(0, 20);
      await prefs.setStringList('history', _history);
      setState(() {});
    }
  }

  Future<void> fetchDefinition(String word) async {
    setState(() {
      _isLoading = true;
      _definition = '';
      _wordType = '';
      _example = '';
      _audioUrl = '';
      _errorMessage = '';
    });

    try {
      final url = Uri.parse(
          'https://api.dictionaryapi.dev/api/v2/entries/$_selectedLanguage/$word');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final meanings = data[0]['meanings'];
        final phonetics = data[0]['phonetics'];

        setState(() {
          _definition = meanings[0]['definitions'][0]['definition'];
          _wordType = meanings[0]['partOfSpeech'];
          _example = meanings[0]['definitions'][0]['example'] ?? 'Không có ví dụ';
          _audioUrl = phonetics.firstWhere(
                (e) => e['audio'] != null && e['audio'] != '',
            orElse: () => {'audio': ''},
          )['audio'];
          _isLoading = false;
        });

        await _saveToHistory(word);
      } else {
        setState(() {
          _errorMessage = 'Không tìm thấy từ "$word"';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Lỗi kết nối: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> fetchSuggestions(String word) async {
    try {
      final url = Uri.parse('https://api.datamuse.com/words?sp=$word*');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        setState(() {
          _suggestions = data.map((e) => e['word'] as String).toList();
        });
      }
    } catch (e) {
      print('Lỗi khi tìm gợi ý: $e');
    }
  }

  void _playAudio() {
    if (_audioUrl.isNotEmpty) {
      _audioPlayer.play(UrlSource(_audioUrl));
    }
  }

  void _onHistoryTap(String word) {
    _controller.text = word;
    fetchDefinition(word);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Từ điển'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  value: _selectedLanguage,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedLanguage = newValue;
                      });
                      final word = _controller.text.trim();
                      if (word.isNotEmpty) {
                        fetchDefinition(word);
                      }
                    }
                  },
                  items: languages.map((lang) {
                    return DropdownMenuItem<String>(
                      value: lang['code'],
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'packages/country_icons/icons/flags/svg/${lang['flag']}.svg',
                            width: 24,
                            height: 24,
                          ),
                          SizedBox(width: 8),
                          Text(lang['name']!),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Nhập từ cần tra',
                      border: OutlineInputBorder(),
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          setState(() {
                            _definition = '';
                            _errorMessage = '';
                          });
                        },
                      )
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_isLoading) Center(child: CircularProgressIndicator()),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            if (_definition.isNotEmpty)
              Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Chip(
                            label: Text(
                              _wordType,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                          if (_audioUrl.isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.volume_up, color: Colors.blue),
                              onPressed: _playAudio,
                            ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Định nghĩa:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(_definition),
                      SizedBox(height: 12),
                      Text(
                        'Ví dụ:',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _example,
                        style: TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 20),
            if (_suggestions.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Gợi ý:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _suggestions
                        .take(5)
                        .map((s) => ActionChip(
                      label: Text(s),
                      onPressed: () {
                        _controller.text = s;
                        fetchDefinition(s);
                      },
                    ))
                        .toList(),
                  ),
                ],
              ),
            SizedBox(height: 20),
            if (_history.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lịch sử tra cứu:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: _history
                        .take(10)
                        .map((word) => ActionChip(
                      label: Text(word),
                      onPressed: () => _onHistoryTap(word),
                    ))
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}