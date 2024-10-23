import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './models.dart';

class HomeController extends GetxController {
  var banners = <BannerModel>[].obs;
  var categories = <CategoryModel>[].obs;
  var nearbyCenters = <MedicalCenterModel>[].obs;
  var doctors = <DoctorModel>[].obs; // Observable list for doctors

  @override
  void onInit() {
    super.onInit();
    loadData(); // Load the data on initialization
  }

  Future<void> loadData() async {
    final String response = await rootBundle.loadString('assets/v1.json');
    final data = json.decode(response);

    banners.value = (data['banners'] as List).map((e) => BannerModel.fromJson(e)).toList();
    categories.value = (data['categories'] as List).map((e) => CategoryModel.fromJson(e)).toList();
    nearbyCenters.value = (data['nearby_centers'] as List).map((e) => MedicalCenterModel.fromJson(e)).toList();
    doctors.value = (data['doctors'] as List).map((e) => DoctorModel.fromJson(e)).toList();
  }

  void reverseDoctorsList() {
    doctors.value = doctors.reversed.toList();
  }
}
