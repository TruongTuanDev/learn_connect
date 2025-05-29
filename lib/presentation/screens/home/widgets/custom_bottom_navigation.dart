import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const CustomBottomNavigation({
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: Colors.white,
      elevation: 10,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(
              icon: Icons.home,
              label: "Trang chủ",
              isSelected: currentIndex == 0,
              onTap: () => onTabSelected(0),
            ),
            _buildTabItem(
              icon: Icons.explore,
              label: "Khám phá",
              isSelected: currentIndex == 1,
              onTap: () => onTabSelected(1),
            ),
            SizedBox(width: 40), // Khoảng trống cho nút FAB
            _buildTabItem(
              icon: Icons.history,
              label: "Nhật ký",
              isSelected: currentIndex == 2,
              onTap: () => onTabSelected(2),
            ),
            _buildTabItem(
              icon: Icons.person,
              label: "Hồ sơ",
              isSelected: currentIndex == 3,
              onTap: () => onTabSelected(3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blueAccent : Colors.grey,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blueAccent : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}