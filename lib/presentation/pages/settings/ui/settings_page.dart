import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:neuro_pairs/presentation/pages/settings/ui/widgets/bodies/settings_body.dart';

@RoutePage()
final class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (_) => Injector.instance.instanceOf<SettingsCubit>(),
      child: const Scaffold(
        body: SettingsBody(),
      ),
    );
  }
}
