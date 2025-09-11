// lib/app_state.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'data/mock_data.dart';
import 'models/models.dart';

class AppState extends ChangeNotifier {
  final currency = NumberFormat.simpleCurrency(locale: 'pt_BR');

  List<Investment> investments = [];
  List<TimePoint> portfolioSeries = [];
  List<TimePoint> benchmarkSeries = [];
  List<BankAccount> bankAccounts = [];
  UserProfile userProfile = const UserProfile(name: '', email: '', phone: '');
  double performanceScore = 0.0; // 0.0 - 1.0
  String investorProfileLabel = '—';
  List<NewsItem> news = [];
  List<InsightSuggestion> insights = [];
  List<SectorHeat> sectorHeat = [];
  List<AlertItem> alerts = [];
  List<ChatMessage> chat = [];
  List<Article> articles = [];
  List<Advisor> advisors = [];
  List<Recommendation> recommendations = [];

  double get portfolioTotal =>
      investments.fold(0.0, (sum, i) => sum + i.amount);
  double get bankTotal =>
      bankAccounts.fold(0.0, (sum, a) => sum + a.balance);

  void initialize() {
    final m = MockData();
    investments = m.investments;
    portfolioSeries = m.portfolioSeries;
    benchmarkSeries = m.benchmarkSeries;
    bankAccounts = m.bankAccounts;
    userProfile = m.userProfile;
    performanceScore = m.performanceScore;
    investorProfileLabel = m.investorProfileLabel;
    news = m.news;
    insights = m.insights;
    sectorHeat = m.sectorHeat;
    alerts = m.alerts;
    chat = [
      ChatMessage(id: 'c1', sender: ChatSender.assistant, text: 'Olá! Eu sou sua IA de investimentos. Em que posso ajudar?', createdAt: DateTime.now().subtract(const Duration(minutes: 2))),
    ];
    articles = m.articles;
    advisors = [
      const Advisor(id: 'adv-1', name: 'Marcos Lima', email: 'marcos@advisor.com'),
    ];
    recommendations = m.recommendations;
    notifyListeners();
  }

  // Simulação mock: aplica um delta percentual hipotético ao patrimônio
  SimulationResult simulateImpact({required ImpactDirection dir, required double confidence}) {
    final base = portfolioTotal;
    final deltaPercent = (dir == ImpactDirection.positive
            ? 0.004
            : dir == ImpactDirection.negative
                ? -0.003
                : 0.000) * (0.5 + confidence * 0.5);
    final deltaValue = base * deltaPercent;
    return SimulationResult(deltaPercent: deltaPercent, deltaValue: deltaValue);
  }

  void addAdvisor(String name, String email) {
    final adv = Advisor(
      id: 'adv-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
    );
    advisors.add(adv);
    notifyListeners();
  }

  void removeAdvisor(String id) {
    advisors.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void sendMessage(String text) {
    final userMsg = ChatMessage(
      id: 'u${DateTime.now().millisecondsSinceEpoch}',
      sender: ChatSender.user,
      text: text,
      createdAt: DateTime.now(),
    );
    chat.add(userMsg);

    // resposta mock baseada em palavras-chave
    String reply;
    if (text.toLowerCase().contains('petr')) {
      reply = 'PETR4 está com viés positivo no curto prazo segundo nossas notícias.';
    } else if (text.toLowerCase().contains('vale')) {
      reply = 'VALE3 sofre com minério recuando. Cautela é recomendada.';
    } else {
      reply = 'Entendi. Posso simular impacto de uma notícia na sua carteira se desejar.';
    }
    chat.add(ChatMessage(
      id: 'a${DateTime.now().millisecondsSinceEpoch}',
      sender: ChatSender.assistant,
      text: reply,
      createdAt: DateTime.now().add(const Duration(milliseconds: 400)),
    ));
    notifyListeners();
  }

  void updateProfile(UserProfile profile) {
    userProfile = profile;
    notifyListeners();
  }

  void updateInvestorProfile(String label, double score) {
    investorProfileLabel = label;
    performanceScore = score.clamp(0.0, 1.0);
    notifyListeners();
  }
}