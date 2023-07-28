part of 'post_bloc.dart';

@immutable
abstract class PostEvent {}

class FetchPostsEvent extends PostEvent {}

class CreatePostEvent extends PostEvent {
  final String title;
  final String body;

  CreatePostEvent({required this.title, required this.body});
}

class ValidatePostEvent extends PostEvent {
  final String title;
  final String body;

  ValidatePostEvent({required this.title, required this.body});
}

class UpdatePostEvent extends PostEvent {
  final String title;
  final String body;
  final String id;

  UpdatePostEvent({required this.id, required this.body, required this.title});
}
class DeletePostEvent extends PostEvent {
  final int id;

  DeletePostEvent({required this.id});
}



