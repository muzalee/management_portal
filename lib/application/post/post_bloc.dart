import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/domain/entities/post.dart';
import 'package:management_portal/infrastructure/repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(PostInitial()) {
    on<GetPostsEvent>(_onGetPosts);
    on<SearchPostEvent>(_onSearch);
    on<SortPostEvent>(_onSort);
    on<DeletePostEvent>(_onDelete);
    on<AddPostEvent>(_onAdd);
    on<EditPostEvent>(_onEdit);
  }

  Future<void> _onGetPosts(GetPostsEvent event, Emitter<PostState> emit) async {
    try {
      final List<Post> posts = await repository.getPosts(event.page, event.limit);
      emit(PostLoadedState(posts: posts, filteredPosts: posts, page: event.page, limit: event.limit));
    } catch (e) {
      emit(PostErrorState());
    }
  }

  Future<void> _onSearch(SearchPostEvent event, Emitter<PostState> emit) async {
    final currentState = state;

    if (currentState is PostLoadedState) {
      final filteredPosts = currentState.posts.where((post) =>
          post.title.toLowerCase().contains(event.query.toLowerCase()) ||
              post.body.toLowerCase().contains(event.query.toLowerCase()));

      emit(PostLoadedState(
        posts: currentState.posts,
        filteredPosts: filteredPosts.toList(),
      ));
    }
  }

  Future<void> _onSort(SortPostEvent event, Emitter<PostState> emit) async {
    final currentState = state;

    if (currentState is PostLoadedState) {
      final filteredPosts = List<Post>.from(currentState.posts)
        ..sort((a, b) {
          String? aValue, bValue;
          switch (event.sortColumnIndex) {
            case 0:
              aValue = a.title;
              bValue = b.title;
              break;
            case 1:
              aValue = a.body;
              bValue = b.body;
              break;
            default:
              return 0;
          }

          return event.sortAscending
              ? aValue.compareTo(bValue)
              : bValue.compareTo(aValue);
        });

      emit(PostLoadedState(
        posts: currentState.posts,
        filteredPosts: filteredPosts,
        sortAscending: event.sortAscending,
        sortColumnIndex: event.sortColumnIndex,
      ));
    }
  }

  Future<void> _onDelete(DeletePostEvent event, Emitter<PostState> emit) async {
    final currentState = state;

    if (currentState is PostLoadedState) {
      try {
        await repository.deletePost(event.id);
        final updatedPosts = currentState.posts.where((post) => post.id != event.id).toList();
        emit(PostLoadedState(
          posts: currentState.posts,
          filteredPosts: updatedPosts,
          sortAscending: currentState.sortAscending,
          sortColumnIndex: currentState.sortColumnIndex,
          page: 0,
        ));
        if (event.context.mounted) {
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(content: Text('Post deleted successfully.')),
          );
        }
      } catch (e) {
        log('Catch Error: $e');
      }
    }
  }

  Future<void> _onAdd(AddPostEvent event, Emitter<PostState> emit) async {
    final currentState = state;

    if (currentState is PostLoadedState) {
      final updatedPosts = [event.post, ...currentState.filteredPosts];
      emit(PostLoadedState(
        posts: currentState.posts,
        filteredPosts: updatedPosts,
        sortAscending: currentState.sortAscending,
        sortColumnIndex: currentState.sortColumnIndex,
      ));
    }
  }

  Future<void> _onEdit(EditPostEvent event, Emitter<PostState> emit) async {
    final currentState = state;

    if (currentState is PostLoadedState) {
      final int index = currentState.filteredPosts.indexWhere((element) => element.id == event.post.id);
      final updatedPosts = currentState.filteredPosts;
      updatedPosts[index] = event.post;

      emit(PostLoadedState(
        posts: currentState.posts,
        filteredPosts: updatedPosts,
        sortAscending: currentState.sortAscending,
        sortColumnIndex: currentState.sortColumnIndex,
      ));
    }
  }
}
