import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neuro_pairs/presentation/utils/constants/app_assets.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';
import 'package:neuro_pairs/presentation/utils/widgets/common_widgets/user_avatar.dart';
import 'package:neuro_pairs/presentation/utils/widgets/native/app_popup_menu.dart';

final class ProfileEditUserAvatar extends StatelessWidget {
  final ValueSetter<ImageSource> onSourcedImageUploadTap;
  final VoidCallback onRemoveImageTap;

  final String? avatarUrl;

  const ProfileEditUserAvatar({
    required this.avatarUrl,
    required this.onSourcedImageUploadTap,
    required this.onRemoveImageTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            Align(
              child: UserAvatar(
                imagePath: avatarUrl,
                dimension: 140,
              ),
            ),
            AppPopupMenu(
              buttonBackgroundColor: context.appTheme.activeElementColor,
              items: [
                AppPopupMenuItem(
                  itemText: 'Галерея',
                  icon: Icons.image_rounded,
                  onTap: () => onSourcedImageUploadTap(ImageSource.gallery),
                ),
                AppPopupMenuItem(
                  itemText: 'Камера',
                  icon: Icons.camera,
                  onTap: () => onSourcedImageUploadTap(ImageSource.camera),
                  withDivider: avatarUrl != null,
                ),
                if (avatarUrl != null)
                  AppPopupMenuItem(
                    itemText: 'Удалить фото',
                    iconAssetPath: AppAssets.trash,
                    onTap: onRemoveImageTap,
                    withDivider: false,
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
