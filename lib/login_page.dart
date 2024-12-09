import 'package:adjust/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            ref.read(isAuthenticatedProvider.notifier).tryAuth();
          },
          child: const Text("Login to Google Calendar"),
        ),
      ),
    );
  }
}