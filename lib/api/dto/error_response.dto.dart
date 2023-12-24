import 'package:json_annotation/json_annotation.dart';

part 'error_response.dto.g.dart';

@JsonSerializable()
class ErrorResponseDto {
  final String type;
  final String title;
  final int status;
  final String detail;
  final String instance;
  final String code;
  final String stackTrace;
  final Map<String, dynamic> metadata;
  final String traceId;

  ErrorResponseDto({
    required this.type,
    required this.title,
    required this.status,
    required this.detail,
    required this.instance,
    required this.code,
    required this.stackTrace,
    required this.metadata,
    required this.traceId
  });

  factory ErrorResponseDto.fromJson(Map<String, dynamic> json) => _$ErrorResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$ErrorResponseDtoToJson(this);
}