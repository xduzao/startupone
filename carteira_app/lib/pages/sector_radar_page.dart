// lib/pages/sector_radar_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class SectorRadarPage extends StatelessWidget {
  const SectorRadarPage({super.key});

  Color _colorForScore(double s) {
    if (s > 0.4) return Colors.green;
    if (s > 0.1) return Colors.lightGreen;
    if (s < -0.4) return Colors.red;
    if (s < -0.1) return Colors.orange;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Radar de Setores', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size.width > 900 ? 3 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: state.sectorHeat.map((h) {
                final c = _colorForScore(h.score);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle)),
                            const SizedBox(width: 8),
                            Text(h.sector, style: const TextStyle(fontWeight: FontWeight.w700)),
                            const Spacer(),
                            Text('${(h.score * 100).toStringAsFixed(0)}%'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text('Top ativos:'),
                        const SizedBox(height: 4),
                        Wrap(spacing: 8, children: h.topAssets.map((a) => Chip(label: Text(a))).toList()),
                      ],
                    ),
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


