import 'package:diet_recall/tabs/profile_page.dart';
import 'package:diet_recall/tabs/user_support_page.dart';
// import 'package:diet_recall_app/screens/bmi_page.dart';
// import 'package:diet_recall_app/screens/dashboard_page.dart';
// import 'package:diet_recall_app/screens/favorite_meal_page.dart';
// import 'package:diet_recall_app/screens/notification_page.dart';
// import 'package:diet_recall_app/screens/profile_page.dart';
// import 'package:diet_recall_app/screens/user_support_page.dart';
import 'package:flutter/material.dart';

// import 'bmi_page.dart';
import 'main_screen/dashboard_page.dart';
import 'tabs/favorite_meal_page.dart';
import 'tabs/notification_page.dart';

class HomeePage extends StatefulWidget {
  const HomeePage({super.key});

  @override
  _HomeePageState createState() => _HomeePageState();
}

class _HomeePageState extends State<HomeePage> {
  int _selectedIndex = 0;

  // final List<String> _titles = [
  //   // 'DietDiary',
  //   'Favorites',
  //   'Notifications',
  //   'Support',
  // ];

  final List<Widget> _pages = [
    const DashboardScreen(), // Dashboard
    const FavoriteMealPage(), // Favorite meals
    const NotificationPage(), // Notifications
    const UserSupportPage(), // Support
    // const BMIPage(), // BMI Index
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the back action
        return false;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   // title: Text(_titles[_selectedIndex]),
        //   automaticallyImplyLeading: false,
        //   actions: [
        //     IconButton(
        //       icon: const Icon(Icons.person),
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => ProfileScreen()),
        //         );
        //       },
        //     ),
        //   ],
        // ),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: 'Favorite Meals'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(Icons.support), label: 'Support'),
            // BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'BMI'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.green[200],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
