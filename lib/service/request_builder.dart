import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sample/constants/constants.dart';

class JsonResponse {
  final bool success;
  final dynamic response;

  JsonResponse({
    required this.success,
    this.response
  });
}

enum RequestType { get, post }

abstract class ReguestBuilder extends GetxService {
  var token = "";

  Future<JsonResponse> preformRequest({required RequestType type, required String url}) async {
    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      };

      final response = type == RequestType.get ? await http.get(Uri.parse(url), headers: headers)
          : await http.post(Uri.parse(url),headers: headers);

      switch (response.statusCode) {
        case 200:
        case 201:
          final result = jsonDecode(response.body);
          final jsonResponse = JsonResponse(success: true, response: result);
          return jsonResponse;
        case 400:
          final result = jsonDecode(response.body);
          final jsonResponse = JsonResponse(success: false, response: result);
          return jsonResponse;
        case 401:
          final jsonResponse = JsonResponse(success: false, response: AppResponseStrings.UNAUTHORIZED);
          return jsonResponse;
        case 500:
        case 501:
        case 502:
          final jsonResponse = JsonResponse(success: false, response: AppResponseStrings.SOMETHING_WRONG);
          return jsonResponse;
        default:
          final jsonResponse = JsonResponse(success: false, response: AppResponseStrings.SOMETHING_WRONG);
          return jsonResponse;
      }
    } on SocketException {
      final jsonResponse = JsonResponse(success: false, response: AppResponseStrings.NO_INTERNET);
      return jsonResponse;
    } on FormatException {
      final jsonResponse = JsonResponse(success: false, response: AppResponseStrings.BAD_RESPONSE);
      return jsonResponse;
    } on HttpException {
      final jsonResponse = JsonResponse(success: false, response: AppResponseStrings.SOMETHING_WRONG);
      return jsonResponse;
    }
  }
}
