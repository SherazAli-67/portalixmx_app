import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../res/api_constants.dart';

class ApiService {

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor
  factory ApiService() {
    return _instance;
  }

  // Private constructor
  ApiService._internal();
  final String _baseUrl = ApiConstants.baseUrl;

  Future<http.Response> postRequest({required String endpoint, required Map<String, dynamic> data, }) async {
    var url = Uri.parse(_baseUrl + endpoint);
    Map<String, String> headers =  await _getApiHeader();
    debugPrint("Post request url: $url\nData: $data\nHeaders: $headers");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    debugPrint("Post request response: ${response.body}");
    return response;
  }

  Future<http.Response> postRequestWithToken({required String endpoint, required Map<String, dynamic> data, required String token}) async {
    var url = Uri.parse(_baseUrl + endpoint);
    Map<String, String> headers =  await _getApiHeaderWithBearerToken(token);
    debugPrint("Post request with token url: $url\nData: $data\nHeaders: $headers");

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );

    debugPrint("Post request with token response: ${response.body}");
    return response;
  }


  Future<bool> postComplaintWithImages({
    required String endpoint,
    required String token,
    required String complaintText,
    required List<File> images,
  }) async {
    var url = Uri.parse(_baseUrl + endpoint);
    var request = http.MultipartRequest('POST', url);

    // Add authorization headers
    request.headers.addAll(await _getApiHeaderWithBearerToken(token));

    // Add the text field
    request.fields['complainttext'] = complaintText;

    // Add image files to 'img[]'
    for (int i = 0; i < images.length; i++) {
      File image = images[i];
      request.files.add(
        await http.MultipartFile.fromPath(
          'Img', // Assuming your backend expects multiple files under same key: 'img'
          image.path,
        ),
      );
    }

    // Send the request
    final streamedResponse = await request.send();


    // Handle response
    final responseBody = await streamedResponse.stream.bytesToString();
    // print("Response Code: ${streamedResponse.statusCode}");
    print("Response Body: $responseBody");

    if(streamedResponse.statusCode == 200){
      return true;
    }
    return false;

  }

  Future<http.Response> getRequest({required String endpoint, required String token}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Get URL: $url");

    final headers = await _getApiHeaderWithBearerToken(token);
    final response = await http.get(
      url,
      headers: headers,
    );
    // debugPrint("GET Api $endpoint response: ${response.body}");
    return response;
  }

  Future<http.Response> getRequestWithQueryParams({required String endpoint,}) async {
    final Map<String, String> queryParams = {'isRedirect': "false",};
    String url = '${ApiConstants.baseUrl}$endpoint';
    final Uri uri = Uri.parse(url).replace(queryParameters: queryParams);

    Map<String, String> headers = await _getApiHeader();
    final http.Response response = await http.get(uri, headers: headers);

    return response;
  }

  Future<http.Response> postRequestChangeEmail({required String endpoint, required Map<String, dynamic> data}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Post url: $url");
    final headers = await _getApiHeader();
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );


    debugPrint("$endpoint Api response: ${response.statusCode}");
    return response;
  }


  Future<http.Response> deleteRequest({required String endpoint,}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Delete Url: $url");

    final headers = await _getApiHeader();
    final response = await http.delete(url, headers: headers);

    debugPrint("$endpoint Api response: ${response.statusCode}");
    return response;
  }

  Future<http.Response> postRequestWithCookies({required String endpoint, required Map<String, dynamic> data}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Post with cookies Url: $url");
    final headers = await _getApiHeader();
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(data),
    );
    debugPrint("$endpoint Api response: ${response.statusCode}");
    return response;
  }






/*
  Future<http.Response> getRequestWithToken({required String endpoint,}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Get Url: $url");
    // String cookieHeader = '\$_ga=GA1.1.2128101670.1715344907; _clck=u620ls%7C2%7Cfmd%7C0%7C1597; access_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTEsImFjY2Vzc1Rva2VuSWQiOiI2OTgyZTdhZS1iMjRhLTRmYTctOGVhNC1jYWYxNzIyOTY2M2IiLCJpYXQiOjE3MTgyOTM3NzYsImV4cCI6MjMyMzA5Mzc3Nn0.aKIGLMxr5qJ3QouDgmTstrNbJ1XWQS-LFHi1lpg3vZM; _ga_VBJFPH8935=GS1.1.1718702542.39.1.1718702544.0.0.0';
    // String cookies = (await Utils.getFromCache(key: cookiesKey))!;
    // cookies = '$cookieHeader$cookies';

    final headers = await _getApiHeaderWithCookies();
    final response = await http.get(url, headers: headers,);
    debugPrint("$endpoint Api response: ${response.statusCode}");
    return response;
  }
*/


  Future<Map<String, String>> _getApiHeader() async {
    return {'Content-Type': 'application/json',};
  }

  Future<Map<String, String>> _getApiHeaderWithBearerToken(String token) async {
    return { 'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',};
  }
}