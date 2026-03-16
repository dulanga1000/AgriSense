import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final bool highlightSelected;

  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.highlightSelected = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color neutralColor = Colors.grey.shade600;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: highlightSelected ? Colors.green : neutralColor,
      unselectedItemColor: neutralColor,
      selectedLabelStyle: highlightSelected
          ? null
          : const TextStyle(fontWeight: FontWeight.normal),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.viewfinder),
          label: 'Scan',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.cloud_sun),
          label: 'Weather',
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
