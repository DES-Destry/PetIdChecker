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
              color: AppColors.textPrimary, fontWeight: FontWeight.bold
          ),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0), 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child:
                      Image(image: AssetImage('lib/assets/admin_card.png')),
                  ),
                  Center(
                    child: Text(
                      'This application is created to check Tags before sell them. All Tag boxes must contain control QR codes that will show is Tag already on use or not.',
                      style: TextStyle(color: Colors.white)
                    ),
                  )
                ]
              ),
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
