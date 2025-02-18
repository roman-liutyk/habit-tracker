import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_tracker/features/groups/domain/repository/groups_repository.dart';
import 'package:habit_tracker/features/groups/presentation/blocs/groups/groups_bloc.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupsBloc(
        groupsRepository: context.read<GroupsRepository>(),
      )..add(const FetchGroupsEvent()),
      child: Builder(builder: (context) {
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<GroupsBloc, GroupsState>(
              builder: (context, state) {
                if (state is GroupsIdle) {
                  return ListView.separated(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              state.groups[index].name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: state.groups.length,
                  );
                } else if (state is GroupsLoading) {
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
