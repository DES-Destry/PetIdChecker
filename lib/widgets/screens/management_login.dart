import 'package:flutter/material.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/constants/paths.dart';

class ManagementLoginScreen extends StatelessWidget {
  const ManagementLoginScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        child: Column(
          children: [
            Row(
              children: [
                Image(image: AssetImage(Paths.getImage('management_icon.png'))),
                const Text("PetID Management - Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold))
              ],
            ),
          ],
        ),
      ),
    );
  }
}