import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/cubit/pairs_settings_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class PairsGridSelector extends StatefulWidget {
  const PairsGridSelector({super.key});

  @override
  State<PairsGridSelector> createState() => _PairsGridSelectorState();
}

class _PairsGridSelectorState extends State<PairsGridSelector> {
  void _selectGridType(BuildContext context, PairsGridType gridType) {
    SoundsAndEffectsService.instance.playTapSound();
    context.read<PairsSettingsCubit>().updatePairsSettings(gridType: gridType);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PairsSettingsCubit, PairsSettingsState, PairsGridType>(
      selector: (state) => state.pairsSettings.gridType,
      builder: (context, selectedGridType) {
        final typesLength = PairsGridType.values.length;

        return Column(
          children: <Widget>[
            for (var i = 0; i < typesLength; i += 2)
              Row(
                children: <Widget>[
                  _Selector(
                    gridType: PairsGridType.values[i],
                    selectedGridType: selectedGridType,
                    onGridTypeChanged: (gridType) => _selectGridType(
                      context,
                      gridType,
                    ),
                  ),
                  if (i + 1 < typesLength)
                    _Selector(
                      gridType: PairsGridType.values[i + 1],
                      selectedGridType: selectedGridType,
                      onGridTypeChanged: (gridType) => _selectGridType(
                        context,
                        gridType,
                      ),
                    ),
                ].insertBetween(const SizedBox(width: 16)),
              ),
          ].insertBetween(const SizedBox(height: 16)),
        );
      },
    );
  }
}

final class _Selector extends StatelessWidget {
  final PairsGridType gridType;
  final PairsGridType selectedGridType;

  final ValueChanged<PairsGridType> onGridTypeChanged;

  const _Selector({
    required this.gridType,
    required this.selectedGridType,
    required this.onGridTypeChanged,
  });

  String _gridNameByType() {
    return switch (gridType) {
      PairsGridType.threeXFour => '3X4',
      PairsGridType.fourXFour => '4X4',
      PairsGridType.fourXFive => '4X5',
      PairsGridType.fourXSix => '4X6',
      PairsGridType.fourXSeven => '4X7',
      PairsGridType.sixXSix => '6X6',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MainButton.widget(
        padding: EdgeInsets.zero,
        onTap: () => onGridTypeChanged(gridType),
        child: SizedBox(
          height: 100,
          child: Stack(
            children: [
              DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Center(
                    child: Text(
                      _gridNameByType(),
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: context.appTheme.activeElementColor,
                      ),
                    ),
                  ),
                ),
              ),
              Checkbox(
                value: selectedGridType == gridType,
                activeColor: context.appTheme.activeElementColor,
                checkColor: context.appTheme.contrastIconColor,
                overlayColor: WidgetStatePropertyAll<Color>(
                  context.appTheme.activeElementColor.withOpacity(0.5),
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                onChanged: (_) => onGridTypeChanged(gridType),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
