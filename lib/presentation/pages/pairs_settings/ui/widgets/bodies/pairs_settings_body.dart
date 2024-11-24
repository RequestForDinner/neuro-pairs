import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/cubit/pairs_settings_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/ui/widgets/pairs_grid_selector.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/ui/widgets/pairs_time_selector.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class PairsSettingsBody extends StatelessWidget {
  const PairsSettingsBody({super.key});

  void _navigateToPairsCategories(BuildContext context) {
    context.read<PairsSettingsCubit>().navigateToPairsCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            CustomAppBar(
              titleText: 'Game settings',
              leadingIcon: Icons.arrow_back_ios_new,
              onLeadingTap: () {
                AppRouter.navigationInstance.maybePop();
              },
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pairs grid',
                      style: context.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    const PairsGridSelector(),
                    const SizedBox(height: 32),
                    const PairsTimeSelectors(),
                    const SizedBox(height: 200),
                  ],
                ),
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: MainButton.text(
            onTap: () {
              SoundsAndEffectsService.instance.playTapSound();
              _navigateToPairsCategories(context);
            },
            needExpandWidth: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.only(
              left: context.availableWidth * 0.2,
              right: context.availableWidth * 0.2,
              bottom: context.viewPaddingOf.bottom + 32,
            ),
            textStyle: context.textTheme.headlineLarge?.copyWith(
              letterSpacing: 4,
              color: context.appTheme.contrastTextColor,
              fontWeight: FontWeight.bold,
            ),
            buttonText: 'Next',
          ),
        ),
      ],
    );
  }
}
