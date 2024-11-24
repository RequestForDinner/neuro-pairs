import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.dart';
import 'package:neuro_pairs/presentation/app/navigation/app_router.gr.dart';
import 'package:neuro_pairs/presentation/pages/settings/cubit/settings_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/sounds_and_effects_service.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/user_avatar.dart';

final class SettingsUserButton extends StatefulWidget {
  const SettingsUserButton({super.key});

  @override
  State<SettingsUserButton> createState() => _SettingsUserButtonState();
}

class _SettingsUserButtonState extends State<SettingsUserButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 0,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<SettingsCubit, SettingsState, User?>(
      selector: (state) => state.user,
      builder: (context, user) {
        if (user?.uid == '-1') return const SizedBox();

        return SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: _controller,
            curve: Curves.fastOutSlowIn,
          ),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _controller,
              curve: Curves.fastOutSlowIn,
            ),
            child: MainButton.widget(
              onTap: () {
                SoundsAndEffectsService.instance.playTapSound();
                AppRouter.navigationInstance.push(const ProfileRoute());
              },
              backgroundColor: Colors.transparent,
              child: Row(
                children: [
                  UserAvatar(imagePath: user?.avatarUrl),
                  const SizedBox(width: 16),
                  if (user?.username != null && user?.email != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user!.username!,
                            style: context.textTheme.headlineLarge,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 16),
                          FittedBox(
                            child: Text(
                              user.email!,
                              style: context.textTheme.headlineSmall?.copyWith(
                                color: context.appTheme.secondaryTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(width: 16),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      color: context.appTheme.nonActiveElementColor,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: SizedBox.square(
                      dimension: 50,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: context.appTheme.primaryIconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
