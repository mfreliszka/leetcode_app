import 'package:flutter/material.dart';

import '../data/mock_subscription_repository.dart';
import '../domain/subscription_repository.dart';

class PremiumUpsellPage extends StatelessWidget {
  const PremiumUpsellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Go Premium')),
      body: FutureBuilder<List<SubscriptionPlan>>(
        future: const MockSubscriptionRepository().listPlans(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final plans = snapshot.data ?? const [];
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _HeroSection(),
              const SizedBox(height: 16),
              for (final p in plans) ...[
                _PlanCard(plan: p),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: null, // purchase flow stubbed; disabled
                icon: const Icon(Icons.lock),
                label: const Text('Upgrade (stubbed)'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.2),
            Theme.of(context).colorScheme.secondary.withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Unlock Your Full Potential', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Access advanced problems, detailed approaches, and exclusive achievements.'),
        ],
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final SubscriptionPlan plan;
  const _PlanCard({required this.plan});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(plan.name, style: Theme.of(context).textTheme.titleMedium),
                Text(plan.pricePerMonth, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 8),
            for (final f in plan.features)
              Row(
                children: [
                  const Icon(Icons.check, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(child: Text(f)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}