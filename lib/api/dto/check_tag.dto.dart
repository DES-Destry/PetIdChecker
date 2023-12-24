import 'package:json_annotation/json_annotation.dart';
import 'package:pet_id_checker/api/dto/check_pet.dto.dart';

part 'check_tag.dto.g.dart';

@JsonSerializable()
class CheckTagDto {
  final int id;
  final bool isFree;
  final CheckPetDto? pet;

  CheckTagDto({required this.id, required this.isFree, this.pet});

  factory CheckTagDto.fromJson(Map<String, dynamic> json) => _$CheckTagDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CheckTagDtoToJson(this);
}