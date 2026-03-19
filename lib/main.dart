import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shader_study/full_size_effects/full_size_effects_screen.dart';
import 'package:shader_study/shader_mask/shader_mask_screen.dart';

import 'routes.dart';
import 'seascape/seascape_screen.dart';
import 'gradient_background/gradient_background_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: Routes.main,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: Routes.seascape,
      builder: (context, state) => const SeascapeScreen(),
    ),
    GoRoute(
      path: Routes.gradientBackground,
      builder: (context, state) => const GradientBackgroundScreen(),
    ),
    GoRoute(
      path: Routes.shaderMask,
      builder: (context, state) => const ShaderMaskScreen(),
    ),
    GoRoute(
      path: Routes.fullSizeEffects,
      builder: (context, state) => const FullSizeEffectsScreen(),
    ),
  ],
);

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Shader Study',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shader Study'),
      ),
      body: Center(
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push(Routes.seascape),
              child: const Text('Seascape'),
            ),
            ElevatedButton(
              onPressed: () => context.push(Routes.gradientBackground),
              child: const Text('Gradient Background'),
            ),
            ElevatedButton(
              onPressed: () => context.push(Routes.shaderMask),
              child: const Text('ShaderMask'),
            ),
            ElevatedButton(
              onPressed: () => context.push(Routes.fullSizeEffects),
              child: const Text('Full Size Effects'),
            ),
          ],
        ),
      ),
    );
  }
}
