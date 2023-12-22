import 'package:flutter/material.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: const Text(
          'PetID PreSell Checker',
          style: TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Center(
                          child:
                          Image(image: AssetImage('src/assets/admin-card.png')),
                      )
                  ),
                  Text(
                      'This application is created to check Tags before sell them. All Tag boxes must contain control QR codes that will show is Tag already on use or not.',
                      style: TextStyle(color: AppColors.textSecondary)
                  )
                ]
            ),

            Column(
              children: [
                ElevatedButton(
                  onPressed: null,
                    child: Text('Test',
                        style: TextStyle(color: AppColors.textPrimary)
                    ),
                )
              ],
            )
          ]
      ),
    );
  }
}
