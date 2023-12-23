import 'package:flutter/material.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/constants/paths.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openScanner() {
    print("Scanner opened");
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
                    onPressed: _openScanner,
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
