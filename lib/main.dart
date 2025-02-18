import 'package:flutter/material.dart';
import 'package:habit_tracker/common/di/composition_root.dart';
import 'package:habit_tracker/common/di/dependencies_container.dart';
import 'package:habit_tracker/features/groups/presentation/ui/groups_screen.dart';
import 'package:habit_tracker/features/habits/presentation/ui/habits_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final DependenciesContainer dependenciesContainer =
      await CompositionRoot().compose();

  runApp(
    Provider(
      create: (context) => dependenciesContainer,
      child: const Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => GroupsScreen(),
        '/habits': (context) => HabitsScreen(),
      },
    );
  }
}
