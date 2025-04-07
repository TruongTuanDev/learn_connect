import 'package:flutter/material.dart';
class InterestGrid extends StatelessWidget {
  final List<String> interests;
  final Set<String> selectedInterests;
  final Function(String) onSelect;

  InterestGrid({required this.interests, required this.selectedInterests, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2.5,
      ),
      itemCount: interests.length,
      itemBuilder: (context, index) {
        String interest = interests[index];
        bool isSelected = selectedInterests.contains(interest);
        return GestureDetector(
          onTap: () => onSelect(interest),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              interest,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        );
      },
    );
  }
}
