import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class BottomNavBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const BottomNavBarWidget({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
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
