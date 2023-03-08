import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/domain/entities/comment.dart';
import 'package:management_portal/infrastructure/repositories/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository repository;

  CommentBloc({required this.repository}) : super(CommentInitial()) {
    on<GetCommentsEvent>(_onGetComments);
  }

  Future<void> _onGetComments(GetCommentsEvent event, Emitter<CommentState> emit) async {
    try {
      final List<Comment> comments = await repository.getComments(event.id);
      emit(CommentLoadedState(comments: comments));
    } catch (e) {
      emit(CommentErrorState());
    }
  }
}