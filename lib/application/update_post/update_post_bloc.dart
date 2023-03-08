import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/domain/entities/post.dart';
import 'package:management_portal/infrastructure/repositories/post_repository.dart';

part 'update_post_event.dart';
part 'update_post_state.dart';

class UpdatePostBloc extends Bloc<UpdatePostEvent, UpdatePostState> {
  final PostRepository repository;

  UpdatePostBloc({required this.repository}) : super(PostInitial()) {
    on<CreateEvent>(_onCreate);
    on<UpdateEvent>(_onUpdate);
  }

  Future<void> _onCreate(CreateEvent event, Emitter<UpdatePostState> emit) async {
    emit(PostLoadingState());
    try {
      final Post post = await repository.createPost(event.title, event.body);
      emit(PostSuccessState(post: post));
    } catch (e) {
      emit(PostErrorState());
    }
  }

  Future<void> _onUpdate(UpdateEvent event, Emitter<UpdatePostState> emit) async {
    emit(PostLoadingState());
    try {
      final Post post = await repository.updatePost(event.id, event.title, event.body);
      emit(PostSuccessState(post: post));
    } catch (e) {
      emit(PostErrorState());
    }
  }
}
