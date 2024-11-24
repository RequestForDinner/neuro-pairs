import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_settings.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/pairs_categories/cubit/pairs_categories_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs_categories/ui/widgets/bodies/pairs_categories_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/transitioned_body.dart';

@RoutePage()
final class PairsCategoriesPage extends StatelessWidget {
  final PairsSettings? pairsSettings;

  const PairsCategoriesPage({required this.pairsSettings, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PairsCategoriesCubit>(
      create: (_) => Injector.instance.instanceOf<PairsCategoriesCubit>()
        ..init(pairsSettings),
      child: const Scaffold(
        body: TransitionedBody(child: PairsCategoriesBody()),
      ),
    );
  }
}
