import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/pages/profile_edit/cubit/profile_edit_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile_edit/ui/widgets/profile_edit_user_avatar.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/transitioned_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/default_text_field.dart';

final class ProfileEditBody extends StatelessWidget {
  const ProfileEditBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          onLeadingTap: AppRouter.navigationInstance.maybePop,
          leadingIcon: Icons.arrow_back_ios_new,
          titleText: 'Edit profile',
        ),
        BlocSelector<ProfileEditCubit, ProfileEditState, bool>(
          selector: (state) => state.currentUser == null,
          builder: (context, needLoading) {
            if (needLoading) return const SizedBox();

            return const Expanded(
              child: TransitionedBody(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 32),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                _ProfileUserAvatar(),
                                SizedBox(height: 32),
                                _ProfileUserName(),
                                SizedBox(height: 120),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    _SaveButton(),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

final class _ProfileUserAvatar extends StatelessWidget {
  const _ProfileUserAvatar();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileEditCubit, ProfileEditState, String?>(
      selector: (state) => state.userForChanging!.avatarUrl,
      builder: (context, avatarUrl) {
        return ProfileEditUserAvatar(
          avatarUrl: avatarUrl,
          onSourcedImageUploadTap: (source) {
            context.read<ProfileEditCubit>().uploadAvatar(source);
            Navigator.pop(context);
          },
          onRemoveImageTap: () {
            context.read<ProfileEditCubit>().deleteUserImage();
            Navigator.pop(context);
          },
        );
      },
    );
  }
}

final class _ProfileUserName extends StatelessWidget {
  const _ProfileUserName();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileEditCubit, ProfileEditState, String>(
      selector: (state) => state.currentUser!.username,
      builder: (context, username) {
        return DefaultTextField(
          title: 'Имя пользователя',
          hint: 'Введите имя',
          initialValue: username,
          onChanged: context.read<ProfileEditCubit>().updateUsername,
          maxLength: 48,
        );
      },
    );
  }
}

final class _SaveButton extends StatelessWidget {
  const _SaveButton();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: BlocSelector<ProfileEditCubit, ProfileEditState, bool>(
        selector: (state) => state.currentUser != state.userForChanging,
        builder: (context, canSave) {
          return MainButton.text(
            onTap: context.read<ProfileEditCubit>().saveChanges,
            isActive: canSave,
            needExpandWidth: true,
            padding: const EdgeInsets.symmetric(vertical: 16),
            margin: EdgeInsets.only(
              left: context.availableWidth * 0.2,
              right: context.availableWidth * 0.2,
              bottom: context.viewPaddingOf.bottom + 32,
            ),
            textStyle: context.textTheme.headlineLarge?.copyWith(
              letterSpacing: 4,
              color: context.appTheme.contrastTextColor,
              fontWeight: FontWeight.bold,
            ),
            buttonText: 'Сохранить',
          );
        },
      ),
    );
  }
}
