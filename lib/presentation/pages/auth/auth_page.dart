import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/auth/cubit/auth_cubit.dart';
import 'package:neuro_pairs/presentation/pages/auth/widgets/bodies/auth_body.dart';

@RoutePage()
final class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Injector.instance.instanceOf<AuthCubit>(),
      child: const Scaffold(
        body: AuthBody(),
      ),
    );
  }
}
