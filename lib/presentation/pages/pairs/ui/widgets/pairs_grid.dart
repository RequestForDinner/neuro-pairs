import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs/entities/card_entity.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/pairs_card.dart';

final class PairsGrid extends StatefulWidget {
  final PairsGridType pairsGridType;
  final VoidCallback onLoadingFinished;

  const PairsGrid({
    required this.pairsGridType,
    required this.onLoadingFinished,
    super.key,
  });

  @override
  State<PairsGrid> createState() => _PairsGridState();
}

class _PairsGridState extends State<PairsGrid> {
  var _wasLoaded = false;
  late final List<String> _loadingsList;

  @override
  void initState() {
    super.initState();

    _loadingsList = [];
  }

  void _initializeLoadingsMap(List<CardEntity> cards) {
    _loadingsList.addAll(List.of(cards.map((e) => e.imagePath)));
  }

  int _minRowCount() => switch (widget.pairsGridType) {
        PairsGridType.threeXFour => 4,
        PairsGridType.fourXFour => 4,
        PairsGridType.fourXFive => 5,
        PairsGridType.fourXSix => 6,
        PairsGridType.fourXSeven => 7,
        PairsGridType.sixXSix => 6,
      };

  int _crossAxisCount() => switch (widget.pairsGridType) {
        PairsGridType.threeXFour => 3,
        PairsGridType.sixXSix => 6,
        _ => 4,
      };

  void _onImageLoaded(String imagePath) {
    _loadingsList.removeWhere((e) => e == imagePath);

    if (_loadingsList.isEmpty && !_wasLoaded) {
      _wasLoaded = true;
      widget.onLoadingFinished();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PairsCubit, PairsState>(
          listener: (_, state) => _initializeLoadingsMap(state.allCards),
          listenWhen: (prev, curr) =>
              prev.allCards.isEmpty && curr.allCards.isNotEmpty,
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            for (var rowIndex = 0; rowIndex < _minRowCount(); rowIndex++)
              Expanded(
                child: Row(
                  children: <Widget>[
                    for (var eIndex = 0; eIndex < _crossAxisCount(); eIndex++)
                      Expanded(
                        child: Builder(builder: (context) {
                          return PairsCard(
                            onImageLoaded: (imagePath) => _onImageLoaded(
                              imagePath,
                            ),
                            onCardFlipped: (card) {
                              context.read<PairsCubit>().updateCardFlipStatus(
                                    card,
                                  );
                            },
                            cardIndex: rowIndex * _crossAxisCount() + eIndex,
                          );
                        }),
                      ),
                  ].insertBetween(const SizedBox(width: 4)),
                ),
              ),
          ].insertBetween(const SizedBox(height: 4)),
        ),
      ),
    );
  }
}
