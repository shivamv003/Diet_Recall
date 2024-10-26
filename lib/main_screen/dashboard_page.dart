import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_recall/BMI.dart/bmi_genderscreen.dart';
import 'package:diet_recall/main_screen/add_meal_page.dart';
import 'package:diet_recall/main_screen/bmi_page.dart';
import 'package:diet_recall/tabs/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String? userName; // Variable to store the user's name
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _fetchUserName(); // Fetch the user name when the widget is initialized
  }

  // Function to fetch the user's name from Firestore
  Future<void> _fetchUserName() async {
    try {
      // Get the current user's ID
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final uid = user.uid;

        // Fetch user details from Firestore
        final userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        // Check if the user document exists and retrieve the name
        if (userDoc.exists) {
          setState(() {
            userName = userDoc.data()?['name'] ??
                'User'; // Default to 'User' if name not found
          });
        }
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: AppBar(
        // title: const Text('Dashboard'), // Title of the AppBar
        leading: IconButton(
          icon: const Icon(Icons.menu), // Menu icon on the left
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer(); // Open the Drawer
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle), // Profile icon on the right
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        // Customize your drawer here
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 100, // Set a shorter height for the DrawerHeader
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
            ),
            // Add more items here as needed
          ],
        ),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hey ${userName ?? '...'}\nHow is your diet today?', // Display the user's name
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  child: _buildBarGraphs(),
                ),
                const SizedBox(height: 20),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryButton('Breakfast', Icons.free_breakfast),
                      _buildCategoryButton('Lunch', Icons.lunch_dining),
                      _buildCategoryButton('Dinner', Icons.dinner_dining),
                      _buildCategoryButton('Diet Plan', Icons.assignment),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children: <Widget>[
                    DashboardCard(
                      title: 'Diet Plan',
                      icon: Icons.restaurant_menu,
                      onTap: () {
                        // Navigate to Diet Plan page
                      },
                    ),
                    DashboardCard(
                      title: 'Next Meal Time',
                      icon: Icons.access_time,
                      onTap: () {
                        // Navigate to Next Meal page
                      },
                    ),
                    DashboardCard(
                      title: 'Pick Your Meal',
                      icon: Icons.fastfood,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddMealPage()),
                        );
                      },
                    ),
                    DashboardCard(
                      title: 'BMI Calculate',
                      icon: Icons.person,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GenderScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarGraphs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nutritional Intake',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _buildBar('Calories', 300, 450, Colors.green),
        const SizedBox(height: 10),
        _buildBar('Carbs', 200, 350, Colors.blue),
        const SizedBox(height: 10),
        _buildBar('Proteins', 150, 250, Colors.orange),
        const SizedBox(height: 10),
        _buildBar('Fats', 100, 150, Colors.red),
      ],
    );
  }

  Widget _buildBar(String label, double consumed, double total, Color color) {
    double percentage = consumed / total;
    double width;

    switch (label) {
      case 'Calories':
        width = 300;
        break;
      case 'Carbs':
        width = 230;
        break;
      case 'Proteins':
        width = 160;
        break;
      case 'Fats':
        width = 190;
        break;
      default:
        width = 80;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Container(
          width: width,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(221, 0, 0, 0),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton.icon(
        onPressed: () {
          // Action when button is pressed
        },
        icon: Icon(icon, size: 18),
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;

  const DashboardCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: Colors.green[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, size: 50, color: Colors.white),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
