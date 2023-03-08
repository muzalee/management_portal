part of 'update_post_bloc.dart';

@immutable
abstract class UpdatePostEvent {}

class CreateEvent extends UpdatePostEvent {
  final String title;
  final String body;
  CreateEvent({required this.title, required this.body});
}

class UpdateEvent extends UpdatePostEvent {
  final int id;
  final String title;
  final String body;
  UpdateEvent({required this.id, required this.title, required this.body});
}