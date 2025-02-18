import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/common/widgets/add_item_dialog.dart';
import 'package:habit_tracker/features/groups/domain/entity/group_entity.dart';
import 'package:habit_tracker/features/habits/domain/repository/habits_repository.dart';
import 'package:habit_tracker/features/habits/presentation/bloc/habits/habits_bloc.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = ModalRoute.of(context)!.settings.arguments as GroupEntity;

    return BlocProvider(
      create: (context) => HabitsBloc(
        habitsRepository: context.read<HabitsRepository>(),
        groupId: group.id,
      )..add(const FetchHabitsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(group.name),
          ),
          body: SafeArea(
            child: BlocBuilder<HabitsBloc, HabitsState>(
              builder: (context, state) {
                if (state is HabitsIdle) {
                  return ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              state.habits[index].title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Checkbox(
                            value: state.habits[index].completed,
                            onChanged: (value) {
                              if (value != null) {
                                context.read<HabitsBloc>().add(
                                      UpdateHabitEvent(
                                        id: state.habits[index].id,
                                        completed: value,
                                      ),
                                    );
                              }
                            },
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          IconButton(
                            onPressed: () {
                              context.read<HabitsBloc>().add(
                                    DeleteHabitEvent(
                                      id: state.habits[index].id,
                                    ),
                                  );
                            },
                            icon: Icon(
                              Icons.delete_rounded,
                            ),
                          ),
                        ],
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
            onPressed: () {
              showDialog<String?>(
                context: context,
                builder: (context) {
                  return AddItemDialog();
                },
              ).then((value) {
                if (value != null) {
                  if (context.mounted) {
                    context.read<HabitsBloc>().add(
                          AddHabitEvent(title: value),
                        );
                  }
                }
              });
            },
          ),
        );
      }),
    );
  }
}
