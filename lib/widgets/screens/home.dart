import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/constants/paths.dart';
import 'package:pet_id_checker/widgets/screens/scanner.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final LocalAuthentication _localAuth = LocalAuthentication();


  Future<void> _showInfoDialog(BuildContext context, String title, String message) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _onScannerOpened(BuildContext context, VoidCallback onSuccess, VoidCallback onAuthFail, VoidCallback onAuthDisabled) async {
    bool isAuthAvailable = await _localAuth.canCheckBiometrics;

    if (isAuthAvailable) {
      bool isAuthenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate using biometrics',
        options: const AuthenticationOptions(useErrorDialogs: true, stickyAuth: true, biometricOnly: true),
      );

      if (isAuthenticated) {
        onSuccess.call();
      } else {
        onAuthFail.call();
      }

      return;
    }

    onAuthDisabled.call();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        color: AppColors.primary,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  const SizedBox(height: 128.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Center(
                      child: Image(image: AssetImage(Paths.getImage('admin_card.png')))
                    ),
                  ),
                  const Center(
                    child: Text('PetID PreSell Checker', style: TextStyle(fontSize: 32, color: AppColors.textPrimary, fontWeight: FontWeight.w800))
                  ),
                  const SizedBox(height: 16.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child: Center(
                      child: Text(
                        'This application is created to check Tags before selling them. All Tag boxes must contain control QR codes that will show whether Tag is already in use or not.', 
                        style: TextStyle(
                          fontSize: 12, color: AppColors.textSecondary
                        )
                      )
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                children: [
                  FloatingActionButton(
                    onPressed: () async {
                      await _onScannerOpened(
                        context, 
                        () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const ScannerScreen()));
                        }, 
                        () async { 
                          await _showInfoDialog(context, "Authentication failed!", "Try again.");
                        }, 
                        () async { 
                          await _showInfoDialog(context, "Enable biometry authentication!", "For more secure application usage you must enable biometry usage for this app. Overwise you cannot using this application.");
                        }
                      );
                    },
                    tooltip: 'Scanner',
                    backgroundColor: Colors.white,
                    child: const Icon(Icons.qr_code_scanner_rounded, color: AppColors.primary, size: 32),
                  ),                  
                  const Center(
                    child: Text('Scan QR', style: TextStyle(fontSize: 12, color: AppColors.textSecondary))
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
