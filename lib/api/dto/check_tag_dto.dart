import 'package:pet_id_checker/api/dto/check_pet_dto.dart';

class CheckTagDto {
  final int id;
  final bool isFree;
  final CheckPetDto? pet;

  CheckTagDto({required this.id, required this.isFree, this.pet});
}