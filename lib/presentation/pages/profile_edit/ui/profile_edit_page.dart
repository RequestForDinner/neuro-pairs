import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile_edit/ui/widgets/body/profile_edit_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/animated_loading_fullscreen.dart';

@RoutePage()
final class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileEditCubit>(
      create: (_) => Injector.instance.instanceOf(),
      child: Scaffold(
        body: Stack(
          children: [
            const ProfileEditBody(),
            Positioned.fill(
              child: BlocSelector<ProfileEditCubit, ProfileEditState, bool>(
                selector: (state) => state.needLoading,
                builder: (_, needLoading) {
                  return AnimatedLoadingFullscreen(needLoading: needLoading);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
