part of 'comment_bloc.dart';

@immutable
abstract class CommentEvent {}

class GetCommentsEvent extends CommentEvent {
  final int id;
  GetCommentsEvent({required this.id});
}