import 'package:pet_id_checker/api/common/base_controller.dart';
import 'package:pet_id_checker/api/dto/check_tag.dto.dart';

class TagController extends BaseController {
  final String _basePath = 'tag';

  Future<CheckTagDto> tagPreSellCheck(String controlCode) async {
    final response = await get('$_basePath/pre-sell/$controlCode');
    return CheckTagDto.fromJson(response.data);
  }
}