part of 'post_detail_bloc.dart';

@immutable
abstract class PostDetailEvent {}

class GetPostEvent extends PostDetailEvent {
  final int id;
  GetPostEvent({required this.id});
}