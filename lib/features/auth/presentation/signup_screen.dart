import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/core/widgets/comic_text_field.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields!'),
          backgroundColor: AppColors.vigilanteRed,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authRepositoryProvider).signUp(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      // Success! Router will redirect to onboarding because no profile exists.
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppColors.vigilanteRed,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.halftoneGrey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: AppColors.electricBlue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        title: const Column(
          children: [
            ComicHeader(
              text: 'JOIN THE SQUAD',
              fontSize: 32,
              color: Colors.white,
            ),
            Text(
              'CREATE ACCOUNT',
              style: TextStyle(
                fontFamily: 'Bungee',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
        shape: const Border(
          bottom: BorderSide(color: AppColors.comicBlack, width: 2),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  ComicTextField(
                    controller: _emailController,
                    label: 'Parent Email',
                    hintText: 'hero@example.com',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  ComicTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hintText: '••••••••',
                    obscureText: true,
                  ),
                  // Keyboard padding
                  SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: const BoxDecoration(
              color: AppColors.electricBlue,
              border: Border(
                top: BorderSide(color: AppColors.comicBlack, width: 2),
              ),
            ),
            child: SafeArea(
              top: false,
              child: SizedBox(
                width: double.infinity,
                child: ComicButton(
                  text: _isLoading ? 'CREATING...' : 'ASSEMBLE!',
                  onPressed: _isLoading ? null : _handleSignup,
                  color: AppColors.lightningYellow,
                  textColor: AppColors.comicBlack,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}