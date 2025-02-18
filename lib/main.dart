import 'package:flutter/material.dart';
import 'package:habit_tracker/database/database.dart';
import 'package:habit_tracker/features/groups/data/data_source/groups_data_source.dart';
import 'package:habit_tracker/features/groups/data/repository/groups_repository_impl.dart';
import 'package:habit_tracker/features/groups/domain/repository/groups_repository.dart';
import 'package:habit_tracker/features/groups/presentation/ui/groups_screen.dart';
import 'package:habit_tracker/features/habits/data/data_source/habits_data_source.dart';
import 'package:habit_tracker/features/habits/data/repository/habits_repository_impl.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';
import 'package:habit_tracker/features/habits/presentation/ui/habits_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final HabitsDatabase habitsDatabase = HabitsDatabase();

  runApp(
    MultiProvider(
      providers: [
        Provider<GroupsRepository>(
          create: (context) => GroupsRepositoryImpl(
            groupsDataSource: GroupsDataSourceImpl(
              db: habitsDatabase,
            ),
          ),
        ),
        Provider<HabitsRepository>(
          create: (context) => HabitsRepositoryImpl(
            habitsDataSource: HabitsDataSourceImpl(
              db: habitsDatabase,
            ),
          ),
        ),
      ],
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
