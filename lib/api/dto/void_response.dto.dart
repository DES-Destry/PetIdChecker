import 'package:json_annotation/json_annotation.dart';

part 'void_response.dto.g.dart';

@JsonSerializable()
class VoidResponseDto {
  final bool isExecuted;

  VoidResponseDto({required this.isExecuted});

  factory VoidResponseDto.fromJson(Map<String, dynamic> json) =>
      _$VoidResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$VoidResponseDtoToJson(this);
}
