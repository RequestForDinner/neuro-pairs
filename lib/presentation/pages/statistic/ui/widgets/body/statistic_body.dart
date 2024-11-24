import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/logic/statistic_calculator.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/pages/statistic/cubit/statistic_cubit.dart';
import 'package:neuro_pairs/presentation/pages/statistic/ui/widgets/body/statistic_common_body.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/transitioned_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/app_bar/custom_app_bar.dart';

final class StatisticBody extends StatelessWidget {
  const StatisticBody({super.key});

  @override
  Widget build(BuildContext context) {
    return TransitionedBody(
      child: Column(
        children: [
          CustomAppBar(
            onLeadingTap: AppRouter.navigationInstance.maybePop,
            leadingIcon: Icons.arrow_back_ios_new,
            titleText: 'Statistic',
          ),
          const SizedBox(height: 16),
          const Expanded(
            child: _StatisticTabBarView(),
          ),
        ],
      ),
    );
  }
}

final class _StatisticTabBarView extends StatefulWidget {
  const _StatisticTabBarView();

  @override
  State<_StatisticTabBarView> createState() => _StatisticTabBarViewState();
}

class _StatisticTabBarViewState extends State<_StatisticTabBarView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<StatisticCubit, StatisticState, SummaryStatistic?>(
      selector: (state) => state.summaryStatistic,
      builder: (context, statistic) {
        if (statistic == null) return const SizedBox();

        return TransitionedBody(
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                indicator: CircleTabIndicator(
                  color: context.appTheme.activeElementColor,
                  radius: 8,
                ),
                tabs: const [
                  Tab(text: 'Common'),
                  Tab(text: 'Spesific'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    const StatisticCommonBody(),
                    Column(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CircleTabIndicator extends Decoration {
  final BoxPainter _painter;

  CircleTabIndicator({required Color color, required double radius})
      : _painter = _CirclePainter(color, radius);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _painter;
  }
}

final class _CirclePainter extends BoxPainter {
  final Paint _paint;
  final double radius;

  _CirclePainter(Color color, this.radius)
      : _paint = Paint()
          ..color = color
          ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final Offset circleOffset = offset + Offset(-16, cfg.size!.height / 2);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
