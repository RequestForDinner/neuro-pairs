part of 'profile_cubit.dart';

final class ProfileState {
  final User? user;
  final Statistic? statistic;

  final int summarySecondsInGame;
  final int summaryGamesAmount;
  final List<MapEntry<int, int>> lastWeekGamesAmount;

  const ProfileState({
    this.user,
    this.statistic,
    this.summarySecondsInGame = 0,
    this.summaryGamesAmount = 0,
    this.lastWeekGamesAmount = const [],
  });

  ProfileState copyWith({
    User? user,
    Statistic? statistic,
    int? summarySecondsInGame,
    int? summaryGamesAmount,
    List<MapEntry<int, int>>? lastWeekGamesAmount,
  }) {
    return ProfileState(
      user: user ?? this.user,
      statistic: statistic ?? this.statistic,
      summarySecondsInGame: summarySecondsInGame ?? this.summarySecondsInGame,
      summaryGamesAmount: summaryGamesAmount ?? this.summaryGamesAmount,
      lastWeekGamesAmount: lastWeekGamesAmount ?? this.lastWeekGamesAmount,
    );
  }
}
