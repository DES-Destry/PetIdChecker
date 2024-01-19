import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_id_checker/api/admin_controller.dart';
import 'package:pet_id_checker/api/dto/login_admin_request.dto.dart';
import 'package:pet_id_checker/api/dto/void_response.dto.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/constants/paths.dart';
import 'package:pet_id_checker/shared/exceptions/api.exception.dart';
import 'package:pet_id_checker/shared/exceptions/connection.exception.dart';
import 'package:pet_id_checker/shared/exceptions/error_like.dart';

class ManagementLoginScreen extends StatefulWidget {
  final int tagId;
  const ManagementLoginScreen({super.key, required this.tagId});

  @override
  State<ManagementLoginScreen> createState() => _ManagementLoginScreenState();
}

class _ManagementLoginScreenState extends State<ManagementLoginScreen> {
  final AdminController _adminController = AdminController();

  late String username = '';
  late String password = '';

  late bool isLoading = false;

  Future<void> _sendReport(BuildContext context,
      Function(VoidResponseDto? response, ErrorLike? error) callback) async {
    try {
      setState(() {
        isLoading = true;
      });
      var loginResult = await _adminController.loginAdmin(
          LoginAdminRequestDto(username: username, password: password));

      _adminController.setToken(loginResult.accessToken);

      var response = await _adminController.createReport(widget.tagId);
      callback(response, null);
      setState(() {
        isLoading = false;
      });
    } on ApiException catch (e) {
      callback(null, ErrorLike.fromApiError(e));
    } on ConnectionException catch (e) {
      callback(null, ErrorLike.fromConnectionError(e));
    } catch (e) {
      callback(null, ErrorLike.fromApplicationError(e));
    }
  }

  Future<void> _showInfoDialog(
      BuildContext context, String title, String message,
      [String? details]) {
    List<Widget> buttons = [];

    if (details != null) {
      buttons.add(CupertinoDialogAction(
          child: const Text("Details"),
          onPressed: () => {_showInfoDialog(context, "Details", details)}));
    }

    buttons.add(CupertinoDialogAction(
        child: const Text("Ok"), onPressed: () => {Navigator.pop(context)}));

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: buttons,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 64.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CloseButton(
                  color: AppColors.textPrimary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            const SizedBox(height: 64.0),
            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Image(
                        image:
                            AssetImage(Paths.getImage('management_icon.png'))),
                  ),
                  const Text(
                    "PetID Management",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

            // Inputs
            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.8)),
                          hintText: 'Admin Username',
                        ),
                        autocorrect: true,
                        keyboardType: TextInputType.text,
                        onChanged: (usernameText) => {username = usernameText},
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(.8)),
                          hintText: 'Password',
                        ),
                        autocorrect: true,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        onChanged: (passwordText) => {password = passwordText},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: isLoading
                  ? const CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : ElevatedButton(
                      onPressed: () async {
                        await _sendReport(context, (response, err) {
                          if (err != null) {
                            _showInfoDialog(
                                context,
                                'Error',
                                'Caught error with code: ${err.code}',
                                err.message);
                            return;
                          }

                          _showInfoDialog(context, 'Success',
                              'Tag #${widget.tagId} was reported! Thank you.');
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryBright,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Send report",
                          style: TextStyle(fontSize: 22)),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
