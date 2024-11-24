import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class StatisticCircularChart extends StatelessWidget {
  final String title;
  final Map<String, int> sectionsMap;

  const StatisticCircularChart({
    required this.title,
    required this.sectionsMap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.textTheme.titleSmall),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.2,
                  child: PieChart(
                    PieChartData(
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sections: [
                        ...List.generate(
                          sectionsMap.length,
                          (index) {
                            final sectionValue = sectionsMap.values.elementAt(
                              index,
                            );

                            return PieChartSectionData(
                              title: '$sectionValue',
                              titleStyle:
                                  context.textTheme.titleMedium?.copyWith(
                                color: context.appTheme.contrastTextColor,
                              ),
                              radius: 80,
                              color: _sectionColor(index),
                              value: sectionValue.toDouble(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    for (var index = 0; index < sectionsMap.length; index++)
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox.square(
                            dimension: 16,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _sectionColor(index),
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            sectionsMap.keys.elementAt(index),
                            style: context.textTheme.headlineMedium,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _sectionColor(int index) {
    return switch (index) {
      0 => const Color(0xFF659287),
      1 => const Color(0xFFA6B37D),
      2 => const Color(0xFFC0C78C),
      3 => const Color(0xFF86AB89),
      4 => const Color(0xFF808D7C),
      5 => const Color(0xFF5F6F65),
      _ => Colors.black38,
    };
  }
}
