import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_shala/models/login_model.dart';
import 'package:smart_shala/constants/api_routes.dart';

class LoginApi {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final response = await http.post(Uri.parse(loginurl),
        body: json.encode(requestModel.toJson()),
        headers: {"Content-type": "application/json"});
    // User is registered and tokens received
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(json.decode(response.body));
      // Username or password is invalid
    } else if (response.statusCode == 401) {
      return LoginResponseModel(access: "", refresh: "");
    } else {
      throw Exception(
          'Failed to load json data: Response Code -> ${response.statusCode}');
    }
  }
}
