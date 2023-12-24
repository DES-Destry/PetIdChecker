import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/widgets/screens/home.dart';

void main() async {
  await dotenv.load(fileName: '.env');

  runApp(const PetIdChecker());
}

class PetIdChecker extends StatelessWidget {
  const PetIdChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PetID PreSell Checker',
      theme: ThemeData(
        fontFamily: 'Nunito',
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
