// lib/pages/home_page.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../models/models.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final currency = state.currency;

    final total = state.portfolioTotal;
    final sections = state.investments.map((i) {
      final percent = total == 0 ? 0.0 : (i.amount / total) * 100;
      return PieChartSectionData(
        color: i.color,
        value: i.amount,
        title: '${percent.toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      );
    }).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Dashboard', style: Theme.of(context).textTheme.headlineSmall),
              Text(currency.format(total), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.greenAccent)),
            ],
          ),
          const SizedBox(height: 12),
          // Cards de métricas
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              final int gridCount = w < 480
                  ? 1
                  : (w < 900
                      ? 2
                      : 4);
              return GridView.count(
                crossAxisCount: gridCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 2.6,
                children: [
                  _MetricCard(title: 'Patrimônio Total', value: currency.format(total), icon: Icons.savings_outlined, color: Colors.greenAccent),
                  _MetricCard(title: 'Total Investido', value: currency.format(98500), icon: Icons.schedule, color: Colors.blueAccent),
                  _MetricCard(title: 'Rentabilidade Total', value: '27.3%', icon: Icons.trending_up, color: Colors.tealAccent),
                  _MetricCard(title: 'Retorno Mensal', value: '8.5%', icon: Icons.show_chart, color: Colors.orangeAccent),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
          // Recomendações (resumo)
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.recommend_outlined, size: 18),
                      SizedBox(width: 8),
                      Text('Recomendações', style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...state.recommendations.take(3).map((r) {
                    final tagColor = r.tag == AlignmentTag.aligned ? Colors.blue : Colors.purple;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(r.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Wrap(spacing: 8, children: [
                                  Chip(label: Text(r.category)),
                                  if (r.institution != null) Chip(label: Text(r.institution!)),
                                  if (r.termLabel != null) Chip(label: Text(r.termLabel!)),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: tagColor.withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: tagColor.withOpacity(0.4)),
                                    ),
                                    child: Text(
                                      r.tag == AlignmentTag.aligned ? 'Alinhado' : 'Diversificar',
                                      style: TextStyle(color: tagColor, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('${r.expectedReturnYear.toStringAsFixed(1)}% a.a.', style: const TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Insights automáticos
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.lightbulb_outline, size: 18),
                      SizedBox(width: 8),
                      Text('Insights automáticos', style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...state.insights.take(3).map((insight) {
                    final color = insight.direction == ImpactDirection.positive
                        ? Colors.green
                        : insight.direction == ImpactDirection.negative
                            ? Colors.red
                            : Colors.grey;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 6, height: 6, margin: const EdgeInsets.only(top: 8), decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(insight.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                                const SizedBox(height: 2),
                                Text(insight.description),
                                const SizedBox(height: 4),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    ...insight.relatedAssets.map((a) => Chip(label: Text(a))),
                                    Chip(label: Text('conf. ${(insight.confidence * 100).round()}%')),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Resumo da carteira com pizza
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Text('Resumo da Carteira', style: TextStyle(fontWeight: FontWeight.w700)),
                      SizedBox(width: 6),
                      Icon(Icons.trending_up, size: 16),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: state.investments.map((i) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(width: 10, height: 10, decoration: BoxDecoration(color: i.color, shape: BoxShape.circle)),
                                const SizedBox(width: 6),
                                Text('${i.assetClass}: ${currency.format(i.amount)}'),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 180,
                        height: 180,
                        child: PieChart(
                          PieChartData(
                            sectionsSpace: 2,
                            centerSpaceRadius: 30,
                            sections: sections,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                  const SizedBox(height: 4),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
                      softWrap: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}