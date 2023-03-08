import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'application/comment/comment_bloc.dart';
import 'application/post/post_bloc.dart';
import 'application/post_detail/post_detail_bloc.dart';
import 'application/update_post/update_post_bloc.dart';
import 'infrastructure/repositories/comment_repository.dart';
import 'infrastructure/repositories/post_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  setupInjection();
}

void setupInjection() {
  getIt.registerLazySingleton(() => http.Client());

  getIt.registerLazySingleton(() => PostRepository(httpClient: getIt()));

  getIt.registerLazySingleton(() => CommentRepository(httpClient: getIt()));

  getIt.registerFactory(() => PostBloc(repository: getIt()));

  getIt.registerFactory(() => PostDetailBloc(repository: getIt()));

  getIt.registerFactory(() => UpdatePostBloc(repository: getIt()));

  getIt.registerFactory(() => CommentBloc(repository: getIt()));
}