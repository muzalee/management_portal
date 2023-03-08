import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/application/post/post_bloc.dart';
import 'package:management_portal/domain/entities/post.dart';
import 'package:management_portal/presentation/routes.dart';
import 'package:management_portal/presentation/widgets/dialog.dart';

import 'post_data_table_source.dart';
import 'post_form_modal.dart';

class PostTableWidget extends StatefulWidget {
  const PostTableWidget({super.key});

  @override
  State<PostTableWidget> createState() => _PostTableWidgetState();
}

class _PostTableWidgetState extends State<PostTableWidget> {
  final TextEditingController _controller = TextEditingController();
  late PostBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _searchBar(),
            _table(),
          ],
        );
      },
    );
  }

  //widget _functions
  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ), //BoxShadow
        ],
      ),
      child: TextField(
        controller: _controller,
        decoration: const InputDecoration(
          hintText: 'Search',
          prefixIcon: Icon(Icons.search, size: 20),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
        onChanged: (value) {
          _bloc.add(SearchPostEvent(query: value.trim()));
        },
      ),
    );
  }

  Widget _table() {
    final state = _bloc.state;

    return SizedBox(
      width: double.infinity,
      child: PaginatedDataTable(
        header: Row(
          children: [
            const Expanded(
              child: Text('Posts'),
            ),
            ElevatedButton(
              onPressed: onAdd,
              child: const Text('Add'),
            ),
          ],
        ),
        columns: [
          _column('Title'),
          _column('Body'),
          _column('Action')
        ],
        source: PostDataTableSource(
          context: context,
          posts: state is PostLoadedState ? state.filteredPosts : [],
          onClick: onClick,
          onDelete: onDelete,
          onEdit: onEdit,
        ),
        sortColumnIndex: state is PostLoadedState ? state.sortColumnIndex : 0,
        sortAscending: state is PostLoadedState ? state.sortAscending : true,
        rowsPerPage: 10,
        showCheckboxColumn: false,
      ),
    );
  }

  DataColumn _column(String label) {
    return DataColumn(
      label: Expanded(
        child: Text(label),
      ),
      onSort: (columnIndex, ascending) {
        _bloc.add(
          SortPostEvent(
            sortColumnIndex: columnIndex,
            sortAscending: ascending,
          ),
        );
      },
    );
  }

  //action functions
  void onClick(int id) {
    AppNavigator.push(Routes.postDetail, id);
  }

  void onDelete(int id) {
    CustomDialog(
      context: context,
      title: 'Delete Post',
      desc: 'Are you sure you want to delete this post?',
      btnOkColor: Colors.black,
      btnOkText: 'Yes',
      btnCancelText: 'No',
      btnOkOnPress: () {
        _bloc.add(DeletePostEvent(id: id, context: context));
      }
    ).show();
  }

  void onEdit(Post post) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PostFormModal(post: post, callback: (post) {
            _bloc.add(EditPostEvent(post: post));
          });
        }
    );
  }

  void onAdd() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return PostFormModal(callback: (post) {
            _bloc.add(AddPostEvent(post: post));
          });
        }
    );
  }
}