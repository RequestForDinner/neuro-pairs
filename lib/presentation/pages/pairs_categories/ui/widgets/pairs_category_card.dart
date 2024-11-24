import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:neuro_pairs/presentation/pages/pairs_categories/cubit/pairs_categories_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class PairsCategoryCard extends StatelessWidget {
  final PairsCategoryType pairsCategoryType;
  final bool canAddNewPairsCategory;

  final String? assetName;

  final bool canSelect;

  const PairsCategoryCard({
    required this.assetName,
    required this.canAddNewPairsCategory,
    required this.pairsCategoryType,
    required this.canSelect,
    super.key,
  });

  String _categoryNameByType(BuildContext context) {
    return switch (pairsCategoryType) {
      OfflinePairsCategoryType.countryFlags => 'Flags',
      OfflinePairsCategoryType.colors => 'Colors',
      OfflinePairsCategoryType.figures => 'Figures',
      OfflinePairsCategoryType.numbersAndLetters => 'Numbers & Letters',
      OnlinePairsCategoryType.music => 'Music',
      OnlinePairsCategoryType.plants => 'Plants',
      OnlinePairsCategoryType.science => 'Science',
      OnlinePairsCategoryType.sport => 'Sport',
      OnlinePairsCategoryType.vehicle => 'Vehicle',
      OnlinePairsCategoryType.animals => 'Animals',
    };
  }

  void _updateSelectedPairsCategories(BuildContext context, bool alreadyAdded) {
    if (!canSelect) return;

    if (canAddNewPairsCategory) {
      context.read<PairsCategoriesCubit>().updateSelectedCategories(
            pairsCategoryType,
          );
    } else {
      if (alreadyAdded) {
        context.read<PairsCategoriesCubit>().updateSelectedCategories(
              pairsCategoryType,
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsCategoriesCubit, PairsCategoriesState, bool>(
      selector: (state) => state.categoriesTypes.contains(pairsCategoryType),
      builder: (context, alreadyAdded) {
        return MainButton.widget(
          padding: EdgeInsets.zero,
          needHover: false,
          onTap: () {
            SoundsAndEffectsService.instance.playTapSound();
            _updateSelectedPairsCategories(context, alreadyAdded);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              image: DecorationImage(
                image: AssetImage(
                  assetName ?? 'assets/raw/main_menu_background_image.jpeg',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(16),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(0),
                                Colors.black.withOpacity(0.7),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Spacer(),
                                      Text(
                                        _categoryNameByType(context),
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.headlineMedium
                                            ?.copyWith(
                                          color: context
                                              .appTheme.contrastTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Checkbox(
                    value: alreadyAdded,
                    checkColor: context.appTheme.contrastIconColor,
                    activeColor: context.appTheme.activeElementColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    onChanged: (_) => _updateSelectedPairsCategories(
                      context,
                      alreadyAdded,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: !canAddNewPairsCategory
                          ? Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                  Positioned.fill(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: !canSelect
                          ? Container(
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Center(
                                child: Icon(Icons.lock, size: 48.r),
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
