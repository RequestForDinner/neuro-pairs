import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/charts_date_handler.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class ProfileGamesWeekChart extends StatefulWidget {
  final List<MapEntry<int, int>> chartData;

  const ProfileGamesWeekChart({required this.chartData, super.key});

  @override
  State<ProfileGamesWeekChart> createState() => _ProfileGamesWeekChartState();
}

class _ProfileGamesWeekChartState extends State<ProfileGamesWeekChart>
    with SingleTickerProviderStateMixin {
  late final AnimationController _tooltipController;

  Offset? _barTouchPosition;
  String? _tooltipMessage;
  late final double _maxChartValue;
  late final bool _chartHasData;

  @override
  void initState() {
    super.initState();

    _tooltipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _maxChartValue = _maxYValue();
    _chartHasData = _chartHasDaysData();
  }

  bool _chartHasDaysData() {
    return widget.chartData.any((entry) => entry.value != 0);
  }

  double _maxYValue() {
    if (widget.chartData.isEmpty) return 1;

    final expandedChartData = widget.chartData.map((e) => e.value);

    return expandedChartData.max.toDouble();
  }

  List<BarChartGroupData> _barChartGroupData(BuildContext context) {
    if (widget.chartData.isEmpty) return [];

    return List.generate(
      7,
      (index) => BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            width: 16,
            toY: widget.chartData[index].value.toDouble(),
            color: context.appTheme.activeElementColor,
          ),
        ],
      ),
    ).reversed.toList();
  }

  void _animateTooltip([String? tooltipMessage, Offset? position]) {
    if (tooltipMessage == null) {
      _tooltipController.reverse().whenComplete(
            () => setState(() {
              _barTouchPosition = null;
              _tooltipMessage = null;
            }),
          );
    } else {
      if (_barTouchPosition != null) return;

      setState(() {
        _barTouchPosition = position;
        _tooltipMessage = tooltipMessage;
      });

      _tooltipController.forward();
    }
  }

  @override
  void dispose() {
    _tooltipController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 150),
          child: OverflowBox(
            minHeight: 150,
            maxHeight: 170,
            child: Listener(
              onPointerUp: (_) => _animateTooltip(),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: BarChart(
                      swapAnimationDuration: const Duration(milliseconds: 400),
                      BarChartData(
                        barGroups: _barChartGroupData(context),
                        gridData: const FlGridData(show: false),
                        maxY: _maxYValue(),
                        borderData: FlBorderData(show: false),
                        titlesData: FlTitlesData(
                          topTitles: const AxisTitles(),
                          rightTitles: const AxisTitles(),
                          leftTitles: const AxisTitles(),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30.w,
                              getTitlesWidget: (dayNumber, titleMeta) => Text(
                                ChartsDateHandler.weekDayName(
                                  context,
                                  dayNumber.toInt(),
                                ),
                                style: context.textTheme.headlineSmall,
                              ),
                            ),
                          ),
                        ),
                        barTouchData: BarTouchData(
                          enabled: false,
                          touchCallback: (event, response) {
                            if (event.localPosition != null) {
                              final tooltipMessage =
                                  response?.spot?.touchedRodData.toY;

                              if (tooltipMessage == null) return;

                              final offset = tooltipMessage == _maxChartValue
                                  ? response?.spot?.offset
                                  : Offset(
                                      response?.spot?.offset.dx ?? 0,
                                      (response?.spot?.offset.dy ?? 0) - 8,
                                    );

                              _animateTooltip(
                                '${tooltipMessage.round()}',
                                offset,
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  if (_barTouchPosition != null)
                    Positioned(
                      left: _barTouchPosition!.dx + 16,
                      top: _barTouchPosition!.dy,
                      child: ScaleTransition(
                        scale: CurvedAnimation(
                          parent: _tooltipController,
                          curve: Curves.fastOutSlowIn,
                        ),
                        child: _ChartTooltip(message: _tooltipMessage ?? ''),
                      ),
                    ),
                  if (!_chartHasData)
                    Align(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.infoIcon),
                            const SizedBox(height: 8),
                            Text(
                              context.locale.noWeekDataStatistic,
                              style: context.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

final class _ChartTooltip extends StatelessWidget {
  final String message;

  const _ChartTooltip({required this.message});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          message,
          style: context.textTheme.headlineSmall?.copyWith(
            color: context.appTheme.contrastTextColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
