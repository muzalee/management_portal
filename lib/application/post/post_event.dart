part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class GetPostsEvent extends PostEvent {}

class SearchPostEvent extends PostEvent {
  final String query;
  SearchPostEvent({required this.query});
}

class SortPostEvent extends PostEvent {
  final int sortColumnIndex;
  final bool sortAscending;
  SortPostEvent({required this.sortColumnIndex, required this.sortAscending});
}

class DeletePostEvent extends PostEvent {
  final int id;
  final BuildContext context;
  DeletePostEvent({required this.id, required this.context});
}

class AddPostEvent extends PostEvent {
  final Post post;
  AddPostEvent({required this.post});
}

class EditPostEvent extends PostEvent {
  final Post post;
  EditPostEvent({required this.post});
}