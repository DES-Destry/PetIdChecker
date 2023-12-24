import 'package:json_annotation/json_annotation.dart';

part 'check_pet.dto.g.dart';

@JsonSerializable()
class CheckPetDto {
  final String ownerEmail;
  final String name;

  CheckPetDto({required this.ownerEmail, required this.name});

  factory CheckPetDto.fromJson(Map<String, dynamic> json) => _$CheckPetDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CheckPetDtoToJson(this);
}