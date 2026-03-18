import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shader_study/shader_mask/shader_mask_screen.dart';

import 'seascape/seascape_screen.dart';
import 'gradient_background/gradient_background_screen.dart';

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/seascape',
      builder: (context, state) => const SeascapeScreen(),
    ),
    GoRoute(
      path: '/gradient-background',
      builder: (context, state) => const GradientBackgroundScreen(),
    ),
    GoRoute(
      path: '/shader-mask',
      builder: (context, state) => const ShaderMaskScreen(),
    ),
  ],
);

void main() {
  runApp(const MyApp());
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
              onPressed: () => context.push('/seascape'),
              child: const Text('Seascape'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/gradient-background'),
              child: const Text('Gradient Background'),
            ),
            ElevatedButton(
              onPressed: () => context.push('/shader-mask'),
              child: const Text('ShaderMask'),
            ),
          ],
        ),
      ),
    );
  }
}
