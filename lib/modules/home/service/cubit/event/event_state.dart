part of 'event_cubit.dart';

@immutable
abstract class EventState {}

class EventsInitial extends EventState {}

class EventsLoading extends EventState {}

class EventsSuccess extends EventState {}

class EventsError extends EventState {
  final String error;
  EventsError(this.error);
}
