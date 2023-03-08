import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/domain/entities/post.dart';
import 'package:management_portal/infrastructure/repositories/post_repository.dart';

part 'post_detail_event.dart';
part 'post_detail_state.dart';

class PostDetailBloc extends Bloc<PostDetailEvent, PostDetailState> {
  final PostRepository repository;

  PostDetailBloc({required this.repository}) : super(PostDetailInitial()) {
    on<GetPostEvent>(_onGetPost);
  }

  Future<void> _onGetPost(GetPostEvent event, Emitter<PostDetailState> emit) async {
    try {
      final Post post = await repository.getPost(event.id);
      emit(PostDetailLoadedState(post: post));
    } catch (e) {
      emit(PostDetailErrorState());
    }
  }
}