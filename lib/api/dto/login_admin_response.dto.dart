import 'package:json_annotation/json_annotation.dart';

part 'login_admin_response.dto.g.dart';

@JsonSerializable()
class LoginAdminResponseDto {
  final String adminId;
  final String accessToken;

  LoginAdminResponseDto({required this.adminId, required this.accessToken});

  factory LoginAdminResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginAdminResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginAdminResponseDtoToJson(this);
}
