import 'dart:convert';
import 'package:apis_/data/app_exceptions.dart';
import 'package:apis_/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;


class NetworkApiServices implements BaseApiServices {
  @override
  Future<dynamic> getGetApiResponse(String url) async {
    dynamic responseJson;

    try {
      final response = await http.get(Uri.parse(url));

      responseJson = _handleResponse(response);
    } catch (e) {
      throw FetchDataException("Error while communicating with server: $e");
    }

    return responseJson;
  }

  @override
  Future<dynamic> getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      responseJson = _handleResponse(response);
    } catch (e) {
      throw FetchDataException("Error while communicating with server: $e");
    }

    return responseJson;
  }

  // Handle HTTP response status codes
  dynamic _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnAuthorizedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          "Error occurred while communicating with server: ${response.statusCode}",
        );
    }
  }
}
