import 'package:diet_recall/authentication/first_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      home: const HomePage(),
      routes: {
        // '/second': (context) => HomeePage(),
        // ignore: equal_keys_in_map
        '/second': (context) => const AuthScreen(),
        // '/second': (context) =>
        //     GenderScreen(), //just testing is going on for home page
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned.fill(
          child: Image.asset(
            "assets/homeback.png", // Your background image path
            fit: BoxFit.cover, // Ensures the image covers the entire screen
          ),
        ),
        // SizedBox(
        //   height: 40,
        // ),
        Align(
          alignment: const Alignment(0, 0.5),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 49, 224, 98),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(15),
                // Background color
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              child: const Text('   Get Started  > '),
            ),
          ),
        ),
      ]),
    );
  }
}
