// lib/models/models.dart
import 'package:flutter/material.dart';

class Investment {
  final String assetClass;
  final double amount;
  final Color color;
  const Investment({required this.assetClass, required this.amount, required this.color});
}

class TimePoint {
  final int monthIndex; // 0..11
  final double value;
  const TimePoint({required this.monthIndex, required this.value});
}

class BankAccount {
  final String bank;
  final String accountMasked;
  final double balance;
  const BankAccount({required this.bank, required this.accountMasked, required this.balance});
}

class UserProfile {
  final String name;
  final String email;
  final String phone;
  const UserProfile({required this.name, required this.email, required this.phone});

  UserProfile copyWith({String? name, String? email, String? phone}) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

enum ImpactDirection { positive, negative, neutral }

class NewsImpact {
  final String assetCode; // ex: PETR4, VALE3
  final ImpactDirection impact;
  final double confidence; // 0.0 - 1.0
  const NewsImpact({required this.assetCode, required this.impact, required this.confidence});
}

class NewsItem {
  final String id;
  final String title;
  final String source;
  final DateTime publishedAt;
  final String summary;
  final List<NewsImpact> impacts; // múltiplos ativos

  const NewsItem({
    required this.id,
    required this.title,
    required this.source,
    required this.publishedAt,
    required this.summary,
    required this.impacts,
  });
}

class InsightSuggestion {
  final String title;
  final String description;
  final ImpactDirection direction;
  final double confidence; // 0.0 - 1.0
  final List<String> relatedAssets; // ex: ['PETR4']

  const InsightSuggestion({
    required this.title,
    required this.description,
    required this.direction,
    required this.confidence,
    required this.relatedAssets,
  });
}

class SectorHeat {
  final String sector;
  final double score; // -1.0 (muito negativo) a 1.0 (muito positivo)
  final List<String> topAssets;
  const SectorHeat({required this.sector, required this.score, required this.topAssets});
}

enum AlertSeverity { info, warning, critical }

class AlertItem {
  final String id;
  final String assetCode;
  final String message;
  final DateTime createdAt;
  final AlertSeverity severity;
  const AlertItem({
    required this.id,
    required this.assetCode,
    required this.message,
    required this.createdAt,
    required this.severity,
  });
}

class SimulationResult {
  final double deltaPercent; // exemplo: 0.004 = +0.4%
  final double deltaValue;   // em moeda
  const SimulationResult({required this.deltaPercent, required this.deltaValue});
}

enum ChatSender { user, assistant }

class ChatMessage {
  final String id;
  final ChatSender sender;
  final String text;
  final DateTime createdAt;
  const ChatMessage({required this.id, required this.sender, required this.text, required this.createdAt});
}

class Article {
  final String id;
  final String category; // ex: 'Renda Fixa', 'CDB', 'CDI', 'Ações', 'Fundos'
  final String title;
  final String content; // markdown simples / texto
  const Article({required this.id, required this.category, required this.title, required this.content});
}

class Advisor {
  final String id;
  final String name;
  final String email;
  const Advisor({required this.id, required this.name, required this.email});
}

enum RiskLevel { low, medium, high }
enum AlignmentTag { aligned, diversify }

class Recommendation {
  final String id;
  final String name; // ex: CDB Banco X 110% CDI / Ação PETR4
  final String category; // Renda Fixa, Ações, Fundos
  final RiskLevel risk;
  final double expectedReturnYear; // em % aa
  final double? minApplication; // valor mínimo
  final AlignmentTag tag; // alinhado ou diversificar
  final String summary;
  final String? institution; // ex: Banco XYZ, Gestora ABC
  final String? termLabel; // ex: D+1, 24 meses, 90 dias

  const Recommendation({
    required this.id,
    required this.name,
    required this.category,
    required this.risk,
    required this.expectedReturnYear,
    this.minApplication,
    required this.tag,
    required this.summary,
    this.institution,
    this.termLabel,
  });
}