import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/application/comment/comment_bloc.dart';
import 'package:management_portal/injections.dart';
import 'package:management_portal/presentation/widgets/custom_error_widget.dart';
import 'package:management_portal/presentation/widgets/responsive.dart';

import 'comment_list_widget.dart';

class CommentWidget extends StatelessWidget {
  final int id;
  const CommentWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final CommentBloc bloc = getIt<CommentBloc>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: const Radius.circular(10),
          topRight: Responsive.isDesktop(context) ? const Radius.circular(10) : Radius.zero,
          bottomLeft: Responsive.isDesktop(context) ? Radius.zero : const Radius.circular(10),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: BlocProvider(
        create: (context) => bloc..add(GetCommentsEvent(id: id)),
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentLoadedState) {
              return state.comments.isEmpty ? Center(
                child: Responsive.isDesktop(context) ? ListView(
                    shrinkWrap: true,
                    children: const [
                      Text('No comments found'),
                    ]
                ) : const Text('No comments found'),
              ) : ListView.builder(
                  physics: Responsive.isDesktop(context) ? null : const NeverScrollableScrollPhysics(),
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    return CommentListWidget(comment: state.comments[index]);
                  });

            } else if (state is CommentErrorState) {
              return Center(
                child: Responsive.isDesktop(context) ? ListView(
                    shrinkWrap: true,
                    children: [
                      CustomErrorWidget(onRetry: () => bloc..add(GetCommentsEvent(id: id))),
                    ]
                ) : CustomErrorWidget(onRetry: () => bloc..add(GetCommentsEvent(id: id))),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}