import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registered Users')),
      body: FutureBuilder<List<Map<String, String>>>(
        future: loadDataFromLocalStorage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                child: ListTile(
                  title: Text(user['name']!),
                  subtitle: Text(user['email']!),
                  leading: Image.file(File(user['profilePicPath']!)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<List<Map<String, String>>> loadDataFromLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return [
      {
        'name': prefs.getString('name') ?? '',
        'email': prefs.getString('email') ?? '',
        'profilePicPath': prefs.getString('profilePicPath') ?? '',
      }
    ];
  }
}
