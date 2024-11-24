import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/pages/pairs_categories/cubit/pairs_categories_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs_categories/ui/widgets/pairs_category_card.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:transparent_pointer/transparent_pointer.dart';

final class PairsCategoriesBody extends StatelessWidget {
  const PairsCategoriesBody({super.key});

  String? _categoryAssetPath(PairsCategoryType categoryType) {
    return switch (categoryType) {
      OfflinePairsCategoryType.figures =>
        'assets/raw/offline_categories/figures.png',
      OfflinePairsCategoryType.countryFlags =>
        'assets/raw/offline_categories/flags.png',
      OfflinePairsCategoryType.numbersAndLetters =>
        'assets/raw/offline_categories/numbers&letters.png',
      OfflinePairsCategoryType.colors =>
        'assets/raw/offline_categories/colors.png',
      OnlinePairsCategoryType.sport => 'assets/raw/online_categories/sport.png',
      OnlinePairsCategoryType.vehicle =>
        'assets/raw/online_categories/vehicle.png',
      OnlinePairsCategoryType.plants =>
        'assets/raw/online_categories/plants.png',
      OnlinePairsCategoryType.science =>
        'assets/raw/online_categories/science.png',
      OnlinePairsCategoryType.music => 'assets/raw/online_categories/music.png',
      OnlinePairsCategoryType.animals =>
        'assets/raw/online_categories/animals.png',
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsCategoriesCubit, PairsCategoriesState, bool>(
      selector: (state) => state.canAddNewCategory,
      builder: (context, canAddNewCategory) {
        return BlocSelector<PairsCategoriesCubit, PairsCategoriesState, bool>(
          selector: (state) => state.canSelectOnlineCategories,
          builder: (context, canSelectOnlineCategories) {
            return Stack(
              children: [
                Column(
                  children: [
                    CustomAppBar(
                      titleText: 'Cards categories',
                      leadingIcon: Icons.arrow_back_ios_new,
                      onLeadingTap: () {
                        AppRouter.navigationInstance.maybePop();
                      },
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: RefreshIndicator(
                          onRefresh: context
                              .read<PairsCategoriesCubit>()
                              .updateInternetStatus,
                          backgroundColor: Colors.white,
                          color: context.appTheme.activeElementColor,
                          child: CustomScrollView(
                            physics: const ClampingScrollPhysics(),
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Offline categories',
                                      style: context.textTheme.headlineMedium,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              SliverGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                children: [
                                  for (final offlineCategoryType
                                      in OfflinePairsCategoryType.values)
                                    PairsCategoryCard(
                                      assetName: _categoryAssetPath(
                                        offlineCategoryType,
                                      ),
                                      canAddNewPairsCategory: canAddNewCategory,
                                      pairsCategoryType: offlineCategoryType,
                                      canSelect: true,
                                    ),
                                ],
                              ),
                              SliverToBoxAdapter(
                                child: Divider(
                                  height: 64,
                                  color: context.appTheme.activeElementColor,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Online categories',
                                      style: context.textTheme.headlineMedium,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              SliverVisibility(
                                visible: !canSelectOnlineCategories,
                                sliver: SliverToBoxAdapter(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.warning_outlined,
                                            color: context
                                                .appTheme.primaryIconColor,
                                            size: 36.r,
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              'Check your Internet connection for select this categories',
                                              style: context
                                                  .textTheme.headlineMedium,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                              SliverGrid.count(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 16,
                                children: [
                                  for (final onlineCategoryType
                                      in OnlinePairsCategoryType.values)
                                    PairsCategoryCard(
                                      assetName: _categoryAssetPath(
                                        onlineCategoryType,
                                      ),
                                      canAddNewPairsCategory: canAddNewCategory,
                                      pairsCategoryType: onlineCategoryType,
                                      canSelect: canSelectOnlineCategories,
                                    ),
                                ],
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 200),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TransparentPointer(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            context.appTheme.mainBackground.withOpacity(0),
                            context.appTheme.mainBackground,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 150),
                          BlocSelector<PairsCategoriesCubit,
                              PairsCategoriesState, bool>(
                            selector: (state) =>
                                state.categoriesTypes.isNotEmpty,
                            builder: (context, canNavigateToGame) {
                              return Row(
                                children: [
                                  Expanded(
                                    child: MainButton.text(
                                      onTap: () {
                                        SoundsAndEffectsService.instance
                                            .playTapSound();
                                        context
                                            .read<PairsCategoriesCubit>()
                                            .navigateToPairsGame();
                                      },
                                      buttonText: 'Play',
                                      isActive: canNavigateToGame,
                                      textStyle: context.textTheme.headlineLarge
                                          ?.copyWith(
                                        letterSpacing: 4,
                                        color:
                                            context.appTheme.contrastTextColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                      ),
                                      margin: EdgeInsets.only(
                                        left: context.availableWidth * 0.2,
                                        right: context.availableWidth * 0.2,
                                        bottom:
                                            context.viewPaddingOf.bottom + 32,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
