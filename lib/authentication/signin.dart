import 'package:diet_recall/cards/custom_textfield.dart';
import 'package:diet_recall/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final phonenoController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      String uid = userCredential.user!.uid;

      await firestore.collection('users').doc(uid).set({
        'email': _emailController.text,
        'name': nameController.text,
        'age': ageController.text,
        'gender': genderController.text,
        'phone_number': phonenoController.text,
      });

      Navigator.of(context).pop();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeePage()),
      );
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred, please try again.')),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    genderController.dispose();
    phonenoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Allow the gradient to stretch behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Transparent app bar
      ),

      body: Container(
        decoration: const BoxDecoration(
          color: Colors.amber,
        ),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            // 20% Container for Title/Description
            const Expanded(
              flex:
                  3, // 20% of the screen height for the title/description section
              child: Padding(
                padding: EdgeInsets.only(
                    top: 50.0, left: 16.0), // Adjust top and left padding
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align to the left
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Ensure no vertical centering
                  children: [
                    Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Sign up to get started.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 80% Container for the Form
            Expanded(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name and Age in one row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomTextField(
                                  controller: nameController,
                                  hintText: 'Enter your name',
                                  icon: Icons.person,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Age',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomTextField(
                                  controller: ageController,
                                  hintText: 'Enter your age',
                                  icon: Icons.cake,
                                  keyboardType: TextInputType.number,
                                  inputFormatter:
                                      FilteringTextInputFormatter.digitsOnly,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Gender and Contact Number in another row
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Gender',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                DropdownButtonFormField<String>(
                                  value: genderController.text.isNotEmpty
                                      ? genderController.text
                                      : null,
                                  items: <String>['Male', 'Female', 'Others']
                                      .map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    genderController.text = newValue ?? '';
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    hintText: 'Select your gender',
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 234, 230, 230),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0),
                                      borderSide: BorderSide.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Contact Number',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                CustomTextField(
                                  controller: phonenoController,
                                  hintText: 'Enter your contact no.',
                                  icon: Icons.phone,
                                  keyboardType: TextInputType.phone,
                                  inputFormatter:
                                      FilteringTextInputFormatter.digitsOnly,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Email and Password in separate lines
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Enter your email',
                        icon: Icons.email,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        icon: Icons.lock,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      const SizedBox(height: 20), // Space for the button
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: _signUp,
                          style: TextButton.styleFrom(
                            side: const BorderSide(width: 1.0),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.all(15),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
