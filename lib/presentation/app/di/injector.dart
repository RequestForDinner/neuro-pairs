import 'package:neuro_pairs/presentation/app/di/cubits_injector.dart';
import 'package:neuro_pairs/presentation/app/di/data_sources_injector.dart';
import 'package:neuro_pairs/presentation/app/di/interactors_injector.dart';
import 'package:neuro_pairs/presentation/app/di/nav_guards_injector.dart';
import 'package:neuro_pairs/presentation/app/di/platform_injector.dart';
import 'package:neuro_pairs/presentation/app/di/repositories_injector.dart';

final class Injector {
  static final Injector _instance = Injector._();

  static Injector get instance => _instance;

  Injector._();

  static final _injectedInstances = <_ObjectInstance<Object>>{};

  Future<void> injectDependencies() async {
    await injectDataSources();
    injectRepositories();
    injectInteractors();
    injectNavigationGuards();
    injectPlatformClients();
    injectCubits();
  }

  void injectFactory<T extends Object>(
    T Function() factory, {
    String? instanceName,
  }) {
    final instanceObj = _ObjectInstance<T>(
      instanceType: T,
      instanceFunction: factory,
      uniqueName: instanceName,
    );

    _injectedInstances.add(instanceObj);
  }

  void injectSingleton<T extends Object>(
    T instance, {
    String? instanceName,
  }) {
    final instanceObj = _ObjectInstance<T>(
      instanceType: T,
      instance: instance,
      uniqueName: instanceName,
    );

    _injectedInstances.add(instanceObj);
  }

  T instanceOf<T extends Object>({String? instanceName}) {
    try {
      final instance = _injectedInstances.firstWhere(
        (obj) {
          if (instanceName != null) {
            return obj.uniqueName == instanceName && obj.instanceType == T;
          }

          return obj.instanceType == T;
        },
      );

      if (instance.instanceFunction != null) {
        return instance.instanceFunction!.call() as T;
      }

      return instance.instance! as T;
    } catch (_) {
      throw UnimplementedError('Subtype of type $T has not been injected');
    }
  }
}

final class _ObjectInstance<T> {
  final Type instanceType;

  final T? instance;
  final T Function()? instanceFunction;
  final String? uniqueName;

  _ObjectInstance({
    required this.instanceType,
    this.instance,
    this.instanceFunction,
    this.uniqueName,
  });
}
