import 'dart:convert';
import 'package:http/http.dart' as http;
import '../services/shared_pref/shared_pref.dart';
import 'loading_idicator_dialog.dart'; // Import shared preferences for token storage

class NetworkAPICall {
  String? token; // To store token for authenticated requests

  /// Constructor initializes the token from shared preferences
  NetworkAPICall() {
    token = SharedPref.sharedPreferences.getString("token");
  }

  /// Centralized timeout handler for all HTTP requests
  Future<http.Response> _handleTimeout(Future<http.Response> request) async {
    try {
      return await request.timeout(
        const Duration(seconds: 10), // Set the timeout duration globally
        onTimeout: () {
          // Handle request timeouts
          LoadingIndicatorDialog()
              .dismiss(); // Dismiss loader if timeout occurs
          return http.Response(
              'Error: Timeout occurred', 408); // 408 Request Timeout
        },
      );
    } catch (e) {
      // Handle unexpected exceptions during the request
      LoadingIndicatorDialog().dismiss();
      return http.Response('Error: $e', 500); // 500 Internal Server Error
    }
  }

  Map<String, String> _setHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      if (token != null) 'Authorization': token!,
    };
  }

  /// Helper to set headers for guest requests (e.g., without token)
  Map<String, String> _setGuestHeaders() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<http.Response> getData(String apiUrl) async {
    print("GET Request: $apiUrl");
    try {
      return await _handleTimeout(http.get(
        Uri.parse(apiUrl),
        headers: _setHeaders(),
      ));
    } catch (e) {
      print("GET Request Error: $e");
      return http.Response("Error: $e", 500); // Catch runtime exceptions
    }
  }

  /// **GET Request** for guest requests (no token)
  Future<http.Response> getDataAsGuest(String apiUrl,
      {Map<String, dynamic>? params}) async {
    print("GET Request (Guest): $apiUrl");
    try {
      var uri = Uri.parse(apiUrl);
      if (params != null) {
        uri = uri.replace(
            queryParameters: params); // Add query parameters for GET
      }
      return await _handleTimeout(http.get(
        uri,
        headers: _setGuestHeaders(),
      ));
    } catch (e) {
      print("GET Request (Guest) Error: $e");
      return http.Response("Error: $e", 500);
    }
  }

  /// **POST Request** for authenticated requests
  Future<http.Response> postData(
      String apiUrl, Map<String, dynamic> data) async {
    print("POST Request: $apiUrl, Data: ${jsonEncode(data)}");
    try {
      return await _handleTimeout(http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data), // Serialize the body as JSON
        headers: _setHeaders(), // Add headers (with Authorization)
      ));
    } catch (e) {
      print("POST Request Error: $e");
      return http.Response("Error: $e", 500);
    }
  }

  Future<http.Response> postDataAsGuest(data, String apiUrl) async {
    return await _handleTimeout(http.post(Uri.parse(apiUrl),
        body: jsonEncode(data), headers: _setGuestHeaders()));
  }

  /// **PUT Request** for updating data
  Future<http.Response> editData(
      String apiUrl, Map<String, dynamic> data) async {
    print("PUT Request: $apiUrl, Data: ${jsonEncode(data)}");
    try {
      return await _handleTimeout(http.put(
        Uri.parse(apiUrl),
        body: jsonEncode(data), // Serialize JSON body
        headers: _setHeaders(), // Add necessary headers
      ));
    } catch (e) {
      print("PUT Request Error: $e");
      return http.Response("Error: $e", 500);
    }
  }

  /// **DELETE Request**
  Future<http.Response> deleteData(String apiUrl) async {
    print("DELETE Request: $apiUrl");
    try {
      return await _handleTimeout(http.delete(
        Uri.parse(apiUrl),
        headers: _setHeaders(), // Authenticated request
      ));
    } catch (e) {
      print("DELETE Request Error: $e");
      return http.Response("Error: $e", 500);
    }
  }

  /// POST Data Without Timeout (if needed for specific APIs without timeouts)
  Future<http.Response> addDataWithoutTimeout(
      String apiUrl, Map<String, dynamic> data) async {
    print("POST Request Without Timeout: $apiUrl, Data: ${jsonEncode(data)}");
    try {
      return await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(data),
        headers: _setHeaders(),
      );
    } catch (e) {
      print("POST Without Timeout Error: $e");
      return http.Response("Error: $e", 500);
    }
  }
}
