import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/SliderScreen.dart';

class RegistrationController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var profilePicPath = ''.obs;

  Future<void> saveDataToLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name.value);
    await prefs.setString('email', email.value);
    await prefs.setString('profilePicPath', profilePicPath.value);
    Get.to(()=> SliderScreen());
  }
}
