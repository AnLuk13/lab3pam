import 'package:flutter/material.dart';
import 'doctor_card.dart';
import '../models.dart'; // Import the DoctorModel

class DoctorListSection extends StatefulWidget {
  final List<DoctorModel> doctors; // Pass the doctors list as a prop
  final VoidCallback onReverse; // Add a callback for reversing the list

  DoctorListSection({required this.doctors, required this.onReverse});

  @override
  _DoctorListSectionState createState() => _DoctorListSectionState();
}

class _DoctorListSectionState extends State<DoctorListSection> {
  // A map to store the favorite status of each doctor by their fullName or unique ID
  Map<String, bool> favoriteStatus = {};

  @override
  void initState() {
    super.initState();
    initializeFavoriteStatus(); // Ensure favorite status is initialized
  }

  // Initialize favorite status for all doctors
  void initializeFavoriteStatus() {
    for (var doctor in widget.doctors) {
      // Initialize favoriteStatus with false if it's not already initialized
      favoriteStatus[doctor.fullName] = favoriteStatus[doctor.fullName] ?? false;
    }
  }

  // Toggle favorite status for a specific doctor by their fullName
  void toggleFavorite(String fullName) {
    setState(() {
      favoriteStatus[fullName] = !(favoriteStatus[fullName] ?? false); // Safely toggle favorite status
    });
  }

  @override
  Widget build(BuildContext context) {
    // If no doctors are passed, display a message or loading state
    if (widget.doctors.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display the number of found doctors
            Text(
              '${widget.doctors.length} found',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            GestureDetector(
              onTap: widget.onReverse, // Reverse list when clicked
              child: const Text(
                'Default',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        // ListView.builder to render the doctor list
        Expanded(
          child: ListView.builder(
            itemCount: widget.doctors.length,
            itemBuilder: (context, index) {
              final doctor = widget.doctors[index];
              return DoctorCard(
                key: ValueKey(doctor.fullName), // Use the doctor's fullName as the unique key
                name: doctor.fullName,
                specialty: doctor.typeOfDoctor,
                location: doctor.locationOfCenter,
                rating: doctor.reviewRate,
                reviews: doctor.reviewsCount,
                imagePath: doctor.image, // Network image
                isFavorite: favoriteStatus[doctor.fullName] ?? false, // Pass the favorite status safely
                onFavoriteToggle: () => toggleFavorite(doctor.fullName), // Pass the toggle function
              );
            },
          ),
        ),
      ],
    );
  }
}
