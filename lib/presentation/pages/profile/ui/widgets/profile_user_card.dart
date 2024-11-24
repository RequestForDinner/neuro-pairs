import 'package:flutter/material.dart';
import 'package:neuro_pairs/domain/entities/statistic/experience.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/progress_bar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/user_avatar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/user_level.dart';

final class ProfileUserCard extends StatelessWidget {
  final User user;
  final Statistic statistic;

  const ProfileUserCard({
    required this.user,
    required this.statistic,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 16),
        UserAvatar(imagePath: user.avatarUrl, dimension: 140),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.username,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall,
              ),
              if (user.email != null) ...[
                const SizedBox(height: 16),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: context.appTheme.nonActiveElementColor,
                    borderRadius: const BorderRadius.all(Radius.circular(32)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: FittedBox(
                      child: Text(
                        user.email ?? '',
                        style: context.textTheme.headlineSmall?.copyWith(
                          color: context.appTheme.secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              _ExperienceProgressBar(experience: statistic.experience)
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

final class _ExperienceProgressBar extends StatelessWidget {
  final Experience experience;

  const _ExperienceProgressBar({
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserLevel(level: experience.currentLevel),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '(${experience.currentExperience} xp.)',
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.appTheme.secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${experience.nextLevelExperience} xp.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.appTheme.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ProgressBar(
                      endProgressValue: experience.nextLevelExperience,
                      startProgressValue:
                          experience.startCurrentLevelExperience,
                      currentProgressValue: experience.currentExperience,
                      height: 6,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

final class _StatisticText extends StatelessWidget {
  final String title;
  final String text;

  const _StatisticText({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: context.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: context.appTheme.contrastTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: context.textTheme.headlineSmall?.copyWith(
            color: Colors.white.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
