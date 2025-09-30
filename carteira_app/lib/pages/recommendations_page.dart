// lib/pages/recommendations_page.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/models.dart';

class RecommendationsPage extends StatelessWidget {
  const RecommendationsPage({super.key});

  Color _riskColor(RiskLevel r) {
    switch (r) {
      case RiskLevel.low:
        return Colors.green;
      case RiskLevel.medium:
        return Colors.orange;
      case RiskLevel.high:
        return Colors.red;
    }
  }

  String _riskLabel(RiskLevel r) {
    switch (r) {
      case RiskLevel.low:
        return 'Baixo risco';
      case RiskLevel.medium:
        return 'Médio risco';
      case RiskLevel.high:
        return 'Alto risco';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemCount: state.recommendations.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final rec = state.recommendations[index];
          final riskColor = _riskColor(rec.risk);
          final tag = rec.tag == AlignmentTag.aligned ? 'Alinhado' : 'Diversificar';
          final tagColor = rec.tag == AlignmentTag.aligned ? Colors.blue : Colors.purple;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LayoutBuilder(
                    builder: (context, c) {
                      final isNarrow = c.maxWidth < 420;

                      final header = Row(
                        children: [
                          Chip(label: Text(rec.category)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: tagColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: tagColor.withOpacity(0.4)),
                            ),
                            child: Text(tag, style: TextStyle(color: tagColor, fontWeight: FontWeight.w600)),
                          ),
                        ],
                      );

                      final left = Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          header,
                          const SizedBox(height: 4),
                          Text(rec.name, style: const TextStyle(fontWeight: FontWeight.w700)),
                          const SizedBox(height: 8),
                          Text(rec.summary),
                        ],
                      );

                      final right = Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${rec.expectedReturnYear.toStringAsFixed(1)}% a.a.', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.shield_outlined, color: riskColor, size: 16),
                              const SizedBox(width: 4),
                              Text(_riskLabel(rec.risk), style: TextStyle(color: riskColor)),
                            ],
                          ),
                          if (rec.minApplication != null) ...[
                            const SizedBox(height: 6),
                            Text('Mínimo: ${currency.format(rec.minApplication)}', style: const TextStyle(color: Colors.black54)),
                          ],
                          if (rec.institution != null || rec.termLabel != null) ...[
                            const SizedBox(height: 6),
                            if (rec.institution != null)
                              Text('Instituição: ${rec.institution}', style: const TextStyle(color: Colors.black54)),
                            if (rec.termLabel != null)
                              Text('Prazo: ${rec.termLabel}', style: const TextStyle(color: Colors.black54)),
                          ],
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: FilledButton(
                              onPressed: () {},
                              child: const Text('Ver detalhes'),
                            ),
                          ),
                        ],
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            left,
                            const SizedBox(height: 12),
                            right,
                          ],
                        );
                      }
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: left),
                          const SizedBox(width: 12),
                          right,
                        ],
                      );
                    },
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


