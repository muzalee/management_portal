part of 'post_bloc.dart';

@immutable
abstract class PostState {}

class PostInitial extends PostState {}

class PostLoadedState extends PostState{
  final List<Post> posts;
  final List<Post> filteredPosts;
  final int sortColumnIndex;
  final bool sortAscending;
  final int page;
  final int limit;

  PostLoadedState({required this.posts, required this.filteredPosts, this.sortColumnIndex = 0, this.sortAscending = true, this.page = 0, this.limit = 5});
}

class PostErrorState extends PostState{}
