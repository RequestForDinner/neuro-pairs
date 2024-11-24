import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neuro_pairs/presentation/utils/extensions/theme_ext.dart';

final class UserAvatar extends StatelessWidget {
  final String? imagePath;

  final double dimension;

  const UserAvatar({
    required this.imagePath,
    this.dimension = 80,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(200)),
      child: SizedBox.square(
        dimension: dimension,
        child: Builder(
          builder: (_) {
            final pathUri = Uri.tryParse(imagePath ?? '');
            final pathHasScheme = pathUri?.hasScheme ?? true;

            if (!pathHasScheme) {
              return Image.asset(
                imagePath ?? '',
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return _ErrorWidget(dimension: dimension);
                },
              );
            }

            return Image.network(
              imagePath ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => _ErrorWidget(dimension: dimension),
              loadingBuilder: (_, child, chunkEvent) {
                if (chunkEvent == null) return child;

                return _LoadingWidget(dimension: dimension);
              },
            );
          },
        ),
      ),
    );
  }
}

final class _ErrorWidget extends StatelessWidget {
  final double dimension;

  const _ErrorWidget({required this.dimension});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(200)),
        ),
        child: Icon(
          Icons.person,
          size: 50,
          color: context.appTheme.primaryIconColor,
        ),
      ),
    );
  }
}

final class _LoadingWidget extends StatelessWidget {
  final double dimension;

  const _LoadingWidget({required this.dimension});

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(200)),
        ),
        child: CupertinoActivityIndicator(
          color: context.appTheme.activeElementColor,
        ),
      ),
    );
  }
}
