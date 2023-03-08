import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_portal/application/update_post/update_post_bloc.dart';
import 'package:management_portal/domain/entities/post.dart';
import 'package:management_portal/injections.dart';
import 'package:management_portal/presentation/routes.dart';

class PostFormModal extends StatefulWidget {
  final Post? post;
  final Function(Post post) callback;
  const PostFormModal({super.key, this.post, required this.callback});
  @override
  State<PostFormModal> createState() => _PostFormModalState();
}

class _PostFormModalState extends State<PostFormModal> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final UpdatePostBloc bloc = getIt<UpdatePostBloc>();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.post?.title ?? '';
    _bodyController.text = widget.post?.body ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocConsumer<UpdatePostBloc, UpdatePostState>(
        listener: (context, state) {
          if (state is PostSuccessState) {
            widget.callback.call(state.post);
            AppNavigator.pop();
          }

          if (state is PostErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Fail to ${widget.post == null ? 'create' : 'update'} post.')),
            );
          }
        },
        builder: (context, state) {
          return  AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            scrollable: true,
            content: state is PostLoadingState ? Center(
              child: Container(
                padding: const EdgeInsets.all(30),
                color: Colors.white,
                child: const CircularProgressIndicator(),
              ),
            ) : _dialog,
          );
        },
      ),
    );
  }

  Widget get _dialog => ConstrainedBox(
    constraints: const BoxConstraints(maxWidth: 500),
    child: SizedBox(
      width: 500,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('${widget.post == null ? 'Create' : 'Edit'}  Post'),
              ),
              IconButton(
                onPressed: () => AppNavigator.pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(thickness: 0.5),
          _form(),
        ],
      ),
    ),
  );

  Widget _form() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          _avatar,
          _title,
          _body,
          _button,
        ],
      ),
    );
  }

  Widget get _avatar => Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          "assets/images/profile.jpg",
          height: 40,
        ),
      ),
      const SizedBox(width: 10),
      const Expanded(
        child: Text('John Doe', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      ),
    ],
  );

  Widget get _title => Row(
    children: [
      const Text('Title: '),
      Expanded(
        child: TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: (val) {
            setState(() {});
          },
        ),
      ),
    ],
  );

  Widget get _body =>  TextField(
    controller: _bodyController,
    keyboardType: TextInputType.multiline,
    maxLines: 5,
    decoration: const InputDecoration(
      hintText: 'Write here...',
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    ),
    onChanged: (val) {
      setState(() {});
    },
  );

  Widget get _button => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          )),
      onPressed: _titleController.text.trim().isNotEmpty && _bodyController.text.trim().isNotEmpty ? () {
        widget.post == null ? bloc.add(CreateEvent(title: _titleController.text.trim(), body: _bodyController.text.trim())) :
        bloc.add(UpdateEvent(id: widget.post!.id, title: _titleController.text.trim(), body: _bodyController.text.trim()));
      } : null,
      child: const Text(
        'Post',
        textAlign: TextAlign.center,
      ),
    ),
  );
}
