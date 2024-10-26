import 'package:flutter/material.dart';

class UserSupportPage extends StatelessWidget {
  const UserSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the back action
        return false;
      },
    child: Scaffold(
      // appBar: AppBar(
      //   title: Text('User Support'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter your question or feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle submission
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
