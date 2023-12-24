import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pet_id_checker/api/dto/check_tag.dto.dart';
import 'package:pet_id_checker/api/tag_controller.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/exceptions/api.exception.dart';
import 'package:pet_id_checker/shared/exceptions/connection.exception.dart';
import 'package:pet_id_checker/shared/exceptions/error_like.dart';
import 'package:pet_id_checker/widgets/components/qr_scanner_overlay.dart';
import 'package:pet_id_checker/widgets/screens/tag.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final TagController _tagController = TagController();

  late int dialogsOpened = 0;

  bool isNumeric(String? s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  Future<void> _onScan(BuildContext context, BarcodeCapture result, VoidCallback onQrFormatError, Function(CheckTagDto?, ErrorLike?) onControlCheckResult) async {
    final String controlCode = result.raw[0]['rawValue'];

    if(!isNumeric(controlCode)) {
      onQrFormatError.call();
      return;
    }

    try {
      final CheckTagDto checkResult = await _tagController.tagPreSellCheck(controlCode);
      onControlCheckResult.call(checkResult, null);
    } on ApiException catch (e) {
      onControlCheckResult.call(null, ErrorLike.fromApiError(e));
    } on ConnectionException catch (e) {
      onControlCheckResult.call(null, ErrorLike.fromConnectionError(e));
    } catch (e) {
      onControlCheckResult.call(null, ErrorLike.fromApplicationError(e));
    }
  }

  Future<void> _showInfoDialog(BuildContext context, String title, String message) {
    dialogsOpened++;

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
                dialogsOpened--;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        foregroundColor: AppColors.textSecondary,
        backgroundColor: AppColors.primary,
        title: const Text('PreSell Checker Scanner', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: MobileScannerController(
                        detectionTimeoutMs: 1000,
                      ),
                      onDetect: (result) async {
                        if (dialogsOpened != 0) {
                          return;
                        }

                        await _onScan(context, result,
                          () { 
                            _showInfoDialog(context, 'Invalid QR code', 'This QR has an unknown format');
                          },
                          (CheckTagDto? tag, ErrorLike? err) {
                            if (err != null) {
                              print(err.message);
                              _showInfoDialog(context, 'Error', 'Caught error with code: ${err.code}');
                              return;
                            }

                            Navigator.push(context, MaterialPageRoute(builder: (context) => TagScreen(tag: tag!)));
                          }
                        );
                      },
                    ),
                    const QRScannerOverlay(overlayColour: AppColors.shadowPrimary)
                  ]
                )
              ),
            ],
          ),
      ),
    );
  }
}