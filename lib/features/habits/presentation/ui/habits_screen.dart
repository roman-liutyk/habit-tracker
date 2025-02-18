import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';
import 'package:habit_tracker/features/habits/presentation/bloc/habits/habits_bloc.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final groupId = ModalRoute.of(context)!.settings.arguments as int;

    return BlocProvider(
      create: (context) => HabitsBloc(
        habitsRepository: context.read<HabitsRepository>(),
      )..add(
          FetchHabitsEvent(
            groupId: groupId,
          ),
        ),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<HabitsBloc, HabitsState>(
              builder: (context, state) {
                if (state is HabitsIdle) {
                  return ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.habits[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Checkbox(
                              value: state.habits[index].completed,
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: state.habits.length,
                  );
                } else if (state is HabitsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ColoredBox(color: Colors.red);
                }
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(
              Icons.add_rounded,
            ),
            onPressed: () {},
          ),
        );
      }),
    );
  }
}
