import 'package:dio/dio.dart';
import 'package:pet_id_checker/api/common/base_controller.dart';
import 'package:pet_id_checker/api/dto/check_tag_dto.dart';

class TagController extends BaseController {
  final String _basePath = 'tag';

  Future<Response<CheckTagDto>?> tagPreSellCheck(String controlCode) async {
    return await get<CheckTagDto>('$_basePath/pre-sell/$controlCode');
  }
}