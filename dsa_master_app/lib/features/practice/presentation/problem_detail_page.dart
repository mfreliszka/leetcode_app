import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProblemDetailPage extends StatelessWidget {
  final String problemId;
  const ProblemDetailPage({super.key, required this.problemId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Practice: $problemId')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Section(title: 'Description', child: Text('Problem description placeholder.')),
          const SizedBox(height: 16),
          const _Section(title: 'Constraints', child: Text('- n up to 10^5\n- values between -10^9 and 10^9')),
          const SizedBox(height: 16),
          const _Section(title: 'Hints', child: Text('Try using a hash map or two-pointer technique.')),
          const SizedBox(height: 16),
          const _Section(title: 'Approaches', child: Text('1) Brute force\n2) Optimized linear-time solution')),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => context.push('/practice/$problemId/approaches'),
            icon: const Icon(Icons.school),
            label: const Text('Learn Approaches'),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}