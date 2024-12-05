import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Network/ApiService/apiService.dart';
import '../Resources/myColors.dart';
import '../controllers/RegistrationController.dart';
import '../models/getDummyAPiModel.dart';


class ApiDataScreen extends StatefulWidget {
  @override
  _ApiDataScreenState createState() => _ApiDataScreenState();
}

class _ApiDataScreenState extends State<ApiDataScreen> {
  final RegistrationController controller = Get.find<RegistrationController>();
  late Future<List<GetApiDataModal>> futurePosts;
  @override
  void initState() {
    super.initState();
    futurePosts = ApiService().fetchPosts();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: MyColor.white),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: MyColor.primaryColor,
        title: Text(
          'Api Dummy Data',
          style: TextStyle(color: MyColor.white),
        ),
      ),
      body: FutureBuilder<List<GetApiDataModal>>(
        future: futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No posts available.'));
          } else {
            final posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index].title ?? 'No Title'),
                  subtitle: Text(posts[index].body ?? 'No Body'),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
