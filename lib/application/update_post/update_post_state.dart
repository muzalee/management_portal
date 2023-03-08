part of 'update_post_bloc.dart';

@immutable
abstract class UpdatePostState {}

class PostInitial extends UpdatePostState {}

class PostLoadingState extends UpdatePostState{}

class PostErrorState extends UpdatePostState{}

class PostSuccessState extends UpdatePostState{
  final Post post;

  PostSuccessState({required this.post});
}
