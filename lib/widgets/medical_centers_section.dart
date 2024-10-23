import 'package:flutter/material.dart';
import '../models.dart';
import 'medical_center_card.dart';

class MedicalCentersSection extends StatelessWidget {
  final List<MedicalCenterModel> centers; // Now passing centers as a prop

  MedicalCentersSection({required this.centers}); // Constructor for centers

  @override
  Widget build(BuildContext context) {
    // If centers are empty, show loading indicator
    if (centers.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Nearby Medical Centers',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('See All', style: TextStyle(color: Colors.blue)),
          ],
        ),
        SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: centers.map((center) {
              return MedicalCenterCard(
                title: center.title,
                location: center.locationName,
                rating: center.reviewRate,
                distance: '${center.distanceKm} km',
                time: '${center.distanceMinutes} min',
                imagePath: center.image,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
