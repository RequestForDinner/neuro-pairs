import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/profile/cubit/profile_cubit.dart';
import 'package:neuro_pairs/presentation/pages/profile/ui/widgets/profile_button.dart';
import 'package:neuro_pairs/presentation/pages/profile/ui/widgets/profile_statistic_block.dart';
import 'package:neuro_pairs/presentation/pages/profile/ui/widgets/profile_user_card.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_localization_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/animated_widgets/transitioned_body.dart';
import 'package:neuro_pairs/presentation/utils/widgets/app_bar/custom_app_bar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/horizontal_insets.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_info_dialog.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  Future<void> _showExitDialog(BuildContext pageContext) {
    return showCupertinoDialog(
      context: pageContext,
      builder: (context) {
        return AppInfoDialog(
          title: context.locale.exitFromAccountMessage,
          onPrimaryTap: pageContext.read<ProfileCubit>().signOut,
        );
      },
    );
  }

  Future<void> _showDeleteDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return AppInfoDialog(
          title: context.locale.deleteAccountMessage,
          onPrimaryTap: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBar(
          onLeadingTap: AppRouter.navigationInstance.maybePop,
          leadingIcon: Icons.arrow_back_ios_new,
          titleText: 'Profile',
        ),
        BlocSelector<ProfileCubit, ProfileState, (User?, Statistic?)>(
          selector: (state) => (state.user, state.statistic),
          builder: (context, params) {
            final user = params.$1;
            final statistic = params.$2;

            if (user == null || statistic == null) return const SizedBox();

            return Expanded(
              child: TransitionedBody(
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    ProfileUserCard(
                      user: user,
                      statistic: statistic,
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      endIndent: 16,
                      indent: 16,
                      color: context.appTheme.nonActiveElementColor,
                      height: 0,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ProfileStatisticBlock(),
                            // const SizedBox(height: 32),
                            // const ProfileAchievementsBlock(),
                            const SizedBox(height: 32),
                            HorizontalInsets(
                              child: Column(
                                children: <Widget>[
                                  ProfileButton(
                                    onTap: () =>
                                        AppRouter.navigationInstance.push(
                                      const ProfileEditRoute(),
                                    ),
                                    buttonText: context.locale.editProfile,
                                    iconPath: AppAssets.edit,
                                  ),
                                  ProfileButton(
                                    onTap: () => _showExitDialog(context),
                                    buttonText: context.locale.exitFromAccount,
                                    iconPath: AppAssets.exit,
                                  ),
                                  ProfileButton(
                                    onTap: () => _showDeleteDialog(context),
                                    buttonText: context.locale.deleteAccount,
                                    iconColor: Colors.red,
                                    iconPath: AppAssets.trash,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: context.viewPaddingOf.bottom),
                          ],
                        ),
                      ),
                    ),
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
