import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/cubit/pairs_settings_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs_settings/ui/widgets/bodies/pairs_settings_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/transitioned_body.dart';

@RoutePage()
final class PairsSettingsPage extends StatelessWidget {
  const PairsSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PairsSettingsCubit>(
      create: (_) => Injector.instance.instanceOf<PairsSettingsCubit>(),
      child: const Scaffold(
        body: TransitionedBody(child: PairsSettingsBody()),
      ),
    );
  }
}
