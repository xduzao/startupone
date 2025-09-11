// lib/pages/open_finance_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class OpenFinancePage extends StatelessWidget {
  const OpenFinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final currency = state.currency;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Text('Saldos (Open Finance)', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...state.bankAccounts.map((a) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const Icon(Icons.account_balance_wallet_outlined),
                  title: Text(a.bank),
                  subtitle: Text(a.accountMasked, style: const TextStyle(color: Colors.black54)),
                  trailing: Text(
                    currency.format(a.balance),
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ),
            );
          }),
          const SizedBox(height: 8),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.6),
            child: ListTile(
              title: const Text('Total em contas'),
              trailing: Text(
                currency.format(state.bankTotal),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}