import 'package:code_challenge/challenge_app.dart';
import 'package:code_challenge/config/environment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/hive_flutter.dart';


globalInitializer() async {
  await dotenv.load(fileName: Environment.fileName);
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('apiCache');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await globalInitializer();
  runApp(ChallengeApp());
}



