import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/widgets/components/qr_scanner_overlay.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  void _onScan(BarcodeCapture result) {
    print(result.raw[0]['rawValue']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        foregroundColor: AppColors.textSecondary,
        backgroundColor: AppColors.primary,
        title: const Text('PreSell Checker Scanner', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
        // actions: [], - add close scanner
      ),
      body: Container(
        width: double.infinity,
        child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    MobileScanner(
                      onDetect: _onScan,
                      overlay: const Column(
                        children: [
                          // SizedBox(height: 64.0),
                          // Text('Place the QR code of the box in the area', style: TextStyle(fontSize: 16, color: AppColors.textPrimary, fontWeight: FontWeight.bold)),
                        ],
                      ),
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