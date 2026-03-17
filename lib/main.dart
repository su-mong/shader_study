import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.push('/seascape'),
              child: const Text('Seascape'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.push('/gradient-background'),
              child: const Text('Gradient Background'),
            ),
          ],
        ),
      ),
    );
  }
}
