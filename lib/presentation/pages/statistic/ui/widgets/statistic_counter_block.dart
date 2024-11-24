import 'package:flutter/material.dart';
import 'package:neuro_pairs/domain/utils/extensions/list_extension.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class StatisticCounterBlock extends StatelessWidget {
  final Map<String, String> countersMap;

  const StatisticCounterBlock({required this.countersMap, super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      scrollDirection: Axis.horizontal,
      child: IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Row(
            children: <Widget>[
              for (final counterKey in countersMap.keys)
                _CounterElement(
                  title: counterKey,
                  value: countersMap[counterKey]!,
                ),
            ].insertBetween(
              VerticalDivider(
                color: context.appTheme.inactiveTextColor,
                width: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class _CounterElement extends StatelessWidget {
  final String title;
  final String value;

  const _CounterElement({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: context.textTheme.headlineLarge?.copyWith(
            color: context.appTheme.inactiveTextColor,
          ),
        ),
      ],
    );
  }
}
