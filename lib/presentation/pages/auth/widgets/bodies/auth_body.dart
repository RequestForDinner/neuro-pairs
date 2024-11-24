import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/pages/auth/cubit/auth_cubit.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/horizontal_insets.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/loading_shell.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_info_dialog.dart';

final class AuthBody extends StatelessWidget {
  const AuthBody({super.key});

  void _onGoogleSignInTap(BuildContext context) {
    context.read<AuthCubit>().signInWithGoogle();
  }

  Future<void> _showAuthErrorDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (_) {
        return const AppInfoDialog(
          title: 'Authentication Error',
          message: 'You can try this again at any time convenient for you',
          needShowSecondaryButton: false,
          dialogType: DialogType.error,
        );
      },
    ).whenComplete(
      () => context.read<AuthCubit>().updateAuthErrorVisibility(
            needShow: false,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (prev, curr) {
        return !prev.needShowAuthError && curr.needShowAuthError;
      },
      listener: (context, state) => _showAuthErrorDialog(context),
      builder: (context, state) {
        return LoadingShell(
          loadingCondition: state.needShowLoading,
          body: Stack(
            children: [
              const Align(
                alignment: Alignment.bottomCenter,
                child: _BackgroundImage(),
              ),
              HorizontalInsets(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.viewPaddingOf.top + 100),
                    Text(
                      'Login',
                      style: context.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Authentication will allow you to use the intended '
                      'functionality in full',
                      style: context.textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 160),
                    Row(
                      children: [
                        Expanded(
                          child: MainButton.widget(
                            onTap: () => _onGoogleSignInTap(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/vector/google.svg',
                                  width: 36.r,
                                  height: 36.r,
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  'Sign in with Google',
                                  textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.headlineLarge?.copyWith(
                                    color: context.appTheme.contrastTextColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: _BottomBlock(),
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _BackgroundImage extends StatelessWidget {
  const _BackgroundImage();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      verticalDirection: VerticalDirection.up,
      children: [
        SizedBox(
          width: context.availableWidth,
          height: context.availableHeight * 0.65,
          child: Image.asset(
            'assets/raw/auth_background_image.png',
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}

final class _BottomBlock extends StatelessWidget {
  const _BottomBlock();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0),
            Colors.black.withOpacity(0.4),
            Colors.black.withOpacity(0.6),
            Colors.black.withOpacity(0.8),
            Colors.black.withOpacity(1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: HorizontalInsets(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 120),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: context.textTheme.headlineMedium?.copyWith(
                  color: context.appTheme.contrastTextColor,
                ),
                children: [
                  const TextSpan(
                    text: 'By continuing to use the App, you agree to '
                        'the following terms: ',
                  ),
                  TextSpan(
                    text: 'Terms of Use',
                    style: context.textTheme.headlineMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: context.appTheme.contrastTextColor,
                      decorationColor: context.appTheme.contrastTextColor,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: context.textTheme.headlineMedium?.copyWith(
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                      color: context.appTheme.contrastTextColor,
                      decorationColor: context.appTheme.contrastTextColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.viewPaddingOf.bottom + 16),
          ],
        ),
      ),
    );
  }
}
