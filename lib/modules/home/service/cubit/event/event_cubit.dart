import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/modules/home/model/event_model.dart';

import 'package:meta/meta.dart';

part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  EventCubit() : super(EventsInitial());

  int limit = 2;

  List<Event> personalizedEvents = [];
  List<Event> trendingEvents = [];

  bool personalizedEventsLoaded = false;

  QueryDocumentSnapshot<Map<String, dynamic>>? lastPersonalizedEventDoc;

  getPersonalizedEvent(bool isInitial) async {
    try {
      QuerySnapshot<Map<String, dynamic>> events;

      if (isInitial) {
        emit(EventsLoading());
        personalizedEvents.clear();
        personalizedEventsLoaded = false;

        events = await FirebaseFirestore.instance
            .collection('personalized-events')
            .limit(limit)
            .orderBy("event_name")
            .get();
      } else {
        events = await FirebaseFirestore.instance
            .collection('personalized-events')
            .orderBy("event_name")
            .limit(limit)
            .startAfter([lastPersonalizedEventDoc!.get("event_name")]).get();
      }

      if (events.docs.length < limit) {
        personalizedEventsLoaded = true;
      }

      if (events.docs.isNotEmpty) {
        lastPersonalizedEventDoc = events.docs.last;
      }

      for (var doc in events.docs) {
        personalizedEvents.add(Event.fromJson(doc.data()));
      }

      emit(EventsSuccess());
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }

  getTrendingEvent() async {
    try {
      emit(EventsLoading());

      trendingEvents.clear();

      QuerySnapshot<Map<String, dynamic>> events =
          await FirebaseFirestore.instance.collection('trending-events').get();

      for (var doc in events.docs) {
        trendingEvents.add(Event.fromJson(doc.data()));
      }

      emit(EventsSuccess());
    } catch (e) {
      emit(EventsError(e.toString()));
    }
  }
}
