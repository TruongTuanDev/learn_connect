import 'package:flutter/material.dart';
import 'package:learn_connect/presentation/screens/user_information/view/UserInterestsScreen.dart';
import 'package:learn_connect/presentation/screens/user_information/widgets/ContinueButton.dart';
import 'package:learn_connect/presentation/screens/user_information/widgets/InterestGrid.dart';
class UserInterestsScreenState extends State<UserInterestsScreen> {
  List<String> interests = ['Âm nhạc', 'Phim ảnh', 'Du lịch', 'Thể thao', 'Nấu ăn', 'Chụp ảnh', 'Game', 'Khám phá', 'Ngoại ngữ', 'Lập trình', 'Khởi nghiệp', 'Khác'];
  Set<String> selectedInterests = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Sở thích'),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(child: InterestGrid(interests: interests, selectedInterests: selectedInterests, onSelect: (interest) {
              setState(() {
                selectedInterests.contains(interest) ? selectedInterests.remove(interest) : selectedInterests.add(interest);
              });
            })),
          ],
        ),
      ),
    );
  }
}
