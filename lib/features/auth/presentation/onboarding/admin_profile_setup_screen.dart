import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/core/widgets/comic_text_field.dart';
import 'package:tasktitans/features/auth/application/onboarding_state.dart';

class AdminProfileSetupScreen extends ConsumerStatefulWidget {
  const AdminProfileSetupScreen({super.key});

  @override
  ConsumerState<AdminProfileSetupScreen> createState() => _AdminProfileSetupScreenState();
}

class _AdminProfileSetupScreenState extends ConsumerState<AdminProfileSetupScreen> {
  final _usernameController = TextEditingController();
  final _pinController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _handleNext() {
    final username = _usernameController.text.trim();
    final pin = _pinController.text.trim();

    if (username.isEmpty || pin.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a username and a 4-digit PIN.')),
      );
      return;
    }

    // Save state
    ref.read(onboardingStateProvider.notifier).update((state) => state.copyWith(
          username: username,
          pinCode: pin,
          // TODO: Add avatar selection later
        ));

    // Move to next step
    context.push('/onboarding/family');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const ComicHeader(text: 'SETUP PROFILE', fontSize: 32),
              const SizedBox(height: 10),
              const Text(
                'Create your Admin Identity',
                style: TextStyle(fontFamily: 'Nunito', fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              // Placeholder Avatar Picker
              const CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.electricBlue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              const SizedBox(height: 8),
              TextButton(onPressed: () {}, child: const Text('Change Avatar')),
              const SizedBox(height: 32),
              ComicTextField(
                controller: _usernameController,
                label: 'YOUR NAME',
                hintText: 'Super Dad',
              ),
              const SizedBox(height: 24),
              ComicTextField(
                controller: _pinController,
                label: 'SECRET PIN (4 Digits)',
                hintText: '1234',
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ComicButton(
                  text: 'NEXT STEP',
                  onPressed: _handleNext,
                  color: AppColors.electricBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
