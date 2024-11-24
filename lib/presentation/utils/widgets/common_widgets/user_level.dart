import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class UserLevel extends StatelessWidget {
  final int level;

  const UserLevel({required this.level, super.key});

  String _levelAsset() {
    const levelsAssetsFolder = 'assets/raw/levels/';

    return switch (level) {
      <= 4 => '${levelsAssetsFolder}0-4_level.png',
      <= 9 => '${levelsAssetsFolder}5-9_level.png',
      <= 14 => '${levelsAssetsFolder}10-14_level.png',
      <= 19 => '${levelsAssetsFolder}15-19_level.png',
      == 20 => '${levelsAssetsFolder}20_level.png',
      _ => throw UnimplementedError(),
    };
  }

  Size get _levelMedalSize => switch (level) {
        <= 9 => const Size(40, 40),
        <= 20 => const Size(60, 40),
        _ => throw UnimplementedError(),
      };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _levelMedalSize.width,
      height: _levelMedalSize.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(_levelAsset(), fit: BoxFit.fill),
          Text(
            level.toString(),
            style: context.textTheme.headlineSmall?.copyWith(
              color: context.appTheme.contrastTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
