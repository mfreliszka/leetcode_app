import 'package:flutter/material.dart';
import '../../../components/components.dart';
import '../../../config/constants.dart';

/// Settings screen with user preferences
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(LCMDimensions.paddingMD),
        children: [
          // User info section (placeholder)
          LCMCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: LCMColors.primary.withOpacity(0.2),
                  child: const Icon(
                    Icons.person,
                    size: 28,
                    color: LCMColors.primary,
                  ),
                ),
                const SizedBox(width: LCMDimensions.paddingMD),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign in to sync progress',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: LCMColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Your data is stored locally',
                        style: TextStyle(
                          fontSize: 14,
                          color: LCMColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: LCMColors.textSecondary,
                ),
              ],
            ),
            onTap: () {
              // TODO: Navigate to auth screen
            },
          ),
          const SizedBox(height: LCMDimensions.paddingLG),

          // Preferences section
          const Text(
            'PREFERENCES',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: LCMColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: LCMDimensions.paddingSM),
          LCMCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingsItem(
                  icon: Icons.code,
                  title: 'Default Language',
                  trailing: const Text(
                    'Python',
                    style: TextStyle(color: LCMColors.primary),
                  ),
                  onTap: () {
                    // TODO: Open language picker
                  },
                ),
                const Divider(height: 1),
                _SettingsItem(
                  icon: Icons.text_fields,
                  title: 'Font Size',
                  trailing: const Text(
                    'Medium',
                    style: TextStyle(color: LCMColors.primary),
                  ),
                  onTap: () {
                    // TODO: Open font size picker
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: LCMDimensions.paddingLG),

          // Data section
          const Text(
            'DATA',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: LCMColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: LCMDimensions.paddingSM),
          LCMCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingsItem(
                  icon: Icons.cloud_download_outlined,
                  title: 'Download for Offline',
                  trailing: const Text(
                    '0 MB',
                    style: TextStyle(color: LCMColors.textSecondary),
                  ),
                  onTap: () {
                    // TODO: Manage offline content
                  },
                ),
                const Divider(height: 1),
                _SettingsItem(
                  icon: Icons.delete_outline,
                  title: 'Clear Cache',
                  onTap: () {
                    // TODO: Clear local cache
                  },
                ),
                const Divider(height: 1),
                _SettingsItem(
                  icon: Icons.refresh,
                  title: 'Reset Progress',
                  titleColor: LCMColors.error,
                  onTap: () {
                    // TODO: Show confirmation dialog
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: LCMDimensions.paddingLG),

          // About section
          const Text(
            'ABOUT',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: LCMColors.textSecondary,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: LCMDimensions.paddingSM),
          LCMCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SettingsItem(
                  icon: Icons.info_outline,
                  title: 'Version',
                  trailing: const Text(
                    '1.0.0',
                    style: TextStyle(color: LCMColors.textSecondary),
                  ),
                  onTap: null,
                ),
                const Divider(height: 1),
                _SettingsItem(
                  icon: Icons.article_outlined,
                  title: 'Privacy Policy',
                  onTap: () {
                    // TODO: Open privacy policy
                  },
                ),
                const Divider(height: 1),
                _SettingsItem(
                  icon: Icons.description_outlined,
                  title: 'Terms of Service',
                  onTap: () {
                    // TODO: Open terms
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: LCMDimensions.paddingXL),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  const _SettingsItem({
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.titleColor,
  });

  final IconData icon;
  final String title;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: LCMDimensions.paddingMD,
            vertical: LCMDimensions.paddingSM + 4,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 22,
                color: titleColor ?? LCMColors.textSecondary,
              ),
              const SizedBox(width: LCMDimensions.paddingMD),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: titleColor ?? LCMColors.textPrimary,
                  ),
                ),
              ),
              if (trailing != null) trailing!,
              if (onTap != null && trailing == null)
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: LCMColors.textSecondary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
