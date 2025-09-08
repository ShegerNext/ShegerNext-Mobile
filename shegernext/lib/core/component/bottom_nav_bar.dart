import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shegernext/core/config/route_names.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        switch (index) {
          case 0:
            context.goNamed(RouteNames.categorySelect);
            break;
          case 1:
            context.goNamed(RouteNames.userPosts);
            break;
          case 2:
            context.goNamed('');
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xFF661AFF),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_outlined),
          label: 'My Complaints',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}