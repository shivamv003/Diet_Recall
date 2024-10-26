import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
     return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the back action
        return false;
      },
     child: const Scaffold(
      // appBar: AppBar(
      //   title: Text('Notifications'),
      // ),
      body: Center(
        child: Text('You have no new notifications.', style: TextStyle(fontSize: 24)),
      ),
     ),
    );
  }
}
