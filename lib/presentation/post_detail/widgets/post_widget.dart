import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/application/post_detail/post_detail_bloc.dart';
import 'package:management_portal/core/color_const.dart';
import 'package:management_portal/injections.dart';
import 'package:management_portal/presentation/widgets/custom_error_widget.dart';
import 'package:management_portal/presentation/widgets/responsive.dart';

class PostWidget extends StatelessWidget {
  final int id;
  const PostWidget({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final PostDetailBloc bloc = getIt<PostDetailBloc>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(10),
          bottomLeft: Responsive.isDesktop(context) ? const Radius.circular(10) : Radius.zero,
          topRight: Responsive.isDesktop(context) ? Radius.zero : const Radius.circular(10),
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
        create: (context) => bloc..add(GetPostEvent(id: id)),
        child: BlocBuilder<PostDetailBloc, PostDetailState>(
          builder: (context, state) {
            if (state is PostDetailLoadedState) {
              List<Widget> widgets = [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(CupertinoIcons.bubble_left_bubble_right_fill, color: ColorConst.primary),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(state.post.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const Divider(color: Colors.black45, thickness: 0.5),
                const SizedBox(height: 10),
                Text(state.post.body, style: const TextStyle(fontSize: 14)),
              ];

              return Responsive.isDesktop(context) ? ListView(
                children: widgets,
              ) : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widgets,
              );

            } else if (state is PostDetailLoadedState) {
              return Center(
                child: Responsive.isDesktop(context) ? ListView(
                    shrinkWrap: true,
                    children: [
                      CustomErrorWidget(onRetry: () => bloc..add(GetPostEvent(id: id))),
                    ]
                ) : CustomErrorWidget(onRetry: () => bloc..add(GetPostEvent(id: id))),
              );
            }

            return const Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}