import 'package:flutter/material.dart';
import 'package:management_portal/domain/entities/post.dart';

class PostDataTableSource extends DataTableSource {
  final BuildContext context;
  final List<Post> posts;
  final Function(int id) onDelete;
  final Function(Post post) onEdit;
  final Function(int id) onClick;
  PostDataTableSource({required this.context, required this.posts, required this.onDelete, required this.onEdit, required this.onClick});

  @override
  DataRow? getRow(int index) {
    if (index >= posts.length) {
      return null;
    }
    final post = posts[index];
    return DataRow(
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(post.title),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(post.body, overflow: TextOverflow.ellipsis, maxLines: 1),
        )),
        DataCell(
            Row(
              children: [
                InkWell(
                  onTap: () => onEdit(post),
                  child: const Icon(Icons.edit, color: Colors.blue),
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => onDelete(post.id),
                  child: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            )
        ),
      ],
      onSelectChanged: (selected) {
        onClick(post.id);
      },
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => posts.length;

  @override
  int get selectedRowCount => 0;
}