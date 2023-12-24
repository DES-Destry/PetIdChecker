import 'package:flutter/material.dart';
import 'package:pet_id_checker/api/dto/check_tag_dto.dart';
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
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Row(),
            const SizedBox(height: 128.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Center(
                child: Image(image: AssetImage(widget.image))
              ),
            ),
            Center(
              child: Text('#${widget.tag.id}', style: const TextStyle(fontSize: 32, color: AppColors.textPrimary, fontWeight: FontWeight.w800))
            ),
            const SizedBox(height: 32.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Column(
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