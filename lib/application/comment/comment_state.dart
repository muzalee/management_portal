part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoadedState extends CommentState{
  final List<Comment> comments;

  CommentLoadedState({required this.comments});
}

class CommentErrorState extends CommentState{}
