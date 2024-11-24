import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile/ui/widgets/bodies/profile_body.dart';

@RoutePage()
final class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (_) => Injector.instance.instanceOf<ProfileCubit>(),
      child: const Scaffold(
        body: ProfileBody(),
      ),
    );
  }
}
