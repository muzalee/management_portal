# management_portal

Flutter Web Project for management portal in ddd design and bloc

## File Structure

- __application__
    - __comment__
        - [comment\_bloc.dart](application/comment/comment_bloc.dart)
        - [comment\_event.dart](application/comment/comment_event.dart)
        - [comment\_state.dart](application/comment/comment_state.dart)
    - __post__
        - [post\_bloc.dart](application/post/post_bloc.dart)
        - [post\_event.dart](application/post/post_event.dart)
        - [post\_state.dart](application/post/post_state.dart)
    - __post\_detail__
        - [post\_detail\_bloc.dart](application/post_detail/post_detail_bloc.dart)
        - [post\_detail\_event.dart](application/post_detail/post_detail_event.dart)
        - [post\_detail\_state.dart](application/post_detail/post_detail_state.dart)
    - __update\_post__
        - [update\_post\_bloc.dart](application/update_post/update_post_bloc.dart)
        - [update\_post\_event.dart](application/update_post/update_post_event.dart)
        - [update\_post\_state.dart](application/update_post/update_post_state.dart)
- __core__
    - [color\_const.dart](core/color_const.dart)
- __domain__
    - __entities__
        - [comment.dart](domain/entities/comment.dart)
        - [post.dart](domain/entities/post.dart)
- __infrastructure__
    - __repositories__
        - [comment\_repository.dart](infrastructure/repositories/comment_repository.dart)
        - [post\_repository.dart](infrastructure/repositories/post_repository.dart)
- [injections.dart](injections.dart)
- [list.md](list.md)
- [main.dart](main.dart)
- __presentation__
    - __notifier__
        - [menu\_controller.dart](presentation/notifier/menu_controller.dart)
    - __post__
        - [post\_screen.dart](presentation/post/post_screen.dart)
        - __widgets__
            - [post\_data\_table\_source.dart](presentation/post/widgets/post_data_table_source.dart)
            - [post\_form\_modal.dart](presentation/post/widgets/post_form_modal.dart)
            - [post\_table\_widget.dart](presentation/post/widgets/post_table_widget.dart)
    - __post\_detail__
        - [post\_detail\_screen.dart](presentation/post_detail/post_detail_screen.dart)
        - __widgets__
            - [comment\_list\_widget.dart](presentation/post_detail/widgets/comment_list_widget.dart)
            - [comment\_widget.dart](presentation/post_detail/widgets/comment_widget.dart)
            - [post\_widget.dart](presentation/post_detail/widgets/post_widget.dart)
    - [routes.dart](presentation/routes.dart)
    - __widgets__
        - [custom\_error\_widget.dart](presentation/widgets/custom_error_widget.dart)
        - [dialog.dart](presentation/widgets/dialog.dart)
        - [drawer\_list\_tile.dart](presentation/widgets/drawer_list_tile.dart)
        - [header.dart](presentation/widgets/header.dart)
        - [main\_nav.dart](presentation/widgets/main_nav.dart)
        - [profile\_card.dart](presentation/widgets/profile_card.dart)
        - [responsive.dart](presentation/widgets/responsive.dart)
        - [side\_menu.dart](presentation/widgets/side_menu.dart)


## Screenshots

![Post List](https://github.com/muzalee/management_portal/blob/master/screenshots/posts.png)
Posts listed in table. Pagination, searching and sorting are included.

![Delete Post](https://github.com/muzalee/management_portal/blob/master/screenshots/posts.png)
Post delete confirmation, data in the table will be updated after delete.

![Form](https://github.com/muzalee/management_portal/blob/master/screenshots/edit_create.png)
Post creation and update in modal form. Newly added or updated data will be updated in the table.

![Detail and Comment](https://github.com/muzalee/management_portal/blob/master/screenshots/detail.png)
Post details and comments.
