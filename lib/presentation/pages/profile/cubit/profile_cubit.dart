import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/statistic/statistic.dart';
import 'package:neuro_pairs/domain/entities/user/user.dart';
import 'package:neuro_pairs/domain/interactors/user/profile_interactor.dart';
import 'package:neuro_pairs/domain/logic/statistic_calculator.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileInteractor _profileInteractor;

  ProfileCubit(this._profileInteractor) : super(const ProfileState()) {
    _initPage();
  }

  StreamSubscription<User?>? _userSubscription;
  StreamSubscription<Statistic>? _statisticSubscription;

  @override
  Future<void> close() async {
    await _unsubscribeUserStream();
    await _unsubscribeStatisticStream();

    return super.close();
  }

  Future<void> signOut() => _profileInteractor.signOut();

  Future<void> _initPage() async {
    await _subscribeUserStream();
    await _subscribeStatisticStream();
  }

  Future<void> _subscribeStatisticStream() async {
    await _unsubscribeStatisticStream();

    _statisticSubscription = _profileInteractor.statisticStream.listen(
      _onNewStatistic,
    );
  }

  Future<void> _unsubscribeStatisticStream() async {
    await _statisticSubscription?.cancel();
    _statisticSubscription = null;
  }

  Future<void> _onNewStatistic(Statistic statistic) async {
    final calculator = StatisticCalculator(
      gamesUnits: statistic.gamesStatisticUnits,
    );

    final lastWeekStatistic = await calculator.calculateLastWeekStatistic();

    emit(
      state.copyWith(
        statistic: statistic,
        summarySecondsInGame: lastWeekStatistic.summarySecondsInGames,
        summaryGamesAmount: lastWeekStatistic.summaryGamesAmount,
        lastWeekGamesAmount: lastWeekStatistic.gamesAmountPerDay,
      ),
    );
  }

  Future<void> _subscribeUserStream() async {
    await _unsubscribeUserStream();

    _userSubscription = _profileInteractor.userStream.listen(_onNewUser);
  }

  Future<void> _unsubscribeUserStream() async {
    await _userSubscription?.cancel();
    _userSubscription = null;
  }

  void _onNewUser(User? user) {
    if (user == null) return;

    emit(
      state.copyWith(user: user),
    );
  }
}
