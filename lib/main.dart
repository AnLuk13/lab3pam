import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX package
import 'widgets/app_bar.dart';
import 'widgets/search_bar.dart' as custom; // Alias the custom SearchBar
import 'widgets/specialist_banner_slider.dart';
import 'widgets/categories_section.dart';
import 'widgets/medical_centers_section.dart';
import 'widgets/doctor_list_section.dart';
import '/home_controller.dart'; // Import your GetX controller

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // Use GetMaterialApp for GetX
      theme: ThemeData(fontFamily: 'Roboto'),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  // Initialize the HomeController here
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: buildAppBar(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      custom.SearchBar(),
                      SizedBox(height: 20),
                      // Only wrap SpecialistBannerSlider with Obx
                      Obx(() {
                        return controller.banners.isNotEmpty
                            ? SpecialistBannerSlider(banners: controller.banners)
                            : CircularProgressIndicator();
                      }),
                      SizedBox(height: 20),
                      // Only wrap CategoriesSection with Obx
                      Obx(() {
                        return controller.categories.isNotEmpty
                            ? CategoriesSection(categories: controller.categories)
                            : CircularProgressIndicator();
                      }),
                      SizedBox(height: 20),
                      // Only wrap MedicalCentersSection with Obx
                      Obx(() {
                        return controller.nearbyCenters.isNotEmpty
                            ? MedicalCentersSection(centers: controller.nearbyCenters)
                            : CircularProgressIndicator();
                      }),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: Obx(() {
            return controller.doctors.isNotEmpty
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              // Pass reverseDoctorsList function as a prop
              child: DoctorListSection(
                doctors: controller.doctors,
                onReverse: controller.reverseDoctorsList, // Pass reverse function
              ),
            )
                : Center(child: CircularProgressIndicator());
          }),
        ),
      ),
    );
  }
}
