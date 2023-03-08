import 'package:flutter/material.dart';

import '../widgets/main_nav.dart';
import '../widgets/responsive.dart';
import 'widgets/comment_widget.dart';
import 'widgets/post_widget.dart';

class PostDetailScreen extends StatelessWidget {
  final int id;
  const PostDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MainNav(
      child: Responsive.isDesktop(context) ? IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: PostWidget(id: id),
            ),
            const SizedBox(width: 1),
            Expanded(
              flex: 3,
              child: CommentWidget(id: id),
            )
          ],
        ),
      ) : ListView(
        shrinkWrap: true,
        children: [
          PostWidget(id: id),
          const SizedBox(height: 1),
          CommentWidget(id: id),
        ],
      ),
    );
  }
}
