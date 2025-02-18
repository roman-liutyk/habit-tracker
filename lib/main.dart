import 'package:flutter/material.dart';
import 'package:habit_tracker/database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final HabitsDatabase habitsDatabase = HabitsDatabase();

  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp();
  }
}
