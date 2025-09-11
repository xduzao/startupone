# Smartvest (Protótipo em Flutter)

Protótipo de alta fidelidade (quase MVP) para app/web de investimentos, feito em Flutter com suporte a Web e Mobile. Todo conteúdo é mockado para demonstração.

## Funcionalidades
- Dashboard com métricas rápidas, resumo da carteira e recomendações
- Carteira (gestão):
  - Evolução vs benchmark e aportes mensais
  - Filtros: período (6M, 12M, YTD) e classe de ativo
  - KPIs (mock): Retorno 12M, Volatilidade, Sharpe
  - Posições com alocação e P/L (%) por classe
- Recomendações: cards com retorno a.a., risco, instituição, prazo, mínimo e tag “Alinhado”/“Diversificar”
- Análise de Notícias: impactos por ativo e “Simular na carteira” (mock)
- Radar de Setores: heatmap por setor
- Score/Performance: gauge + justificativa do score (mock)
- Open Finance: saldos por banco e total
- Perfil: edição + consultores (listar/adicionar/remover)
- Educação: artigos por categoria (CDB, CDI, Pré/Pós, Ações, Fundos)
- Chat com IA (mock): respostas simples por palavra‑chave

## Tecnologias
- Flutter 3.x (Web/Android/iOS)
- Provider, go_router, fl_chart, percent_indicator, Google Fonts

## Estrutura
```
carteira_app/
  lib/
    app_router.dart
    app_state.dart
    data/mock_data.dart
    models/models.dart
    pages/
      ai_chat_page.dart
      dashboards_page.dart
      education_page.dart
      home_page.dart
      login_page.dart
      news_analysis_page.dart
      open_finance_page.dart
      profile_page.dart
      recommendations_page.dart
      score_page.dart
```

## Executar localmente
Pré‑requisitos: Flutter instalado e `flutter config --enable-web`.

```bash
cd carteira_app
flutter pub get
flutter run -d chrome  # Web
# ou
flutter run            # Emulador/dispositivo
```

## Build Web
```bash
cd carteira_app
flutter build web --release
```
Saída em `carteira_app/build/web`.

## Deploy no Firebase Hosting
Pré‑requisitos: Firebase CLI (`npm i -g firebase-tools`) e projeto criado.

Arquivos já configurados: `firebase.json` (SPA) e `.firebaserc` (projeto padrão).

```bash
cd carteira_app
firebase login                # se necessário
firebase use <seu-projeto>    # ex.: startupone-1c763
firebase deploy
```

## Observações
- Dados, cálculos e impactos são simulados (mock).
- Tela de login sem autenticação real.

## Licença
Uso livre para demonstração e estudos.
