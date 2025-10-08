import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/settings_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultLangAsync = ref.watch(defaultLanguageProvider);
    const languages = ['python', 'javascript', 'java', 'cpp'];

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Preferences', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 16),
            Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Default programming language'),
                    const SizedBox(height: 8),
                    defaultLangAsync.when(
                      data: (current) => DropdownButtonFormField<String>(
                        initialValue: languages.contains(current) ? current : languages.first,
                        items: languages
                            .map((lang) => DropdownMenuItem<String>(value: lang, child: Text(lang)))
                            .toList(),
                        onChanged: (value) async {
                          if (value == null) return;
                          await ref.read(settingsRepoProvider).setDefaultLanguage(value);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Default language set to $value')),
                          );
                          ref.invalidate(defaultLanguageProvider);
                        },
                      ),
                      loading: () => const LinearProgressIndicator(),
                      error: (e, st) => const Text('Failed to load default language'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}