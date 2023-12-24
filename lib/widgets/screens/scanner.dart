import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pet_id_checker/api/dto/check_tag_dto.dart';
import 'package:pet_id_checker/api/tag_controller.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
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

  Future<void> _onScan(BuildContext context, BarcodeCapture result, VoidCallback onQrFormatError, VoidCallback onCriticalRequestError, Function(CheckTagDto?) readyToOpenTag) async {
    final String controlCode = result.raw[0]['rawValue'];

    if(!isNumeric(controlCode)) {
      onQrFormatError.call();
      return;
    }

    final Response<CheckTagDto>? checkResponse = await _tagController.tagPreSellCheck(controlCode);

    if (checkResponse == null || checkResponse.data == null) {
      onCriticalRequestError.call();
      return;
    }

    readyToOpenTag.call(checkResponse.data);
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
                          () { 
                            _showInfoDialog(context, 'Server error', 'Cannot perform request to server');
                          },
                          (CheckTagDto? tag) {
                            if (tag == null) {
                              _showInfoDialog(context, 'Server error', 'Undefined tag was got from the server');
                              return;
                            }

                            Navigator.push(context, MaterialPageRoute(builder: (context) => TagScreen(tag: tag)));
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