import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tasktitans/core/router/router.dart';
import 'package:tasktitans/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Ideally, use --dart-define or flutter_dotenv
  await Supabase.initialize(
    url: 'https://uhezmezrxhzogqkcqbax.supabase.co',
    anonKey: 'sb_publishable_QeG65U9cZyFCAP1fmjUcrA_ZW4oc8cm',
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Task Titans',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
