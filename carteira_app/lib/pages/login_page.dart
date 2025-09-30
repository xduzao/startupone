// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Card(
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 140,
                    width: double.infinity,
                    child: ClipRect(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        child: Image.asset('assets/logo.png'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text('Entrar', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                  TextField(decoration: const InputDecoration(labelText: 'E-mail')),
                  const SizedBox(height: 12),
                  TextField(decoration: const InputDecoration(labelText: 'Senha'), obscureText: true),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Continuar'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Pular'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}