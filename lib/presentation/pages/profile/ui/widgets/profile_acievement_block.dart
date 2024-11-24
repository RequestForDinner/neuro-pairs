import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/horizontal_insets.dart';

final class ProfileAchievementsBlock extends StatelessWidget {
  const ProfileAchievementsBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalInsets(
          child: Row(
            children: [
              Text(
                context.locale.achievements,
                style: context.textTheme.titleSmall,
              ),
              const Spacer(),
              MainButton.text(
                buttonText: context.locale.showAll,
                backgroundColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 8),
                textStyle: context.textTheme.headlineSmall?.copyWith(
                  color: context.appTheme.activeElementColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 100,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return const _Achievement();
            },
            separatorBuilder: (_, __) => const SizedBox(width: 12),
          ),
        )
      ],
    );
  }
}

final class _Achievement extends StatelessWidget {
  const _Achievement();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 100,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: context.appTheme.nonActiveElementColor,
          borderRadius: const BorderRadius.all(Radius.circular(100)),
        ),
      ),
    );
  }
}
