import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonAppBar extends AppBar {
  CommonAppBar({super.key, required String title})
      : super(
          title: Text(title),
          leading: Builder(
            builder: (context) => BackButton(
              onPressed: () => context.pop(),
            ),
          ),
        );
}
