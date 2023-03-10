import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';
import '../constants/api_routes.dart';

class GetUserApi {
  Future<UserModel> getUser(String accessToken) async {
    final response = await http.get(Uri.parse(userurl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      return UserModel.fromJson({});
    }
  }
}
