// import 'package:flutter/material.dart';
// import 'package:shegernext/features/categories/presentation/screens/category_select_page.dart';
// import 'package:shegernext/features/user_posts/presentation/screens/user_posts_page.dart';
// import 'package:shegernext/features/profile/presentation/screens/profile_page.dart';
// import 'package:shegernext/l10n/app_localizations.dart';

// class MainPage extends StatefulWidget {
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   int _currentIndex = 0;

//   final List<Widget> _pages = <Widget>[
//     const CategorySelectPage(),
//     const UserPostsPage(),
//     const ProfilePage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context);

//     return Scaffold(
//       body: IndexedStack(index: _currentIndex, children: _pages),
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: <BoxShadow>[
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 10,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (int index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           backgroundColor: Colors.white,
//           selectedItemColor: const Color(0xFF661AFF),
//           unselectedItemColor: Colors.grey,
//           selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.category_outlined),
//               activeIcon: const Icon(Icons.category),
//               label: l10n.chooseCategory,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.list_alt_outlined),
//               activeIcon: const Icon(Icons.list_alt),
//               label: l10n.myComplaints,
//             ),
//             BottomNavigationBarItem(
//               icon: const Icon(Icons.person_outline),
//               activeIcon: const Icon(Icons.person),
//               label: l10n.profile,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
