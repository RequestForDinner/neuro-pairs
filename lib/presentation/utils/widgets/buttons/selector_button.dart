import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class SelectorButton<T> extends StatelessWidget {
  final String? imagePath;
  final String title;
  final T unique;

  final T selectedValue;

  final ValueSetter<T> onSelected;

  const SelectorButton({
    required this.title,
    required this.unique,
    required this.selectedValue,
    required this.onSelected,
    this.imagePath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MainButton.widget(
      onTap: () {
        SoundsAndEffectsService.instance.playTapSound();
        if (selectedValue != unique) onSelected(unique);
      },
      backgroundColor: Colors.transparent,
      child: Row(
        children: [
          if (imagePath != null) ...[
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: SizedBox.square(
                dimension: 36,
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
          Text(
            title,
            style: context.textTheme.headlineLarge,
          ),
          const Spacer(),
          SizedBox.square(
            dimension: 24,
            child: Checkbox(
              value: selectedValue == unique,
              onChanged: (_) {
                if (selectedValue != unique) onSelected(unique);
              },
              activeColor: context.appTheme.activeElementColor,
              checkColor: context.appTheme.contrastIconColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
