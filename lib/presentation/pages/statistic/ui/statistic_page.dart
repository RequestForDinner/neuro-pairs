import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/statistic/cubit/statistic_cubit.dart';
import 'package:neuro_pairs/presentation/pages/statistic/ui/widgets/body/statistic_body.dart';

@RoutePage()
final class StatisticPage extends StatelessWidget {
  const StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StatisticCubit>(
      create: (_) => Injector.instance.instanceOf()..initStatisticPage(),
      child: const Scaffold(
        body: StatisticBody(),
      ),
    );
  }
}
