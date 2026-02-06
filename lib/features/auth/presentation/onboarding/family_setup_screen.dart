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

class _FamilySetupScreenState extends ConsumerState<FamilySetupScreen>
    with SingleTickerProviderStateMixin {
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error: User not found')));
      return;
    }

    setState(() => _isLoading = true);
    try {
      if (_tabController.index == 0) {
        // CREATE FAMILY
        if (_familyNameController.text.isEmpty) {
          throw Exception('Please enter a family name');
        }
        await ref
            .read(authRepositoryProvider)
            .createFamilyAndProfile(
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
        await ref
            .read(authRepositoryProvider)
            .joinFamilyAndCreateProfile(
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
              text: 'FAMILY SETUP',
              fontSize: 32,
              color: Colors.white,
            ),
            Text(
              'Build your Titans HQ!',
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 16,
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
      body: Column(
        children: [
          const SizedBox(height: 24),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 24),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 2),
              boxShadow: const [
                BoxShadow(color: Colors.black, offset: Offset(4, 4)),
              ],
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
              labelStyle: const TextStyle(fontFamily: 'Bungee', fontSize: 13),
              tabs: const [
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('CREATE NEW'),
                  ),
                ),
                Tab(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Text('JOIN EXISTING'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildCreateTab(), _buildJoinTab()],
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
                  text: _isLoading ? 'SETTING UP...' : 'FINISH',
                  color: AppColors.lightningYellow,
                  textColor: AppColors.comicBlack,
                  onPressed: _isLoading ? null : _handleComplete,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(
            Icons.home_rounded,
            size: 80,
            color: AppColors.electricBlue,
          ),
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
          // Keyboard padding
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
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
          // Keyboard padding
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}