import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import '../models/register_model.dart';
import '../constants/api_routes.dart';

class RegisterApi {
  Future<RegisterResponseModel> register(
      RegisterRequestModel requestModel) async {
    final response = await http.post(Uri.parse(registerurl),
        body: json.encode(requestModel.toJson()),
        headers: {"Content-type": "application/json"});
    log(response.body);
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      return RegisterResponseModel.fromJson(json.decode(response.body));
    } else {
      return RegisterResponseModel.fromJson({});
    }
  }
}
