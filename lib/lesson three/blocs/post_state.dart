part of 'post_bloc.dart';

@immutable
abstract class PostState {
  final List<Post> posts;
  const PostState({required this.posts});
}

class PostInitial extends PostState {
  const PostInitial() : super(posts: const <Post>[]);
}

class PostLoading extends PostState {
  const PostLoading({required super.posts});
}

class PostError extends PostState {
  final String message;
  const PostError({required this.message ,required super.posts});
}

class PostLoaded extends PostState {
  final String? message;

  const PostLoaded({this.message, required super.posts});
}
