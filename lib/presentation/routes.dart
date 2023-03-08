import 'package:flutter/material.dart';

import 'post/post_screen.dart';
import 'post_detail/post_detail_screen.dart';

enum Routes { posts, postDetail }

class _Paths {
  static const String posts = '/';
  static const String postDetail = '/post-detail';

  static const Map<Routes, String> _pathMap = {
    Routes.posts: _Paths.posts,
    Routes.postDetail: _Paths.postDetail,
  };

  static String of(Routes route) => _pathMap[route] ?? '';
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case _Paths.postDetail:
        final postId = settings.arguments as int;

        return MaterialPageRoute(
            builder: (BuildContext context) => PostDetailScreen(id: postId));
      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const PostScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}