import 'package:json_annotation/json_annotation.dart';

part 'login_admin_request.dto.g.dart';

@JsonSerializable()
class LoginAdminRequestDto {
  final String username;
  final String password;

  LoginAdminRequestDto({required this.username, required this.password});

  factory LoginAdminRequestDto.fromJson(Map<String, dynamic> json) =>
      _$LoginAdminRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LoginAdminRequestDtoToJson(this);
}
