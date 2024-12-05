import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/getDummyAPiModel.dart';
import '../ApiConstant/apiConstant.dart';

class ApiService {
  Future<List<GetApiDataModal>> fetchPosts() async {
    final response = await http.get(Uri.parse(ApiConstant.getApiData));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((item) => GetApiDataModal.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
