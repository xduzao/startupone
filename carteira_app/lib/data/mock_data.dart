// lib/data/mock_data.dart
import 'package:flutter/material.dart';
import '../models/models.dart';

class MockData {
  // Carteira (por classe de ativo)
  final List<Investment> investments = const [
    Investment(assetClass: 'Renda Fixa', amount: 35000, color: Color(0xFF4CAF50)),
    Investment(assetClass: 'Ações', amount: 25000, color: Color(0xFF2196F3)),
    Investment(assetClass: 'Fundos', amount: 15000, color: Color(0xFFFF9800)),
    Investment(assetClass: 'Internacional', amount: 10000, color: Color(0xFF9C27B0)),
    Investment(assetClass: 'Cripto', amount: 5000, color: Color(0xFFF44336)),
  ];

  // Série temporal da carteira (12 meses) e benchmark
  final List<TimePoint> portfolioSeries = List.generate(
    12,
    (i) => TimePoint(monthIndex: i, value: 80000 + i * 1500 + (i % 3) * 900),
  );

  final List<TimePoint> benchmarkSeries = List.generate(
    12,
    (i) => TimePoint(monthIndex: i, value: 78000 + i * 1200 + (i % 2) * 700),
  );

  // Contas bancárias (Open Finance)
  final List<BankAccount> bankAccounts = const [
    BankAccount(bank: 'Itaú', accountMasked: 'Ag 1234 / CC •••• 4321', balance: 12000.50),
    BankAccount(bank: 'Nubank', accountMasked: 'Conta •••• 9988', balance: 8200.00),
    BankAccount(bank: 'Inter', accountMasked: 'Ag 0001 / CC •••• 1010', balance: 4050.30),
  ];

  // Perfil
  final UserProfile userProfile = const UserProfile(
    name: 'Ana Souza',
    email: 'ana.souza@example.com',
    phone: '(11) 98888-7777',
  );

  // Score inicial e rótulo de perfil
  final double performanceScore = 0.74; // 74%
  final String investorProfileLabel = 'Moderado';

  // Notícias e impactos (mock)
  final List<NewsItem> news = [
    NewsItem(
      id: 'n1',
      title: 'Petrobras anuncia aumento de produção no pré-sal',
      source: 'Valor Econômico',
      publishedAt: DateTime.now().subtract(const Duration(hours: 3)),
      summary: 'Companhia projeta alta de 6% na produção de 2025, com foco em eficiência.',
      impacts: const [
        NewsImpact(assetCode: 'PETR4', impact: ImpactDirection.positive, confidence: 0.82),
      ],
    ),
    NewsItem(
      id: 'n2',
      title: 'Queda do minério pressiona setor de mineração',
      source: 'Bloomberg',
      publishedAt: DateTime.now().subtract(const Duration(hours: 7)),
      summary: 'Recuo de 2.1% no minério de ferro em Dalian aumenta cautela no curto prazo.',
      impacts: const [
        NewsImpact(assetCode: 'VALE3', impact: ImpactDirection.negative, confidence: 0.74),
      ],
    ),
    NewsItem(
      id: 'n3',
      title: 'Copom mantém juros; comunicado sugere estabilidade',
      source: 'BCB',
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
      summary: 'Decisão em linha com expectativas; mercado revisa projeções de renda fixa.',
      impacts: const [
        NewsImpact(assetCode: 'TESOURO SELIC', impact: ImpactDirection.neutral, confidence: 0.6),
      ],
    ),
  ];

  // Insights automáticos (mock)
  final List<InsightSuggestion> insights = const [
    InsightSuggestion(
      title: 'Aumento de produção da PETR4 favorece curto prazo',
      description: 'Fluxo de caixa mais previsível e guidance positivo sugere ajuste +1%.',
      direction: ImpactDirection.positive,
      confidence: 0.78,
      relatedAssets: ['PETR4'],
    ),
    InsightSuggestion(
      title: 'Minério pressionado: cautela com VALE3',
      description: 'Preço spot recuando exige redução tática de exposição em 0.5%.',
      direction: ImpactDirection.negative,
      confidence: 0.72,
      relatedAssets: ['VALE3'],
    ),
    InsightSuggestion(
      title: 'Juros estáveis: reforço em renda fixa curta',
      description: 'Ambiente favorece carregamento em títulos pós-fixados.',
      direction: ImpactDirection.neutral,
      confidence: 0.64,
      relatedAssets: ['TESOURO SELIC'],
    ),
  ];

