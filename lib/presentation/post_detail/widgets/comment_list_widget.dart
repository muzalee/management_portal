import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:management_portal/core/color_const.dart';
import 'package:management_portal/domain/entities/comment.dart';

class CommentListWidget extends StatelessWidget {
  final Comment comment;
  const CommentListWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(CupertinoIcons.person_alt_circle_fill, color: ColorConst.primary),
          const SizedBox(width: 5),
          Expanded(
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: ColorConst.tertiary,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(comment.email, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 2),
                    Text(comment.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    const SizedBox(height: 5),
                    Text(comment.body, style: const TextStyle(fontSize: 14)),
                  ],
                )
            ),
          ),
        ],
      ),
    );
  }
}