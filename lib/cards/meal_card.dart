import 'package:flutter/material.dart';

class MealCard extends StatelessWidget {
  final String title;
  final int kcal;
  final String description;
  final String ingredients;
  final String imageUrl;

  const MealCard({super.key, required this.title, required this.kcal, required this.description, required this.ingredients, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.network(imageUrl),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Kcal: $kcal'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Ingredients: $ingredients'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(description),
          ),
        ],
      ),
    );
  }
}
