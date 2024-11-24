import 'package:flutter/cupertino.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class AppSwitch extends StatelessWidget {
  final String? text;

  final bool value;

  final ValueChanged<bool> onValueChanged;

  const AppSwitch({
    required this.value,
    required this.onValueChanged,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoSwitch(
          value: value,
          activeColor: context.appTheme.activeElementColor,
          onChanged: onValueChanged,
        ),
        if (text != null) ...[
          const SizedBox(width: 16),
          Text(
            text!,
            style: context.textTheme.headlineMedium,
          ),
        ],
      ],
    );
  }
}
