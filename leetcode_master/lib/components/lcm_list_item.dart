import 'package:flutter/material.dart';
import '../config/constants.dart';
import 'lcm_badge.dart';

/// Reusable list item for problems and categories
class LCMListItem extends StatelessWidget {
  const LCMListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.difficulty,
    this.isSolved = false,
    this.isLocked = false,
    this.isPremium = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Difficulty? difficulty;
  final bool isSolved;
  final bool isLocked;
  final bool isPremium;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isLocked ? null : onTap,
        splashColor: LCMColors.primary.withOpacity(0.1),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: LCMDimensions.paddingMD,
            vertical: LCMDimensions.paddingSM + 4,
          ),
          constraints: const BoxConstraints(
            minHeight: LCMDimensions.touchTarget,
          ),
          child: Row(
            children: [
              // Leading widget or status indicator
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: LCMDimensions.paddingSM),
                  child: leading,
                )
              else
                Padding(
                  padding: const EdgeInsets.only(right: LCMDimensions.paddingSM),
                  child: _buildStatusIndicator(),
                ),

              // Title and subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: isLocked
                                  ? LCMColors.textMuted
                                  : LCMColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isPremium) ...[
                          const SizedBox(width: LCMDimensions.paddingSM),
                          const LCMPremiumBadge(),
                        ],
                      ],
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: LCMColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Difficulty badge
              if (difficulty != null)
                Padding(
                  padding: const EdgeInsets.only(left: LCMDimensions.paddingSM),
                  child: LCMBadge(difficulty: difficulty!),
                ),

              // Trailing widget or lock/chevron
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: LCMDimensions.paddingSM),
                  child: trailing,
                )
              else if (isLocked)
                const Padding(
                  padding: EdgeInsets.only(left: LCMDimensions.paddingSM),
                  child: Icon(
                    Icons.lock_outline,
                    size: 20,
                    color: LCMColors.textMuted,
                  ),
                )
              else
                const Padding(
                  padding: EdgeInsets.only(left: LCMDimensions.paddingSM),
                  child: Icon(
                    Icons.chevron_right,
                    size: 24,
                    color: LCMColors.textSecondary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    if (isSolved) {
      return Container(
        width: 20,
        height: 20,
        decoration: const BoxDecoration(
          color: LCMColors.success,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.check,
          size: 14,
          color: Colors.white,
        ),
      );
    }

    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: LCMColors.border,
          width: 2,
        ),
      ),
    );
  }
}
