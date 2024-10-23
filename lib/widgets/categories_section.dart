import 'dart:math'; // Import the dart:math package
import 'package:flutter/material.dart';
import '../models.dart';
import 'category_card.dart';

class CategoriesSection extends StatelessWidget {
  final List<CategoryModel> categories; // Passing categories as a prop

  CategoriesSection({required this.categories}); // Constructor for categories

  @override
  Widget build(BuildContext context) {
    // If categories are empty, show loading indicator
    if (categories.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    // Split categories into two rows
    int mid = (categories.length / 2).ceil(); // Calculate the midpoint
    var firstRow = categories.sublist(0, mid);
    var secondRow = categories.sublist(mid);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('See All', style: TextStyle(color: Colors.blue)),
          ],
        ),
        SizedBox(height: 16),

        // First row of categories
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: firstRow.map((category) {
            return CategoryCard(
              title: category.title,
              iconPath: category.icon,
              backgroundColor: _getRandomColor(), // Assign random background color
            );
          }).toList(),
        ),

        SizedBox(height: 16),

        // Second row of categories
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: secondRow.map((category) {
            return CategoryCard(
              title: category.title,
              iconPath: category.icon,
              backgroundColor: _getRandomColor(), // Assign random background color
            );
          }).toList(),
        ),
      ],
    );
  }

  // Function to generate random colors
  Color _getRandomColor() {
    final Random random = Random();
    return Color.fromARGB(
      255, // Full opacity
      random.nextInt(256), // Random red value
      random.nextInt(256), // Random green value
      random.nextInt(256), // Random blue value
    );
  }
}
