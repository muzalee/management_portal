part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailState {}

class PostDetailInitial extends PostDetailState {}

class PostDetailLoadedState extends PostDetailState{
  final Post post;

  PostDetailLoadedState({required this.post});
}

class PostDetailErrorState extends PostDetailState{}
