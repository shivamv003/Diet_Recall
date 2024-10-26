import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diet_recall/authentication/first_screen.dart';
// import 'package:diet_recall/authentication/secondpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String name = '';
  String age = '';
  String gender = '';
  String email = '';
  String phone_number = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  } //

  Future<void> _getUserDetails() async {
    try {
      // Get the current user
      User? user = _auth.currentUser;
      if (user != null) {
        String userEmail = user.email!;

        // Query Firestore to find the user document with the matching email in the Client collection
        QuerySnapshot querySnapshot = await _firestore
            .collection('users')
            .where('email', isEqualTo: userEmail)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Assuming the first document matches
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

          setState(() {
            name = documentSnapshot['name'];
            age = documentSnapshot['age'];
            gender = documentSnapshot['gender'];
            email = documentSnapshot['email'];
            phone_number = documentSnapshot['phone_number'];
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No client details found.')),
          );
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('An error occurred while fetching client details.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the back action
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'), // AppBar title set to 'Profile'
          // centerTitle: true, // Center the title in the AppBar
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Profile Image Container
                      // Container(
                      //   width: 140,
                      //   height: 140,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     border: Border.all(
                      //       color: Colors.black, // Border color
                      //       width: 6.0, // Border width
                      //     ),
                      //   ),
                      //   child: const CircleAvatar(
                      //     radius: 70,
                      //     backgroundImage: AssetImage(
                      //         'assets/profileimg.jpg'), // Placeholder image
                      //   ),
                      // ),
                      const SizedBox(
                          height: 45), // Space between avatar and details

                      // Profile Details
                      ProfileDetail(
                        label: 'Name: $name ',
                        value: '',
                      ),
                      const SizedBox(height: 16),
                      ProfileDetail(
                        label: 'Email: $email',
                        value: '',
                      ),
                      const SizedBox(height: 16),
                      ProfileDetail(
                        label: 'Phone: $phone_number ',
                        value: '',
                      ),
                      const SizedBox(height: 16),
                      ProfileDetail(
                        label: 'Age: $age ',
                        value: '',
                      ),
                      const SizedBox(height: 16),
                      ProfileDetail(
                        label: 'Gender: $gender ',
                        value: '',
                      ),
                      const SizedBox(
                          height: 95), // Space before the logout button

                      // Logout Button
                      ElevatedButton(
                        onPressed: () async {
                          // Sign out the user
                          await FirebaseAuth.instance.signOut();

                          // Navigate to the SecondPage
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AuthScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 220, 97, 97),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          padding: const EdgeInsets.all(10),
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        child: const Text('  log out  '),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetail({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(width: 4), // Space between label and value
        Expanded(
          // Allows text to wrap if it's too long
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
