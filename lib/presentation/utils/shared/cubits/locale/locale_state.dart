part of 'locale_cubit.dart';

final class LocaleState {
  final String? currentLocaleName;

  const LocaleState({
    this.currentLocaleName,
  });

  LocaleState copyWith({
    String? currentLocaleName,
  }) {
    return LocaleState(
      currentLocaleName: currentLocaleName ?? this.currentLocaleName,
    );
  }
}
