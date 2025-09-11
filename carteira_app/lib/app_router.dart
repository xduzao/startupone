// lib/app_router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/login_page.dart';
import 'pages/home_page.dart';
import 'pages/dashboards_page.dart';
import 'pages/score_page.dart';
import 'pages/open_finance_page.dart';
import 'pages/profile_page.dart';
import 'pages/quiz_page.dart';
import 'pages/news_analysis_page.dart';
import 'pages/sector_radar_page.dart';
import 'pages/ai_chat_page.dart';
import 'pages/education_page.dart';
import 'pages/recommendations_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) => _ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/dashboards',
          name: 'dashboards',
          builder: (context, state) => const DashboardsPage(),
        ),
        GoRoute(
          path: '/score',
          name: 'score',
          builder: (context, state) => const ScorePage(),
        ),
        GoRoute(
          path: '/open-finance',
          name: 'open_finance',
          builder: (context, state) => const OpenFinancePage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
        GoRoute(
          path: '/quiz',
          name: 'quiz',
          builder: (context, state) => const QuizPage(),
        ),
        GoRoute(
          path: '/news',
          name: 'news',
          builder: (context, state) => const NewsAnalysisPage(),
        ),
        GoRoute(
          path: '/radar',
          name: 'radar',
          builder: (context, state) => const SectorRadarPage(),
        ),
        GoRoute(
          path: '/chat',
          name: 'chat',
          builder: (context, state) => const AiChatPage(),
        ),
        GoRoute(
          path: '/educacao',
          name: 'educacao',
          builder: (context, state) => const EducationPage(),
        ),
        GoRoute(
          path: '/recomendacoes',
          name: 'recomendacoes',
          builder: (context, state) => const RecommendationsPage(),
        ),
      ],
    ),
  ],
);

class _ShellScaffold extends StatefulWidget {
  const _ShellScaffold({required this.child});
  final Widget child;

  @override
  State<_ShellScaffold> createState() => _ShellScaffoldState();
}

class _ShellScaffoldState extends State<_ShellScaffold> {
  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () => context.go('/'),
          child: const Text('Smartvest'),
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: ListTile(
                  leading: Icon(Icons.account_circle, size: 40),
                  title: Text('user@example.com'),
                  subtitle: Text('Investidor'),
                ),
              ),
              _NavTile(
                icon: Icons.dashboard_outlined,
                label: 'Dashboard',
                selected: location == '/' || location.startsWith('/?'),
                onTap: () => context.go('/'),
              ),
              _NavTile(
                icon: Icons.recommend_outlined,
                label: 'Recomendações',
                selected: location.startsWith('/recomendacoes'),
                onTap: () => context.go('/recomendacoes'),
              ),
              _NavTile(
                icon: Icons.show_chart,
                label: 'Carteira',
                selected: location.startsWith('/dashboards'),
                onTap: () => context.go('/dashboards'),
              ),
              _NavTile(
                icon: Icons.speed,
                label: 'Performance',
                selected: location.startsWith('/score'),
                onTap: () => context.go('/score'),
              ),
              _NavTile(
                icon: Icons.account_balance,
                label: 'Bancos',
                selected: location.startsWith('/open-finance'),
                onTap: () => context.go('/open-finance'),
              ),
              _NavTile(
                icon: Icons.newspaper,
                label: 'Notícias e Impacto',
                selected: location.startsWith('/news'),
                onTap: () => context.go('/news'),
              ),
              _NavTile(
                icon: Icons.grid_view,
                label: 'Radar de Setores',
                selected: location.startsWith('/radar'),
                onTap: () => context.go('/radar'),
              ),
              _NavTile(
                icon: Icons.chat_bubble_outline,
                label: 'Chat com IA',
                selected: location.startsWith('/chat'),
                onTap: () => context.go('/chat'),
              ),
              _NavTile(
                icon: Icons.school_outlined,
                label: 'Educação',
                selected: location.startsWith('/educacao'),
                onTap: () => context.go('/educacao'),
              ),
              _NavTile(
                icon: Icons.person_outline,
                label: 'Configurações',
                selected: location.startsWith('/profile'),
                onTap: () => context.go('/profile'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text('Sair'),
                onTap: () => context.go('/login'),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(child: widget.child),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: selected,
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
    );
  }
}