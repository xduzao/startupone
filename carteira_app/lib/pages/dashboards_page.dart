// lib/pages/dashboards_page.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class DashboardsPage extends StatefulWidget {
  const DashboardsPage({super.key});

  @override
  State<DashboardsPage> createState() => _DashboardsPageState();
}

class _DashboardsPageState extends State<DashboardsPage> {
  String period = '12M';
  String assetFilter = 'Todos';

  List<String> _months() => const ['J', 'F', 'M', 'A', 'M', 'J', 'J', 'A', 'S', 'O', 'N', 'D'];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final months = _months();

    final lineSpotsPortfolio = state.portfolioSeries
        .map((p) => FlSpot(p.monthIndex.toDouble(), p.value))
        .toList();
    final lineSpotsBenchmark = state.benchmarkSeries
        .map((p) => FlSpot(p.monthIndex.toDouble(), p.value))
        .toList();

    final barGroups = List.generate(12, (i) {
      final aporte = (i % 3 == 0) ? 2000.0 : (i % 2 == 0 ? 1500.0 : 1000.0);
      return BarChartGroupData(x: i, barRods: [
        BarChartRodData(toY: aporte, width: 10, color: Colors.indigo),
      ]);
    });

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Row(
            children: [
              Expanded(child: Text('Evolução da carteira', style: Theme.of(context).textTheme.titleLarge)),
              DropdownButton<String>(
                value: period,
                items: const [
                  DropdownMenuItem(value: '6M', child: Text('6M')),
                  DropdownMenuItem(value: '12M', child: Text('12M')),
                  DropdownMenuItem(value: 'YTD', child: Text('YTD')),
                ],
                onChanged: (v) => setState(() => period = v ?? '12M'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: SizedBox(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (v, meta) {
                            final idx = v.toInt();
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(idx >= 0 && idx < months.length ? months[idx] : ''),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                      ),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    lineBarsData: [
                      LineChartBarData(spots: lineSpotsPortfolio, isCurved: true, color: Colors.indigo, barWidth: 3),
                      LineChartBarData(spots: lineSpotsBenchmark, isCurved: true, color: Colors.grey, barWidth: 2, dashArray: [6, 4]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: Text('Aportes mensais', style: Theme.of(context).textTheme.titleLarge)),
              DropdownButton<String>(
                value: assetFilter,
                items: const [
                  DropdownMenuItem(value: 'Todos', child: Text('Todos')),
                  DropdownMenuItem(value: 'Renda Fixa', child: Text('Renda Fixa')),
                  DropdownMenuItem(value: 'Ações', child: Text('Ações')),
                  DropdownMenuItem(value: 'Fundos', child: Text('Fundos')),
                  DropdownMenuItem(value: 'Internacional', child: Text('Internacional')),
                  DropdownMenuItem(value: 'Cripto', child: Text('Cripto')),
                ],
                onChanged: (v) => setState(() => assetFilter = v ?? 'Todos'),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Card(
            child: SizedBox(
              height: 220,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BarChart(
                  BarChartData(
                    barGroups: barGroups,
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 1,
                          getTitlesWidget: (v, meta) {
                            final idx = v.toInt();
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(idx >= 0 && idx < months.length ? months[idx] : ''),
                            );
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // KPIs padrões de mercado
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: const [
                  _Kpi(label: 'Retorno (12M)', value: '+12,4%'),
                  SizedBox(width: 16),
                  _Kpi(label: 'Volatilidade', value: '8,2%'),
                  SizedBox(width: 16),
                  _Kpi(label: 'Sharpe', value: '0,87'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Posições
          Text('Posições', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Card(
            child: Column(
              children: state.investments.map((i) {
                final allocPct = (i.amount / state.portfolioTotal) * 100;
                // P/L percentual mock entre -2% e 12%
                final idx = state.investments.indexOf(i);
                const samples = [4.2, -1.8, 7.5, 2.9, 11.2]; // em %
                final plPct = samples[idx % samples.length];
                final plColor = plPct >= 0 ? Colors.green : Colors.red;
                return ListTile(
                  title: Text(i.assetClass),
                  subtitle: Text('Alocação: ${allocPct.toStringAsFixed(1)}%'),
                  trailing: Text(
                    (plPct >= 0 ? '+' : '') + plPct.toStringAsFixed(2) + '%',
                    style: TextStyle(color: plColor, fontWeight: FontWeight.w700),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Kpi extends StatelessWidget {
  const _Kpi({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.black54)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w800)),
        ],
      ),
    );
  }
}