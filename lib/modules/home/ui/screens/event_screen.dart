import 'package:event_app/configs/theme/theme.dart';
import 'package:event_app/modules/home/service/cubit/event/event_cubit.dart';
import 'package:event_app/modules/home/ui/widgets/personalized_event_list_widget.dart';
import 'package:event_app/modules/home/ui/widgets/trending_event_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventCubit(),
      child: const EventScreenBody(),
    );
  }
}

class EventScreenBody extends StatefulWidget {
  const EventScreenBody({Key? key}) : super(key: key);

  @override
  _EventScreenBodyState createState() => _EventScreenBodyState();
}

class _EventScreenBodyState extends State<EventScreenBody> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Southampton'),
            elevation: 2.0,
            bottom: TabBar(
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              labelStyle: AppTheme.testStyle1,
              unselectedLabelStyle: AppTheme.testStyle2,
              tabs: const [
                Tab(text: "FOR YOU"),
                Tab(text: "TRENDING"),
              ],
            ),
          ),
          backgroundColor: AppTheme.scaffoldBodyColor,
          body: const TabBarView(
            children: [
              PersonalizedEventListWidget(),
              TrendingEventListWidget(),
            ],
          )),
    );
  }
}