  // Heatmap por setores (mock)
  final List<SectorHeat> sectorHeat = const [
    SectorHeat(sector: 'Energia', score: 0.6, topAssets: ['PETR4', 'PRIO3']),
    SectorHeat(sector: 'Mineração', score: -0.4, topAssets: ['VALE3']),
    SectorHeat(sector: 'Bancos', score: 0.2, topAssets: ['ITUB4', 'BBDC4']),
    SectorHeat(sector: 'Renda Fixa', score: 0.1, topAssets: ['TESOURO SELIC']),
    SectorHeat(sector: 'Tecnologia', score: 0.35, topAssets: ['HASH11']),
  ];

  // Alertas (mock)
  final List<AlertItem> alerts = [
    AlertItem(
      id: 'a1',
      assetCode: 'VALE3',
      message: 'Gap de -1.1% no minério; atenção à volatilidade intraday.',
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      severity: AlertSeverity.warning,
    ),
    AlertItem(
      id: 'a2',
      assetCode: 'PETR4',
      message: 'Revisão de guidance positiva; possível revisão de target.',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      severity: AlertSeverity.info,
    ),
  ];

  // Artigos educacionais (mock)
  final List<Article> articles = const [
    Article(
      id: 'art-cdb',
      category: 'Renda Fixa',
      title: 'CDB: o que é e como funciona',
      content:
          'O CDB é um título emitido por bancos. Você empresta dinheiro ao banco e recebe juros. Pode ser **pré** (taxa fixa) ou **pós** (indexado ao CDI). Avalie liquidez e garantia do FGC.',
    ),
    Article(
      id: 'art-cdi',
      category: 'Renda Fixa',
      title: 'CDI: referência dos juros entre bancos',
      content:
          'O CDI é a taxa utilizada como referência para diversos investimentos pós-fixados. Quando um CDB paga 110% do CDI, significa que acompanha a variação do CDI com um prêmio.',
    ),
    Article(
      id: 'art-pre',
      category: 'Renda Fixa',
      title: 'Pré-fixado vs Pós-fixado',
      content:
          'No **pré-fixado** você conhece a taxa desde o início, ganhando se os juros caírem. No **pós-fixado** (CDI/SELIC) a remuneração acompanha a taxa ao longo do tempo, reduzindo risco de marcação a mercado.',
    ),
    Article(
      id: 'art-acoes',
      category: 'Ações',
      title: 'Ações: participação em empresas',
      content:
          'Ações representam frações do capital de uma empresa. Retorno vem de valorização e dividendos. Risco elevado no curto prazo; diversifique por setores e prefira visão de longo prazo.',
    ),
    Article(
      id: 'art-fundos',
      category: 'Fundos',
      title: 'Fundos de Investimento',
      content:
          'Fundos reúnem recursos de vários investidores com gestão profissional. Existem fundos de renda fixa, ações, multimercado e imobiliários. Observe taxa de administração e estratégia.',
    ),
  ];

  // Recomendações (mock)
  final List<Recommendation> recommendations = const [
    Recommendation(
      id: 'rec-cdb-110',
      name: 'CDB Banco XYZ 110% do CDI',
      category: 'Renda Fixa',
      risk: RiskLevel.low,
      expectedReturnYear: 12.1,
      minApplication: 1000,
      tag: AlignmentTag.aligned,
      summary: 'Liquidez D+1, FGC. Boa opção para caixa com remuneração acima do CDI.',
      institution: 'Banco XYZ',
      termLabel: 'D+1',
    ),
    Recommendation(
      id: 'rec-petr4',
      name: 'PETR4',
      category: 'Ações',
      risk: RiskLevel.high,
      expectedReturnYear: 18.0,
      minApplication: null,
      tag: AlignmentTag.aligned,
      summary: 'Fluxo de caixa robusto e guidance positivo, mas sujeito a volatilidade do petróleo.',
      institution: 'B3',
      termLabel: 'Sem prazo',
    ),
    Recommendation(
      id: 'rec-fundo-mm',
      name: 'Fundo Multimercado Atlas',
      category: 'Fundos',
      risk: RiskLevel.medium,
      expectedReturnYear: 14.5,
      minApplication: 5000,
      tag: AlignmentTag.diversify,
      summary: 'Estratégia macro com baixa correlação; boa alternativa para diversificação.',
      institution: 'Gestora Atlas',
      termLabel: 'Cotização D+5',
    ),
  ];
}