import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:smart_shala/constants/api_routes.dart';
import '../models/testdetailsmodel.dart';

class TestDetailsApi {
  Future<TestDetailsResponseModel> create(
      TestDetailsRequestModel requestModel, String accessToken) async {
    final response = await http.post(Uri.parse(testurl),
        body: json.encode(requestModel.toJson()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $accessToken',
        });
    log("Response -> ${response.body.toString()}");
    log("Response code -> ${response.statusCode.toString()}");
    if (response.statusCode == 201) {
      return TestDetailsResponseModel.fromJson(json.decode(response.body));
    } else {
      return TestDetailsResponseModel.fromJson({});
    }
  }
}
