import 'package:event_app/modules/home/service/cubit/event/event_cubit.dart';
import 'package:event_app/modules/home/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalizedEventListWidget extends StatefulWidget {
  const PersonalizedEventListWidget({Key? key}) : super(key: key);

  @override
  State<PersonalizedEventListWidget> createState() =>
      _PersonalizedEventListWidgetState();
}

class _PersonalizedEventListWidgetState
    extends State<PersonalizedEventListWidget> {
  @override
  void initState() {
    BlocProvider.of<EventCubit>(context).getPersonalizedEvent(true);
    super.initState();
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<EventCubit>(context).getPersonalizedEvent(true);
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<EventCubit>(context);

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: BlocBuilder<EventCubit, EventState>(
        builder: (context, state) {
          if (state is EventsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is EventsError) {
            return Center(child: Text(state.error));
          } else if (state is EventsSuccess) {
            if (cubit.personalizedEvents.isEmpty) {
              return const Center(child: Text('No events found'));
            }

            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    scrollInfo is ScrollEndNotification) {
                  if (!cubit.personalizedEventsLoaded) {
                    cubit.getPersonalizedEvent(false);
                  }
                }
                return false;
              },
              child: ListView.separated(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: cubit.personalizedEvents.length + 1,
                itemBuilder: (context, i) {
                  if (i == cubit.personalizedEvents.length) {
                    if (cubit.personalizedEventsLoaded) {
                      return const SizedBox(height: 25);
                    }

                    return const Center(child: CircularProgressIndicator());
                  }
                  return EventWidget(cubit.personalizedEvents[i]);
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
