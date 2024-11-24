import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/context_dimensions_ext.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/buttons/main_button.dart';

final class AppInfoDialog extends StatelessWidget {
  final String title;
  final String? message;

  final VoidCallback? onPrimaryTap;
  final VoidCallback? onSecondaryTap;

  final String? primaryText;
  final String? secondaryText;

  final bool needShowSecondaryButton;

  final DialogType dialogType;

  const AppInfoDialog({
    required this.title,
    this.dialogType = DialogType.info,
    this.message,
    this.onPrimaryTap,
    this.onSecondaryTap,
    this.primaryText,
    this.secondaryText,
    this.needShowSecondaryButton = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: context.availableWidth * 0.8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              color: context.appTheme.contrastTextColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    switch (dialogType) {
                      DialogType.info => AppAssets.infoIcon,
                      DialogType.error => AppAssets.errorIcon,
                    },
                    width: 50.r,
                    height: 50.r,
                    colorFilter: ColorFilter.mode(
                      switch (dialogType) {
                        DialogType.info => context.appTheme.activeElementColor,
                        DialogType.error => context.appTheme.errorColor,
                      },
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      message!,
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineMedium,
                    ),
                  ],
                  const SizedBox(height: 32),
                  MainButton.widget(
                    onTap: onPrimaryTap ?? () => Navigator.pop(context),
                    needExpandWidth: true,
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.transparent,
                    child: Text(
                      primaryText ?? 'Ok',
                      textAlign: TextAlign.center,
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (needShowSecondaryButton) ...[
                    const SizedBox(height: 12),
                    MainButton.widget(
                      onTap: onSecondaryTap ?? () => Navigator.pop(context),
                      needExpandWidth: true,
                      padding: const EdgeInsets.all(8),
                      backgroundColor: Colors.transparent,
                      child: Text(
                        secondaryText ?? 'Cancel',
                        textAlign: TextAlign.center,
                        style: context.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum DialogType { info, error }
