// lib/pages/score_page.dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final percent = state.performanceScore;
    final label = state.investorProfileLabel;
    final explanation = _buildExplanation(label, percent);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Score de Performance', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                CircularPercentIndicator(
                  radius: 80,
                  lineWidth: 16,
                  percent: percent,
                  progressColor: Colors.indigo,
                  backgroundColor: Colors.indigo.withOpacity(0.15),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Text('${(percent * 100).round()}%', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                Text('Perfil atual: ${state.investorProfileLabel}', style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(
                  explanation,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black54),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => context.push('/quiz'),
                  child: const Text('Refazer teste de perfil'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _buildExplanation(String label, double percent) {
    final pct = (percent * 100).toStringAsFixed(0);
    switch (label) {
      case 'Conservador':
        return 'Score ${pct}%: carteira com baixa volatilidade, maior peso em renda fixa e liquidez. Desempenho consistente em cenários de juros estáveis.';
      case 'Moderado':
        return 'Score ${pct}%: equilíbrio entre renda fixa e variável. Notícias recentes favoreceram energia, enquanto mineração exige cautela.';
      case 'Arrojado':
        return 'Score ${pct}%: maior exposição a risco e crescimento. Curto prazo sensível a commodities, mas potencial de retorno acima do benchmark.';
      default:
        return 'Score ${pct}%: composição atual e sinais de notícias resultam neste desempenho simulado.';
    }
  }
}