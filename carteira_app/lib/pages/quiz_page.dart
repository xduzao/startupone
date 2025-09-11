// lib/pages/quiz_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final answers = <int, int>{}; // pergunta -> 0..4

  final questions = const [
    'Como você reage a oscilações de curto prazo?',
    'Qual seu objetivo de prazo para os investimentos?',
    'Como você se sente com risco para buscar retorno maior?',
    'Qual percentual de renda você pode investir mensalmente?',
    'Qual sua experiência com investimentos?',
  ];

  final options = const [
    ['Vendo tudo', 'Fico desconfortável', 'Sigo o plano', 'Compro mais', 'Ignoro oscilações'],
    ['< 1 ano', '1-2 anos', '3-5 anos', '5-10 anos', '10+ anos'],
    ['Nada', 'Pouco', 'Moderado', 'Alto', 'Muito alto'],
    ['< 5%', '5-10%', '10-20%', '20-30%', '30%+'],
    ['Nenhuma', 'Pouca', 'Média', 'Alta', 'Profissional'],
  ];

  void _finish(BuildContext context) {
    final total = answers.values.fold<int>(0, (s, v) => s + v);
    // 0..20
    String label;
    double score;
    if (total <= 6) {
      label = 'Conservador';
      score = 0.55;
    } else if (total <= 12) {
      label = 'Moderado';
      score = 0.72;
    } else {
      label = 'Arrojado';
      score = 0.85;
    }
    context.read<AppState>().updateInvestorProfile(label, score);
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Perfil: $label')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teste de perfil')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length + 1,
        itemBuilder: (context, index) {
          if (index == questions.length) {
            final completed = answers.length == questions.length;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: FilledButton(
                onPressed: completed ? () => _finish(context) : null,
                child: const Text('Finalizar'),
              ),
            );
          }
          final q = questions[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q, style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(options[index].length, (optIndex) {
                      final selected = answers[index] == optIndex;
                      return ChoiceChip(
                        selected: selected,
                        label: Text(options[index][optIndex]),
                        onSelected: (_) {
                          setState(() {
                            answers[index] = optIndex;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}