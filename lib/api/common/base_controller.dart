import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_id_checker/api/dto/error_response.dto.dart';
import 'package:pet_id_checker/shared/exceptions/api.exception.dart';
import 'package:pet_id_checker/shared/exceptions/connection.exception.dart';

abstract class BaseController {
  final Dio _dio = Dio();
  late String _baseUrl;
  String? _token;

  bool _isSuccessfulStatus(int status) => status >= 200 && status < 300;

  BaseController() {
    _baseUrl = dotenv.env['BACKEND_URL'] ?? '';
  }

  @protected
  Future<Response> get(String path) async {
    try {
      final Response response = await _dio.get('$_baseUrl/$path',
          options: Options(validateStatus: (_) => true, headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': true
          }));

      if (response.statusCode == null || response.data == null) {
        throw ConnectionException();
      }

      if (_isSuccessfulStatus(response.statusCode!)) {
        return response;
      }

      final errorResponse = ErrorResponseDto.fromJson(response.data);
      throw ApiException(errorResponse: errorResponse);
    } catch (err) {
      throw ConnectionException();
    }
  }

  @protected
  Future<Response> post(String path, [Object? body]) async {
    try {
      final Response response = await _dio.post('$_baseUrl/$path',
          data: body,
          options: Options(validateStatus: (_) => true, headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': true
          }));

      if (response.statusCode == null || response.data == null) {
        throw ConnectionException();
      }

      if (_isSuccessfulStatus(response.statusCode!)) {
        return response;
      }

      var errorResponse = ErrorResponseDto.fromJson(response.data);
      throw ApiException(errorResponse: errorResponse);
    } catch (err) {
      throw ConnectionException();
    }
  }

  @protected
  Future<Response> put(String path, [Object? body]) async {
    try {
      final Response response = await _dio.put('$_baseUrl/$path',
          data: body,
          options: Options(validateStatus: (_) => true, headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': true
          }));

      if (response.statusCode == null || response.data == null) {
        throw ConnectionException();
      }

      if (_isSuccessfulStatus(response.statusCode!)) {
        return response;
      }

      var errorResponse = ErrorResponseDto.fromJson(response.data);
      throw ApiException(errorResponse: errorResponse);
    } catch (err) {
      throw ConnectionException();
    }
  }

  @protected
  Future<Response> delete(String path) async {
    try {
      final Response response = await _dio.get('$_baseUrl/$path',
          options: Options(validateStatus: (_) => true, headers: {
            'Authorization': 'Bearer $_token',
            'Content-Type': 'application/json',
            'ngrok-skip-browser-warning': true
          }));

      if (response.statusCode == null || response.data == null) {
        throw ConnectionException();
      }

      if (_isSuccessfulStatus(response.statusCode!)) {
        return response;
      }

      var errorResponse = ErrorResponseDto.fromJson(response.data);
      throw ApiException(errorResponse: errorResponse);
    } catch (err) {
      throw ConnectionException();
    }
  }

  setToken(String token) {
    _token = token;
  }
}
