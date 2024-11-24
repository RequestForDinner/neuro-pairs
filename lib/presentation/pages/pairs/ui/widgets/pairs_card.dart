import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/domain/utils/enums/pairs_category_type.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs/entities/card_entity.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class PairsCard extends StatefulWidget {
  final int? cardIndex;

  final ValueSetter<CardEntity> onCardFlipped;
  final ValueSetter<String> onImageLoaded;

  const PairsCard({
    required this.cardIndex,
    required this.onImageLoaded,
    required this.onCardFlipped,
    super.key,
  });

  @override
  State<PairsCard> createState() => _PairsCardState();
}

class _PairsCardState extends State<PairsCard> {
  var _wasLoaded = false;

  void _flip(CardEntity card, bool globalFlipStatus) {
    if (!card.canFlip || !globalFlipStatus) return;

    widget.onCardFlipped(
      card.copyWith(wasFlipped: !card.wasFlipped),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsCubit, PairsState,
        ({CardEntity? card, bool canFlip})>(
      selector: (state) {
        return (
          card: state.allCards.elementAtOrNull(widget.cardIndex ?? -1),
          canFlip: state.canFlipCards,
        );
      },
      builder: (
        BuildContext context,
        ({CardEntity? card, bool canFlip}) params,
      ) {
        final card = params.card;

        if (card == null) return const SizedBox();

        return BlocSelector<PairsCubit, PairsState, PairsCategoryType>(
          selector: (state) {
            final typesImages = state.categoriesUniqueImages;

            return typesImages.keys.firstWhere(
              (key) => typesImages[key]!.contains(card.imagePath),
            );
          },
          builder: (context, pairsCategoryType) {
            return GestureDetector(
              onTap: () => _flip(card, params.canFlip),
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: card.wasFlipped ? pi : 0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                builder: (_, value, __) {
                  final needShowFront = value > pi / 2;

                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(value.toDouble()),
                    child: needShowFront
                        ? _FrontImage(
                            key: ValueKey<String>(card.uid),
                            imagePath: card.imagePath,
                            onImageLoaded: (image) {
                              widget.onImageLoaded(image);
                              _wasLoaded = true;
                            },
                            pairsCategoryType: pairsCategoryType,
                            wasLoaded: _wasLoaded,
                          )
                        : const _BackWidget(),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

final class _FrontImage extends StatefulWidget {
  final String? imagePath;
  final ValueSetter<String> onImageLoaded;
  final bool wasLoaded;

  final PairsCategoryType pairsCategoryType;

  const _FrontImage({
    required this.imagePath,
    required this.onImageLoaded,
    required this.wasLoaded,
    required this.pairsCategoryType,
    super.key,
  });

  @override
  State<_FrontImage> createState() => _FrontImageState();
}

class _FrontImageState extends State<_FrontImage> {
  void _finishImageLoading() {
    if (!widget.wasLoaded) {
      widget.onImageLoaded(widget.imagePath!);
    }
  }

  @override
  void didUpdateWidget(covariant _FrontImage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!widget.wasLoaded &&
        (widget.imagePath?.contains('assets/raw/offline_unique/') ?? false)) {
      _finishImageLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: ColoredBox(
                color: widget.pairsCategoryType ==
                        OfflinePairsCategoryType.countryFlags
                    ? Colors.white
                    : context.appTheme.nonActiveElementColor,
                child: Builder(
                  builder: (context) {
                    if (widget.imagePath!.contains('assets')) {
                      return Image.asset(
                        widget.imagePath!,
                        width: context.availableWidth,
                        fit: widget.pairsCategoryType ==
                                OfflinePairsCategoryType.countryFlags
                            ? BoxFit.fitWidth
                            : BoxFit.cover,
                        filterQuality: FilterQuality.low,
                      );
                    }

                    return Image.network(
                      widget.imagePath!,
                      width: context.availableWidth,
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.low,
                      scale: 0.5,
                      loadingBuilder: (_, child, chunkEvent) {
                        if (chunkEvent == null) {
                          _finishImageLoading();
                          return child;
                        }

                        return const SizedBox();
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class _BackWidget extends StatelessWidget {
  const _BackWidget();

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(pi * 2),
      child: DecoratedBox(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Stack(
            children: [
              Align(
                child: AspectRatio(
                  aspectRatio: 3,
                  child: SvgPicture.asset(
                    'assets/vector/question.svg',
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 4),
                      Expanded(
                        child: SvgPicture.asset(
                          'assets/vector/title_dark.svg',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                  ),
                  const AspectRatio(aspectRatio: 5),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
