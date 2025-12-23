import 'package:flutter/material.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';

class ParentRewardsScreen extends StatelessWidget {
  const ParentRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: ComicHeader(text: 'REWARD SHOP', fontSize: 24),
        ),
      ),
    );
  }
}
