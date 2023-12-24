import 'package:pet_id_checker/api/dto/error_response.dto.dart';

class ApiException implements Exception {
  final ErrorResponseDto errorResponse;

  ApiException({required this.errorResponse});
}