import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:camera/camera.dart';

import '../Widgets/myButton.dart';
import '../controllers/RegistrationController.dart';
import 'ApiDataScreen.dart';
import 'CameraScreen.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController controller = Get.put(RegistrationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) => controller.name.value = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) => controller.email.value = value,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                try {
                  List<CameraDescription> cameras = await availableCameras();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CameraScreen(
                        onCapture: (path) {
                          controller.profilePicPath.value = path;
                        },
                      ),
                    ),
                  );
                } catch (e) {
                  Get.snackbar('Error', 'Unable to access the camera: $e');
                }
              },
              child: const Center(child: Text('Take Selfie')),
            ),
            Obx(() {
              return controller.profilePicPath.isNotEmpty
                  ? Image.file(
                File(controller.profilePicPath.value),
                height: 100,
              )
                  : const SizedBox.shrink();
            }),
            const SizedBox(height: 20),
            myButton(
              context: context,
              onTap: () {
                if (controller.name.value.isEmpty) {
                  Get.snackbar('Failed', 'Please Enter Name');
                } else if (controller.email.value.isEmpty) {
                  Get.snackbar('Failed', 'Please Enter Email');
                } else {
                  controller.saveDataToLocalStorage();
                  Get.snackbar('Success', 'Data saved successfully!');
                }
              },
              btnName: 'Save',
            ),
            SizedBox(
              height: 10,
            ),
            myButton(
              context: context,
              onTap: () {
               Get.to(()=> ApiDataScreen());
              },
              btnName: 'Api Data',
            ),
          ],
        ),
      ),
    );
  }
}
