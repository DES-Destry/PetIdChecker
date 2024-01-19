import 'package:pet_id_checker/shared/exceptions/api.exception.dart';
import 'package:pet_id_checker/shared/exceptions/connection.exception.dart';

class ErrorLike {
  final String code;
  String? message;

  ErrorLike({required this.code, this.message});

  static ErrorLike fromApiError(ApiException e) =>
      ErrorLike(code: e.errorResponse.code, message: e.errorResponse.detail);
  static ErrorLike fromConnectionError(ConnectionException e) =>
      ErrorLike(code: 'NET.CONN_ERROR', message: e.toString());
  static ErrorLike fromApplicationError(Object e) =>
      ErrorLike(code: 'INTERNAL.DART_EXCEPTION', message: e.toString());
}
