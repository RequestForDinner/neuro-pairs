import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/app_switch.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_child_dialog.dart';

final class SettingsSoundsSelector extends StatelessWidget {
  final ValueChanged<bool> onEffectsChanged;
  final ValueChanged<bool> onSoundsChanged;

  final bool soundsInApp;
  final bool vibrationInApp;

  const SettingsSoundsSelector({
    required this.onEffectsChanged,
    required this.onSoundsChanged,
    required this.soundsInApp,
    required this.vibrationInApp,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppChildDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.sounds,
                width: 36,
                height: 36,
                colorFilter: ColorFilter.mode(
                  context.appTheme.primaryIconColor,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                'Sounds & Effects',
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppSwitch(
                value: soundsInApp,
                onValueChanged: onSoundsChanged,
                text: 'Sounds',
              ),
              AppSwitch(
                value: vibrationInApp,
                onValueChanged: onEffectsChanged,
                text: 'Tactile effects',
              ),
            ].insertBetween(
              const SizedBox(height: 16),
            ),
          ),
        ],
      ),
    );
  }
}
