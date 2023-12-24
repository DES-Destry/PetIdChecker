import 'package:flutter/material.dart';
import 'package:pet_id_checker/api/dto/check_tag.dto.dart';
import 'package:pet_id_checker/shared/constants/app_colors.dart';
import 'package:pet_id_checker/shared/constants/paths.dart';

class TagScreen extends StatefulWidget {
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

  @override
  State<TagScreen> createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  Widget _reportButton() {
    return !widget.tag.isFree 
      ? ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(AppColors.primary), backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
          child: const Text("Report tag"),
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
            Row(children: [
              CloseButton(
                color: AppColors.textPrimary,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],),
            const SizedBox(height: 96.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Center(
                child: Image(image: AssetImage(widget.image))
              ),
            ),
            Center(
              child: Text('#${widget.tag.id}', style: const TextStyle(fontSize: 64, color: AppColors.textPrimary, fontWeight: FontWeight.bold))
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Is Free: ${widget.isFreeStatus}', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                  Text('Owner Email: ${widget.tag.pet?.ownerEmail ?? 'N/A'}', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                  Text('Pet Name: ${widget.tag.pet?.name ?? 'N/A'}', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
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