// lib/pages/education_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  String _selected = 'Todos';

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final categories = {
      'Todos',
      ...state.articles.map((a) => a.category),
    }.toList()
      ..sort();

    final filtered = _selected == 'Todos'
        ? state.articles
        : state.articles.where((a) => a.category == _selected).toList();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Educação Financeira', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((c) {
              final sel = c == _selected;
              return ChoiceChip(
                selected: sel,
                label: Text(c),
                onSelected: (_) => setState(() => _selected = c),
              );
            }).toList(),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                final a = filtered[index];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(label: Text(a.category)),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                a.title,
                                style: const TextStyle(fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(a.content),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


