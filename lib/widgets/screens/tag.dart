import 'package:flutter/material.dart';
import 'package:pet_id_checker/api/dto/check_tag.dto.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/constants/paths.dart';

class TagScreen extends StatelessWidget {
  final CheckTagDto tag;
  late String image;
  late String isFreeStatus;

  TagScreen({super.key, required this.tag}) {
    if (tag.isFree) {
      image = Paths.getImage('qr.png');
      isFreeStatus = '✅';
    } else {
      image = Paths.getImage('main_card.png');
      isFreeStatus = '❌';
    }
  }

  Widget _reportButton() {
    return !tag.isFree 
      ? ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.red,
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text("Report tag", style: TextStyle(
            fontSize: 22
          )),
      ) 
      : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            const SizedBox(height: 64.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CloseButton(
                  color: AppColors.textPrimary,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
            ],),
            const SizedBox(height: 64.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Center(
                child: Image(image: AssetImage(image))
              ),
            ),
            Center(
              child: Text('#${tag.id}', style: const TextStyle(fontSize: 64, color: AppColors.textPrimary, fontWeight: FontWeight.bold))
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Is Free: $isFreeStatus', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                  Text('Owner Email: ${tag.pet?.ownerEmail ?? 'N/A'}', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                  Text('Pet Name: ${tag.pet?.name ?? 'N/A'}', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                ],
              )
            ),
            const SizedBox(height: 128.0),
            _reportButton(),
          ],
        ),
      ),
    );
  }
}