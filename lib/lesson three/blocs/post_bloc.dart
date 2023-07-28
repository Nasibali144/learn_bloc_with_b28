import 'package:bloc/bloc.dart';
import 'package:learn_bloc_with_b28/lesson%20three/models/post_model.dart';
import 'package:learn_bloc_with_b28/lesson%20three/repository/post_repository.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc({required this.repository}) : super(const PostInitial()) {

    on<FetchPostsEvent>((event, emit) async {
      emit(const PostLoading(posts: []));
      final list = await repository.getAllPost();
      emit(PostLoaded(posts: list));
    });
  }
}