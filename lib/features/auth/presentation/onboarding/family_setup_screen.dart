import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasktitans/core/theme/app_colors.dart';
import 'package:tasktitans/core/widgets/comic_button.dart';
import 'package:tasktitans/core/widgets/comic_header.dart';
import 'package:tasktitans/core/widgets/comic_text_field.dart';
import 'package:tasktitans/data/repositories/auth_repository.dart';
import 'package:tasktitans/features/auth/application/onboarding_state.dart';

class FamilySetupScreen extends ConsumerStatefulWidget {
  const FamilySetupScreen({super.key});

  @override
  ConsumerState<FamilySetupScreen> createState() => _FamilySetupScreenState();
}

class _FamilySetupScreenState extends ConsumerState<FamilySetupScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _familyNameController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _familyNameController.dispose();
    _inviteCodeController.dispose();
    super.dispose();
  }

  Future<void> _handleComplete() async {
    final onboardingState = ref.read(onboardingStateProvider);
    final user = ref.read(authRepositoryProvider).currentUser;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error: User not found')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_tabController.index == 0) {
        // CREATE FAMILY
        if (_familyNameController.text.isEmpty) {
          throw Exception('Please enter a family name');
        }
        await ref.read(authRepositoryProvider).createFamilyAndProfile(
              userId: user.id,
              familyName: _familyNameController.text.trim(),
              username: onboardingState.username,
              avatarId: onboardingState.avatarId,
              pinCode: onboardingState.pinCode,
            );
      } else {
        // JOIN FAMILY
        if (_inviteCodeController.text.isEmpty) {
          throw Exception('Please enter an invite code');
        }
        await ref.read(authRepositoryProvider).joinFamilyAndCreateProfile(
              userId: user.id,
              inviteCode: _inviteCodeController.text.trim(),
              username: onboardingState.username,
              avatarId: onboardingState.avatarId,
              pinCode: onboardingState.pinCode,
            );
      }

      if (mounted) {
        // Clear onboarding state
        ref.invalidate(onboardingStateProvider);
        // Navigate to Profile Selection
        context.go('/profile-selection');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.vigilanteRed),
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
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const ComicHeader(text: 'FAMILY SETUP', fontSize: 32),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 2),
                boxShadow: const [BoxShadow(color: Colors.black, offset: Offset(4, 4))],
              ),
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  color: AppColors.electricBlue,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2),
                ),
                indicatorPadding: const EdgeInsets.all(-2),
                labelStyle: const TextStyle(fontFamily: 'Bungee'),
                tabs: const [
                  Tab(text: 'CREATE NEW'),
                  Tab(text: 'JOIN EXISTING'),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCreateTab(),
                  _buildJoinTab(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: ComicButton(
                text: _isLoading ? 'SETTING UP...' : 'FINISH',
                color: AppColors.hulkGreen,
                onPressed: _isLoading ? null : _handleComplete,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.home_rounded, size: 80, color: AppColors.electricBlue),
          const SizedBox(height: 24),
          const Text(
            'Start a new Task Titans family squad.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ComicTextField(
            controller: _familyNameController,
            label: 'Family Name',
            hintText: 'The Incredible Family',
          ),
        ],
      ),
    );
  }

  Widget _buildJoinTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.qr_code_2, size: 80, color: AppColors.vigilanteRed),
          const SizedBox(height: 24),
          const Text(
            'Enter the invite code from another family admin.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          ComicTextField(
            controller: _inviteCodeController,
            label: 'Invite Code',
            hintText: 'e.g. A1B2C3',
          ),
        ],
      ),
    );
  }
}
