import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/core/widgets/comic_text_field.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    setState(() => _isLoading = true);
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );
      // Navigation will be handled by the router's auth listener
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
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ComicHeader(text: 'TASK TITANS', fontSize: 40),
              const SizedBox(height: 8),
              Text(
                'FAMILY LOGIN',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontFamily: 'Bungee',
                  color: AppColors.midnightGrey,
                ),
              ),
              const SizedBox(height: 48),
              ComicTextField(
                controller: _emailController,
                label: 'Email Address',
                hintText: 'parent@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              ComicTextField(
                controller: _passwordController,
                label: 'Password',
                hintText: '••••••••',
                obscureText: true,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ComicButton(
                  text: _isLoading ? 'LOADING...' : 'ENTER HQ',
                  onPressed: _isLoading ? null : _handleLogin,
                  color: AppColors.electricBlue,
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  context.push('/signup');
                },
                child: Text(
                  'Create New Family Account',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.electricBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
