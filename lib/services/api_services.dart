import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../models/user.dart';

class DioClient {
  Dio init() {
    Dio _dio = Dio();
    _dio.options.connectTimeout = 15 * 1000;
    _dio.options.receiveTimeout = 15 * 1000;
    _dio.options.baseUrl = 'https://identitytoolkit.googleapis.com';
    return _dio;
  }
}

class ApiProvider {
  DioClient client = DioClient();

  Future<Response> getRequest(String endPoint, Map<String, dynamic>? headers,
      Map<String, String>? params) async {
    try {

      if (headers != null) {
        client.init().options.headers = headers;
      }

      final response = await client.init().get(endPoint, queryParameters: params);
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }

  Future<Response> postRequest(String endPoint, Map<String, dynamic>? headers,
      Map<String, dynamic>? params, Map<String, dynamic> data) async {
    try {
      if (headers != null) {
        client.init().options.headers = headers;
      }

      final response = await client.init().post(
            endPoint,
            data: json.encode(data),
            queryParameters: params,
          );
      return response;
    } on DioError catch (e) {
      throw Exception(e.message);
    }
  }
}

class ApiServices {
  ApiProvider apiProvider = ApiProvider();

  Future<User?> login(String email, String password) async {
    try {
      final data = {'email': email, 'password': password};
      var params = {'key': 'AIzaSyDfA6pjHTCRmB-mHQnqq1uEXvmKLu7jDVI'};
      var headers = {'Content-Type': 'application/json'};
      final response = await apiProvider.postRequest(
          '/v1/accounts:signInWithPassword', headers, params, data);

      if (response.statusCode == 200 && response.data != null) {
        final data = User(
          email: response.data['email'],
          localId: response.data['localId'],
          token: 'Bearer ${response.data['idToken']}',
        );
        return data;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
