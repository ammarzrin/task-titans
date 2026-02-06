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
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid credentials!'),
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Column(
          children: [
            ComicHeader(text: 'TASK TITANS', fontSize: 32, color: Colors.white),
            Text(
              'FAMILY LOGIN',
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
                  // Add padding equal to keyboard height
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ComicButton(
                      text: _isLoading ? 'LOADING...' : 'ENTER HQ',
                      onPressed: _isLoading ? null : _handleLogin,
                      color: AppColors.lightningYellow,
                      textColor: AppColors.comicBlack,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      context.push('/signup');
                    },
                    child: const Text(
                      'NO ACCOUNT? CREATE HERE',
                      style: TextStyle(
                        fontFamily: 'Bungee',
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
