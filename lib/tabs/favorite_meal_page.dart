import 'package:flutter/material.dart';

class FavoriteMealPage extends StatelessWidget {
  const FavoriteMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Return false to prevent the back action
        return false;
      },
      child: const Scaffold(
        // appBar: AppBar(
        //   title: Text('Favorite Meals'),
        // ),
        body: Center(
          child: Text('Here are your favorite meals.',
              style: TextStyle(fontSize: 24)),
        ),
      ),
    );
  }
}
