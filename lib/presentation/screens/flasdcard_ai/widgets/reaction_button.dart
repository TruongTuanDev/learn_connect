import 'package:flutter/material.dart';

// Reaction button for difficulty rating
class ReactionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const ReactionButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, color: isSelected ? color : Colors.black, size: 32),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
