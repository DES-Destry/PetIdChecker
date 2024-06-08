import 'package:pet_id_checker/api/common/base_controller.dart';
import 'package:pet_id_checker/api/dto/login_admin_request.dto.dart';
import 'package:pet_id_checker/api/dto/login_admin_response.dto.dart';
import 'package:pet_id_checker/api/dto/void_response.dto.dart';

class AdminController extends BaseController {
  final String _basePath = 'admin';

  Future<LoginAdminResponseDto> loginAdmin(LoginAdminRequestDto request) async {
    final response = await post('$_basePath/login', request);
    return LoginAdminResponseDto.fromJson(response.data);
  }

  Future<VoidResponseDto> createReport(int tagId) async {
    final response = await post('$_basePath/tags/$tagId/reports');
    return VoidResponseDto.fromJson(response.data);
  }
}
