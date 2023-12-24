import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseController {
  final Dio _dio = Dio();
  late String _baseUrl;
  String? _token;

  BaseController() {
    _baseUrl = dotenv.env['BACKEND_URL'] ?? '';
  }

  @protected
  Future<Response<T>?> get<T>(String path) async {
    try {
      final Response<T> response = await _dio.get('$_baseUrl/$path', options: Options(headers: {
        'Authorization': 'Bearer $_token',
        'ngrok-skip-browser-warning': true
      }));
      return response;
    }
    catch (e) {
      return null;
    }
  }

  @protected
  Future<Response<T>?> post<T>(String path, Object? body) async {
    try {
      final Response<T> response = await _dio.post('$_baseUrl/$path', data: body, options: Options(headers: {
        'Authorization': 'Bearer $_token',
        'ngrok-skip-browser-warning': true
      }));
      return response;
    }
    catch (e) {
      return null;
    }
  }

  @protected
  Future<Response<T>?> put<T>(String path, Object? body) async {
    try {
      final Response<T> response = await _dio.put('$_baseUrl/$path', data: body, options: Options(headers: {
        'Authorization': 'Bearer $_token',
        'ngrok-skip-browser-warning': true
      }));
      return response;
    }
    catch (e) {
      return null;
    }
  }

  @protected
  Future<Response<T>?> delete<T>(String path) async {
    try {
      final Response<T> response = await _dio.get('$_baseUrl/$path', options: Options(headers: {
        'Authorization': 'Bearer $_token',
        'ngrok-skip-browser-warning': true
      }));
      return response;
    }
    catch (e) {
      return null;
    }
  }

  setToken(String token) {
    _token = token;
  }
}