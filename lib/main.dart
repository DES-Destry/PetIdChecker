import 'package:flutter/material.dart';
import 'package:pet_id_checker/widgets/screens/home.dart';

void main() {
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(100, 33, 29, 226)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
