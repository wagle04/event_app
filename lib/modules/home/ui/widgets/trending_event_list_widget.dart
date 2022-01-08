import 'package:event_app/modules/home/service/cubit/event/event_cubit.dart';
import 'package:event_app/modules/home/ui/widgets/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingEventListWidget extends StatefulWidget {
  const TrendingEventListWidget({Key? key}) : super(key: key);

  @override
  State<TrendingEventListWidget> createState() =>
      _TrendingEventListWidgetState();
}

class _TrendingEventListWidgetState extends State<TrendingEventListWidget> {
  @override
  void initState() {
    BlocProvider.of<EventCubit>(context).getTrendingEvent();
    super.initState();
  }

  Future<void> _onRefresh() async {
    BlocProvider.of<EventCubit>(context).getTrendingEvent();
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
            if (cubit.trendingEvents.isEmpty) {
              return const Center(child: Text('No events found'));
            }

            return ListView.separated(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: cubit.trendingEvents.length,
              itemBuilder: (context, i) => EventWidget(
                cubit.trendingEvents[i],
              ),
              separatorBuilder: (context, index) => const Divider(),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
