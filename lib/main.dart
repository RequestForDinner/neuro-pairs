import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:neuro_pairs/firebase_options.dart';
import 'package:neuro_pairs/presentation/app/app.dart';
import 'package:neuro_pairs/presentation/app/di/injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Injector.instance.injectDependencies();

  runApp(const App());
}
