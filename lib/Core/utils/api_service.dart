import 'package:dio/dio.dart';
import 'package:pharmacy/Core/utils/shared_preferences.dart';

class ApiService {
  final Dio _dio;
  final String _baseUrl = 'http://192.168.78.225:8000/api/';
  // String mytoken =
  //   'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMTkyLjE2OC40My4xODM6ODAwMC9hcGkvbG9naW4iLCJpYXQiOjE3MDQyMzczOTUsImV4cCI6MTcwNDI0MDk5NSwibmJmIjoxNzA0MjM3Mzk1LCJqdGkiOiIwVXc0SVN3ejRnU20yeVJqIiwic3ViIjoiMTEiLCJwcnYiOiI5ZTIwYWJmNTBhMTVkZGJiOWNlYjJlYjQ4MDc1MmZiYjc5NmIzYjRlIn0.BCjjyCAmlbGeu3E8M7rjOsTFpf9G0QHk_w7byIGDLjQ';
  ApiService(this._dio);
  Future<Map<String, dynamic>> get(
      {required String endpoint,
      required String bearerToken,
      Map<String, dynamic>? queryParameters}) async {
    String? myToken = SharedPref.getData(key: 'token');
    _dio.options.headers['Authorization'] = 'Bearer $myToken';
    var response = await _dio.get(
      '$_baseUrl$endpoint',
      queryParameters: queryParameters,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post(
      {required String endpoint, required Map<String, dynamic> data}) async {
    var response = await _dio.post('$_baseUrl$endpoint', data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> postWithToken(
      {required String endpoint,
      required Map<String, dynamic> data,
      required String bearerToken}) async {
    String? myToken = SharedPref.getData(key: 'token');
    _dio.options.headers['Authorization'] = 'Bearer $myToken';
    var response = await _dio.post('$_baseUrl$endpoint', data: data);
    return response.data;
  }
}
