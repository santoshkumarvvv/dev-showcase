import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _FeatureCard(
            icon: Icons.architecture,
            title: 'Clean Architecture',
            subtitle: 'Domain, data, presentation — fully separated.',
          ),
          _FeatureCard(
            icon: Icons.rocket_launch,
            title: 'CI/CD Ready',
            subtitle: 'GitHub Actions runs analyze + test on every PR.',
          ),
          _FeatureCard(
            icon: Icons.dark_mode,
            title: 'Theming'
            subtitle: 'Light and dark mode with Material 3.',
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
      ),
    );
  }
}
