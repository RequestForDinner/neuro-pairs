import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neuro_pairs/domain/entities/pairs/pairs_game.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';
import 'package:neuro_pairs/presentation/pages/pairs/cubit/pairs_cubit.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/bodies/pairs_body.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/bodies/pairs_end_finish_body.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/bodies/pairs_loading_body.dart';
import 'package:neuro_pairs/presentation/pages/pairs/ui/widgets/bodies/pairs_lost_finish_body.dart';

@RoutePage()
final class PairsPage extends StatefulWidget {
  final PairsGame pairsGame;

  const PairsPage({required this.pairsGame, super.key});

  @override
  State<PairsPage> createState() => _PairsPageState();
}

class _PairsPageState extends State<PairsPage> {
  void _delayedLoadingPass(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        if (context.mounted) {
          context.read<PairsCubit>().updatePageLoading(
                needLoading: false,
                needFlipAllBack: true,
              );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PairsCubit>(
      create: (_) => Injector.instance.instanceOf<PairsCubit>()
        ..uploadPairsGame(widget.pairsGame),
      child: Builder(builder: (context) {
        return Scaffold(
          body: Stack(
            children: [
              PairsBody(
                onImagesLoaded: () => _delayedLoadingPass(context),
              ),
              BlocSelector<PairsCubit, PairsState, bool>(
                selector: (state) => state.pageLoading,
                builder: (context, pageLoading) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.fastOutSlowIn,
                    switchOutCurve: Curves.fastOutSlowIn,
                    child: pageLoading ? const PairsLoadingBody() : null,
                  );
                },
              ),
              BlocSelector<PairsCubit, PairsState, bool>(
                selector: (state) => state.needShowEndFinishBody,
                builder: (context, needShowEndFinishBody) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.fastOutSlowIn,
                    switchOutCurve: Curves.fastOutSlowIn,
                    child: needShowEndFinishBody
                        ? const PairsEndFinishBody()
                        : null,
                  );
                },
              ),
              BlocSelector<PairsCubit, PairsState, bool>(
                selector: (state) => state.needShowLostFinishBody,
                builder: (context, needShowEndFinishBody) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    switchInCurve: Curves.fastOutSlowIn,
                    switchOutCurve: Curves.fastOutSlowIn,
                    child: needShowEndFinishBody
                        ? const PairsLostFinishBody()
                        : null,
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
