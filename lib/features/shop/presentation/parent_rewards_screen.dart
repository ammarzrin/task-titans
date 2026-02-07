import 'package:flutter/material.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';

class ParentRewardsScreen extends StatelessWidget {
  const ParentRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.electricBlue,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Column(
          children: [
            ComicHeader(
              text: 'REWARD SHOP',
              fontSize: 24,
              color: Colors.white,
            ),
            Text(
              'Customize Titan loot',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: const Border(
          bottom: BorderSide(color: AppColors.comicBlack, width: 2),
        ),
      ),
      body: const Center(
        child: Text(
          'SHOP COMING SOON!',
          style: TextStyle(fontFamily: 'Bungee', fontSize: 18),
        ),
      ),
    );
  }
}