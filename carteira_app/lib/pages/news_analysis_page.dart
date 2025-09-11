// lib/pages/news_analysis_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/models.dart';

class NewsAnalysisPage extends StatelessWidget {
  const NewsAnalysisPage({super.key});

  Color _impactColor(ImpactDirection dir) {
    switch (dir) {
      case ImpactDirection.positive:
        return Colors.green;
      case ImpactDirection.negative:
        return Colors.red;
      case ImpactDirection.neutral:
        return Colors.grey;
    }
  }

  IconData _impactIcon(ImpactDirection dir) {
    switch (dir) {
      case ImpactDirection.positive:
        return Icons.arrow_upward_rounded;
      case ImpactDirection.negative:
        return Icons.arrow_downward_rounded;
      case ImpactDirection.neutral:
        return Icons.horizontal_rule_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final dateFmt = DateFormat('dd/MM HH:mm');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Análise de Notícias', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          ...state.news.map((n) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(n.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        Text(dateFmt.format(n.publishedAt), style: const TextStyle(color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(n.summary),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: n.impacts.map((imp) {
                        final color = _impactColor(imp.impact);
                        final icon = _impactIcon(imp.impact);
                        final label = imp.impact == ImpactDirection.positive
                            ? 'Positivo'
                            : imp.impact == ImpactDirection.negative
                                ? 'Negativo'
                                : 'Neutro';
                        return Chip(
                          avatar: Icon(icon, size: 16, color: color),
                          label: Text(
                            '${imp.assetCode} • $label • conf. ${(imp.confidence * 100).round()}%',
                            style: TextStyle(color: color),
                          ),
                          side: BorderSide(color: color.withOpacity(0.5)),
                          backgroundColor: color.withOpacity(0.08),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        FilledButton.tonal(
                          onPressed: () {
                            // simulação mock
                            final primary = n.impacts.isNotEmpty ? n.impacts.first : null;
                            if (primary == null) return;
                            final result = context.read<AppState>().simulateImpact(
                                  dir: primary.impact,
                                  confidence: primary.confidence,
                                );
                            final sign = result.deltaPercent >= 0 ? '+' : '';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Simulação: $sign${(result.deltaPercent * 100).toStringAsFixed(2)}% (${sign}${NumberFormat.simpleCurrency(locale: 'pt_BR').format(result.deltaValue)})'),
                              ),
                            );
                          },
                          child: const Text('Simular na carteira'),
                        ),
                        const Spacer(),
                        Text('Fonte: ${n.source}', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Wrap(
                        spacing: 8,
                        children: context.watch<AppState>().alerts
                            .where((a) => n.impacts.any((imp) => imp.assetCode == a.assetCode))
                            .map((a) {
                          Color c;
                          switch (a.severity) {
                            case AlertSeverity.info:
                              c = Colors.blue;
                              break;
                            case AlertSeverity.warning:
                              c = Colors.orange;
                              break;
                            case AlertSeverity.critical:
                              c = Colors.red;
                              break;
                          }
                          return Chip(
                            label: Text(a.message, style: const TextStyle(color: Colors.white)),
                            backgroundColor: c,
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}


