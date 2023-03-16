import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/application/post/post_bloc.dart';
import 'package:management_portal/injections.dart';
import 'package:management_portal/presentation/widgets/custom_error_widget.dart';

import '../widgets/main_nav.dart';
import 'widgets/post_table_widget.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostBloc bloc = getIt<PostBloc>();

    return MainNav(
      child: BlocProvider(
        create: (context) => bloc..add(GetPostsEvent(page: 0, limit: 6)),
        child: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (state is PostLoadedState) ...[
                    const PostTableWidget(),
                  ] else if (state is PostErrorState) ...[
                    CustomErrorWidget(onRetry: () => bloc..add(GetPostsEvent(page: 0, limit: 6))),
                  ] else ...[
                    const Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
