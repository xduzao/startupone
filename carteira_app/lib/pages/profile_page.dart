// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/models.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _name;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  final TextEditingController _advName = TextEditingController();
  final TextEditingController _advEmail = TextEditingController();

  @override
  void initState() {
    super.initState();
    final profile = context.read<AppState>().userProfile;
    _name = TextEditingController(text: profile.name);
    _email = TextEditingController(text: profile.email);
    _phone = TextEditingController(text: profile.phone);
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    _advName.dispose();
    _advEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Perfil do usuário', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  TextField(controller: _name, decoration: const InputDecoration(labelText: 'Nome')),
                  const SizedBox(height: 12),
                  TextField(controller: _email, decoration: const InputDecoration(labelText: 'E-mail')),
                  const SizedBox(height: 12),
                  TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Telefone')),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: () {
                            state.updateProfile(UserProfile(
                              name: _name.text,
                              email: _email.text,
                              phone: _phone.text,
                            ));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Perfil atualizado')));
                          },
                          child: const Text('Salvar'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Consultores/Acessores', style: Theme.of(context).textTheme.titleMedium),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _advName,
                          decoration: const InputDecoration(labelText: 'Nome do consultor'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _advEmail,
                          decoration: const InputDecoration(labelText: 'E-mail'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      FilledButton(
                        onPressed: () {
                          if (_advName.text.trim().isEmpty || _advEmail.text.trim().isEmpty) return;
                          context.read<AppState>().addAdvisor(_advName.text.trim(), _advEmail.text.trim());
                          _advName.clear();
                          _advEmail.clear();
                        },
                        child: const Text('Adicionar'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.advisors.length,
                    itemBuilder: (context, index) {
                      final adv = state.advisors[index];
                      return Card(
                        child: ListTile(
                          leading: const Icon(Icons.badge_outlined),
                          title: Text(adv.name),
                          subtitle: Text(adv.email, style: const TextStyle(color: Colors.black54)),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () => context.read<AppState>().removeAdvisor(adv.id),
                          ),
                        ),
                      );
                    },
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