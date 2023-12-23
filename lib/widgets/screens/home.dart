import 'package:flutter/material.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        color: AppColors.primary,
        child: const Column(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  SizedBox(height: 128.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child: Center(
                      child: Image(image: AssetImage('lib/assets/admin_card.png'))
                    ),
                  ),
                  Center(
                    child: Text('PetID PreSell Checker', style: TextStyle(fontSize: 28, color: AppColors.textPrimary, fontWeight: FontWeight.bold))
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
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
                  ElevatedButton(
                    onPressed: null,
                    child: Text('Test', style: TextStyle(color: AppColors.textPrimary)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
